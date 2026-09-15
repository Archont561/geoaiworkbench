---
id: KB-04-hook-injection-pattern
title: "Hook Injection Pattern"
category: architecture
subcategory: pattern
tags: [pattern, hook, protocol, monitor, injection, decoupling]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 7]
related:
  - KB-04-package-geoaibenchmark
  - KB-04-package-geoaiworkbench
  - KB-06-monitor-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Protocol-based hook injection for benchmark monitors"
  key_facts:
    - "geoaiworkbench defines Protocol (not concrete class)"
    - "geoaibenchmark provides concrete Monitor implementation"
    - "No compile-time dependency between packages"
    - "Fresh monitor per task run (no state leakage)"
    - "set_hook / clear_hook lifecycle"
  common_questions:
    - "How does the benchmark monitor MCP calls?"
    - "Why use Protocol instead of ABC?"
    - "How is state isolation achieved?"
---

# Hook Injection Pattern

## Problem

The benchmark needs to observe MCP tool calls without modifying the MCP server's core logic. The monitor must be:
- Injectable at runtime
- Removable after each task
- Decoupled from the server package

## Solution: Structural Protocol

### Step 1: Define Protocol in geoaiworkbench

```python
# geoaiworkbench/monitors/protocol.py
from typing import Protocol, runtime_checkable

@runtime_checkable
class MonitorHook(Protocol):
    """Protocol for benchmark monitors.

    geoaiworkbench defines this interface.
    geoaibenchmark provides the implementation.
    No import dependency between packages.
    """
    def wrap(
        self,
        tool_name: str,
        params: dict,
        result: dict,
        duration_ms: float,
    ) -> None: ...
```

### Step 2: Server Exposes Hook Methods

```python
# geoaiworkbench/geo_mcp.py
class GeoMCP:
    def __init__(self):
        self._hook: MonitorHook | None = None

    def set_hook(self, hook: MonitorHook) -> None:
        """Inject a benchmark monitor."""
        self._hook = hook

    def clear_hook(self) -> None:
        """Remove the benchmark monitor."""
        self._hook = None

    def _execute_tool(self, tool_name, params):
        """Internal tool execution with optional monitoring."""
        start = time.time()
        result = self._dispatch(tool_name, params)
        duration = (time.time() - start) * 1000

        if self._hook is not None:
            self._hook.wrap(tool_name, params, result, duration)

        return result
```

### Step 3: Benchmark Provides Implementation

```python
# geoaibenchmark/monitors/mcp_monitor.py
class MCPMonitor:
    """Concrete monitor satisfying MonitorHook protocol.

    Note: Does NOT import MonitorHook from geoaiworkbench.
    Satisfies the protocol structurally (duck typing).
    """
    def __init__(self, task_id: str, agent_name: str, attempt: int):
        self.task_id = task_id
        self.agent_name = agent_name
        self.attempt = attempt
        self.events: list[MonitorEvent] = []

    def wrap(self, tool_name, params, result, duration_ms):
        """Called by GeoMCP after each tool execution."""
        event = MonitorEvent(
            event_type="mcp_tool_call",
            tool_or_endpoint=tool_name,
            params=params,
            result=result,
            duration_ms=duration_ms,
            # ... other fields
        )
        self.events.append(event)
        log.info("mcp_tool_call", tool=tool_name, duration_ms=duration_ms)
```

### Step 4: Harness Orchestrates Lifecycle

```python
# geoaibenchmark/benchmark/harness.py
class BenchmarkHarness:
    def run_task(self, task, agent, paradigm, attempt):
        monitor = MCPMonitor(task.task_id, agent, attempt)

        try:
            # Inject fresh monitor
            self.plugin.set_hook(monitor)

            # Run task (agent calls MCP tools, monitor records)
            result = self.plugin.run_task(task, agent)

            return result
        finally:
            # ALWAYS remove monitor (no state leakage)
            self.plugin.clear_hook()
```

## Benefits

| Benefit | How |
|---|---|
| **No compile-time coupling** | geoaibenchmark never imports geoaiworkbench internals |
| **Testability** | Monitor can be tested with mock hook |
| **State isolation** | Fresh monitor per task, cleared in `finally` |
| **Swappability** | Different monitors for different conditions |
| **Minimal server impact** | Single `if self._hook` check per tool call |

## ACP Hook Variant

For ACP client monitoring, a similar pattern with different protocol:

```python
class ACPHook(Protocol):
    def on_session_start(self, session_id: str) -> None: ...
    def on_tool_request(self, tool: str, params: dict) -> None: ...
    def on_session_end(self, session_id: str) -> None: ...
```

## Related Files

- [KB-06-monitor-implementation](../06-implementation/monitor-implementation.md) — Full monitor code
- [KB-06-harness-implementation](../06-implementation/harness-implementation.md) — Harness lifecycle
