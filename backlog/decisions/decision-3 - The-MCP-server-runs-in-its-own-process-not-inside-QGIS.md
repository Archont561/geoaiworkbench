---
id: decision-3
title: 'The MCP server runs in its own process, not inside QGIS'
date: '2026-09-30 21:42'
status: accepted
---
## Context

FastMCP needs an asyncio event loop; QGIS owns a Qt event loop. Two loops on one thread conflict, `QThread` + `asyncio.run()` is fragile, and qasync is unmaintained.

## Decision

Run the MCP server as its own process and talk to QGIS over IPC. The existing qgis-mcp project proves the pattern, and the ~1-5 ms IPC latency is negligible against LLM response times measured in seconds.

## Consequences

Crash isolation comes for free: a QGIS segfault no longer takes the server with it. The cost is a transport to define, a second process to supervise, and a bridge to test. Blocks TASK-2.

Source: `.knowledge/08-technology-decisions/separate-process-decision.md`, `.knowledge/04-architecture/separate-process-architecture.md`, `.knowledge/04-architecture/asyncio-in-qt.md`.
