---
id: decision-9
title: Do not migrate to MCP SDK v2
date: '2026-09-30 21:42'
status: accepted
---
## Context

MCP SDK v2.0.0 (July 2026) renames `FastMCP` to `MCPServer`, removes `from mcp.server.fastmcp`, removes `get_context()` and WebSocket transport, moves synchronous handlers onto worker threads, and switches to httpx2.

## Decision

Stay on standalone fastmcp v4 (decision-8). If a legacy SDK path is ever needed, pin `mcp>=1.28,<2` explicitly rather than floating into v2.

## Consequences

The `mcp` package currently present in the `default` environment arrived as a transitive dependency at 1.30.0; that pin is accidental and should be made intentional.

Source: `.knowledge/08-technology-decisions/mcp-sdk-v2-migration.md`.
