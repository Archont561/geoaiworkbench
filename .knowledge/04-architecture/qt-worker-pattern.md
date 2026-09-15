---
id: KB-04-qt-worker-pattern
title: "Qt Worker Object Pattern"
category: architecture
subcategory: pattern
tags: [qt, worker, qthread, moveToThread, pattern]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5]
related:
  - KB-04-separate-process-architecture
  - KB-04-bridge-tcp-protocol
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Qt recommended worker pattern for QGIS threading"
  key_facts:
    - "QObject + moveToThread() (NOT QThread subclassing)"
    - "Qt recommended pattern"
    - "Used for ACP client worker"
    - "MCP server is separate process (not QThread)"
  common_questions:
    - "How does QGIS handle threading?"
    - "Why not subclass QThread?"
    - "Where is this pattern used?"
---

# Qt Worker Object Pattern

## The Pattern

Qt's recommended approach for background work: create a `QObject` worker and move it to a `QThread`.

```python
# CORRECT: Worker object pattern
class MyWorker(QObject):
    finished = pyqtSignal()
    result = pyqtSignal(dict)

    @pyqtSlot()
    def do_work(self):
        # Runs in worker thread
        result = expensive_computation()
        self.result.emit(result)
        self.finished.emit()

# Usage
thread = QThread()
worker = MyWorker()
worker.moveToThread(thread)
thread.started.connect(worker.do_work)
worker.finished.connect(thread.quit)
thread.start()
```

## What NOT to Do

```python
# WRONG: Subclassing QThread
class MyThread(QThread):
    def run(self):
        # This works but is NOT recommended by Qt
        # Signal/slot connections are confusing
        ...
```

**Why:** Qt documentation explicitly recommends the worker object pattern. Subclassing `QThread` conflates the thread management object with the work being done.

## Usage in GeoAIWorkbench

### Where Used: ACP Client Worker

```python
# geoaiworkbench/acp_client_worker.py
class ACPClientWorker(QObject):
    """ACP client running in a dedicated thread with persistent asyncio loop."""

    session_started = pyqtSignal(str)
    tool_result = pyqtSignal(dict)

    @pyqtSlot()
    def start_loop(self):
        """Create and run persistent asyncio event loop."""
        self._loop = asyncio.new_event_loop()
        asyncio.set_event_loop(self._loop)
        self._loop.run_forever()

    def submit_task(self, coro):
        """Submit async task from main thread."""
        future = asyncio.run_coroutine_threadsafe(coro, self._loop)
        return future
```

### Where NOT Used: MCP Server

The MCP server is a **separate process**, not a QThread worker. See [KB-04-separate-process-architecture](separate-process-architecture.md).

## Thread Affinity Rules

1. **PyQGIS objects** have main thread affinity — must be accessed from QGIS main thread
2. **Qt signals** can cross threads (queued connection)
3. **TCP bridge** receives requests in worker thread, dispatches to main thread via signal
4. **MCP server** runs in completely separate process (no thread affinity issues)

## Related Files

- [KB-04-bridge-tcp-protocol](bridge-tcp-protocol.md) — Main thread dispatch
- [KB-04-separate-process-architecture](separate-process-architecture.md) — MCP server process
