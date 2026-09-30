---
id: decision-4
title: 'The bridge between the MCP server and QGIS is TCP JSON-RPC on localhost:9876'
date: '2026-09-30 21:42'
status: accepted
---
## Context

Given a separate MCP process (decision-3), the two halves need a transport that a Qt event loop can serve without an asyncio bridge.

## Decision

TCP JSON-RPC on `localhost:9876`, the transport qgis-mcp already uses in production. Not a Unix socket (Windows parity), not shared memory (no framing), not HTTP (a second server stack for a single local peer).

## Consequences

The port number becomes configuration this repository owns, and the bridge needs contract tests on both sides. A port collision is a startup failure that must report clearly rather than hang.

Source: `.knowledge/04-architecture/bridge-tcp-protocol.md`, `.knowledge/04-architecture/qt-worker-pattern.md`.
