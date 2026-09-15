---
id: KB-04-asyncio-in-qt
title: "Asyncio and Qt Event Loop Coexistence"
category: architecture
subcategory: technical
tags: [asyncio, qt, event-loop, coexistence, conflict]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7]
related:
  - KB-04-separate-process-architecture
  - KB-04-qt-worker-pattern
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Technical analysis of asyncio + Qt event loop conflicts and solutions"
  key_facts:
    - "QgsApplication owns Qt event loop"
    - "FastMCP needs asyncio event loop"
    - "Two loops on same thread = conflict"
    - "Solution: separate processes"
    - "qasync/asyncqt not recommended"
  common_questions:
    - "Can I run asyncio inside QGIS?"
    - "Why does FastMCP need asyncio?"
    - "What about qasync?"
---

# Asyncio and Qt Event Loop Coexistence

## The Fundamental Conflict

```
QGIS Process (single main thread)
    │
    ├── Qt Event Loop (QgsApplication)
    │   ├── GUI events
    │   ├── Signal/slot dispatch
    │   ├── QTimer callbacks
    │   └── Processing framework
    │
    └── asyncio Event Loop (FastMCP)
        ├── stdio I/O
        ├── MCP JSON-RPC protocol
        └── Async tool handlers
    │
    └── CONFLICT: Only one event loop can run per thread
```

## Why FastMCP Needs asyncio

FastMCP's stdio transport uses async I/O:
- Reading from stdin (agent requests)
- Writing to stdout (tool responses)
- Managing concurrent tool calls

This requires `asyncio.run()` or equivalent, which takes over the thread's event loop.

## Why QGIS Needs Qt Event Loop

`QgsApplication` initializes the Qt event loop:
- GUI rendering (even headless, Qt expects its loop)
- Signal/slot mechanism (fundamental to Qt)
- `QTimer` for periodic tasks
- Processing framework callbacks

## Evaluated Solutions

| Solution | Feasibility | Risk | Chosen? |
|---|---|---|---|
| Separate process | ✅ High | Low | ✅ **YES** |
| QThread + asyncio.run() | ⚠️ Medium | Medium | ❌ No |
| qasync (replaces Qt loop) | ⚠️ Low | High | ❌ No |
| Polling (QTimer) | ⚠️ Medium | Low | ❌ No |
| asyncio in subprocess | ✅ High | Low | ✅ Same as separate process |

## Chosen Solution

**Separate processes.** See [KB-04-separate-process-architecture](separate-process-architecture.md).

Each process runs its native event loop without interference:
- MCP server process: asyncio
- QGIS bridge process: Qt

Communication via TCP (no shared event loop needed).

## ACP Client Exception

The ACP client worker runs asyncio in a **dedicated QThread** (not main thread):

```python
# This is safe because:
# 1. ACP client doesn't call PyQGIS
# 2. It runs in its own thread with its own event loop
# 3. Communication with main thread via Qt signals

class ACPClientWorker(QObject):
    @pyqtSlot()
    def start_loop(self):
        self._loop = asyncio.new_event_loop()
        asyncio.set_event_loop(self._loop)
        self._loop.run_forever()  # Safe in worker thread
```

This is acceptable because the ACP client only communicates with the agent (stdio), not with QGIS.

## Related Files

- [KB-04-separate-process-architecture](separate-process-architecture.md) — Chosen solution
- [KB-04-qt-worker-pattern](qt-worker-pattern.md) — Worker pattern
