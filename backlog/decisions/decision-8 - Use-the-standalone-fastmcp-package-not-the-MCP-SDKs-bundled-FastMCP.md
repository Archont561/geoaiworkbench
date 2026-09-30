---
id: decision-8
title: 'Use the standalone fastmcp package, not the MCP SDK''s bundled FastMCP'
date: '2026-09-30 21:42'
status: accepted
---
## Context

FastMCP 1.0 was absorbed into the MCP SDK in 2024, but the standalone project continued independently and the SDK v2 removed the `FastMCP` class entirely.

## Decision

Use standalone `fastmcp>=4.0,<5`: the bare `@mcp.tool` decorator, `mcp.run()` for stdio, and its dynamic registration API, which is what makes runtime tier control (decision-7) straightforward.

## Consequences

Imports come from `fastmcp`, never `mcp.server.fastmcp`. The dependency must be declared in `pixi.toml` deliberately rather than arriving transitively.

Supersedes `.knowledge/08-technology-decisions/fastmcp-standalone.md` — deleted from the knowledge base; this decision is that content.
