---
id: KB-04-separate-process-architecture
title: "Separate MCP Process Architecture"
category: architecture
subcategory: design-decision
tags: [architecture, separate-process, asyncio, qt, event-loop, decision]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-04-system-architecture
  - KB-04-asyncio-in-qt
  - KB-04-bridge-tcp-protocol
  - backlog-decision-3
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Why the MCP server runs as a separate process from QGIS"
  key_facts:
    - "FastMCP needs asyncio event loop"
    - "QGIS owns Qt event loop on main thread"
    - "asyncio + Qt in same process = fragile"
    - "Existing qgis-mcp uses same pattern"
    - "TCP bridge connects the two processes"
  common_questions:
    - "Why not embed MCP server in QGIS?"
    - "What is the alternative?"
    - "How do the processes communicate?"
---

# Separate MCP Process Architecture

## The Problem

FastMCP (and the MCP protocol) requires an **asyncio event loop** for stdio transport. QGIS owns the **Qt event loop** on the main thread. Running both in the same process creates conflicts:

```
QGIS Main Thread
    │
    ├── Qt Event Loop (owned by QgsApplication)
    │   └── GUI events, signal/slot, Processing
    │
    └── asyncio Event Loop (needed by FastMCP)
        └── stdio I/O, MCP protocol
        └── CONFLICT: two event loops on same thread
```

## Rejected Alternatives

### Alternative A: QThread Worker (Original Design)

```
QGIS Main Thread (Qt event loop)
    │
    └── QThread Worker
        └── asyncio.run() in worker thread
        └── FastMCP server
```

**Problems:**
- `asyncio.run()` in non-main thread is fragile
- Qt objects have thread affinity — can't call PyQGIS from worker
- Signal/slot across threads requires careful marshaling
- Existing qgis-mcp tried this and moved to separate process

### Alternative B: qasync / asyncqt

```
QGIS Main Thread
    └── qasync.QEventLoop (replaces Qt event loop)
        └── Both Qt and asyncio events
```

**Problems:**
- `qasync` is not actively maintained
- Replacing Qt event loop risks QGIS stability
- Not recommended by QGIS developers

### Alternative C: Polling

```
QGIS Main Thread
    └── QTimer polls for MCP requests every 100ms
```

**Problems:**
- High latency (100ms minimum per tool call)
- Wastes CPU
- Not real-time

## Chosen Solution: Separate Process + TCP Bridge

```
Process 1: MCP Server (Python)
    │
    ├── asyncio event loop
    ├── FastMCP 4.0.3
    ├── stdio transport (to CLI agent)
    └── TCP client (to QGIS bridge)
    │
    │ TCP localhost:9876
    │ JSON-RPC
    │
Process 2: QGIS Bridge (Python + Qt)
    │
    ├── Qt event loop (main thread)
    ├── QgsApplication
    ├── TCP server (from MCP server)
    └── PyQGIS / Processing execution
```

**Benefits:**
- Clean event loop separation
- Each process uses its native event model
- Proven pattern (qgis-mcp v0.3.1 uses same approach)
- Crash isolation (MCP crash doesn't kill QGIS)
- Benchmark isolation (easier to monitor)

**Tradeoffs:**
- IPC latency (TCP round-trip ~1-5ms, negligible vs LLM inference ~seconds)
- Two processes to manage
- Serialization overhead (JSON)

## Process Lifecycle

```
1. Benchmark harness starts QGIS bridge:
   $ pixi run qgis-bridge
   → QGIS initializes, TCP server listens on :9876

2. Benchmark harness starts MCP server:
   $ GEOMCP_TIER=5 pixi run mcp-server
   → FastMCP starts, connects to QGIS bridge via TCP

3. CLI agent connects to MCP server via stdio:
   $ opencode acp  (stdio MCP)
   → Agent discovers tools, starts calling them

4. Tool call flow:
   Agent → stdio → MCP Server → TCP → QGIS Bridge → PyQGIS → result → back

5. After task completion:
   → MCP server process exits
   → QGIS bridge stays alive for next task
```

## Related Files

- [KB-04-bridge-tcp-protocol](bridge-tcp-protocol.md) — TCP protocol details
- [KB-04-asyncio-in-qt](asyncio-in-qt.md) — Event loop analysis
- backlog `decision-3` — Decision rationale
