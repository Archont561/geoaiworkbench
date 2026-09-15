---
id: KB-14-decision-mcp-sdk
title: "Decision: MCP SDK: FastMCP 4.0.3 Standalone"
category: decisions-log
subcategory: decision
tags: [decision, decision,mcp,sdk]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-14-all-decisions-summary
  - KB-08-mcp-sdk-v2-migration
  - KB-08-fastmcp-standalone
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision record: MCP SDK: FastMCP 4.0.3 Standalone"
  key_facts:
    - "Choice: Use standalone fastmcp>=4.0,<5. Decorator: @mcp.tool (no parens). Run: mcp.run(). Better dynamic tool registration for tier control."
    - "Rejected: from mcp.server.fastmcp import FastMCP (v1, dead)"
  common_questions:
    - "Why was this decision made?"
    - "What was the alternative?"
---

# Decision: MCP SDK: FastMCP 4.0.3 Standalone

## Context

Whether to use mcp SDK v2 or standalone fastmcp

## Analysis

MCP SDK v2.0.0 released July 28, 2026 with breaking changes: FastMCP class renamed to MCPServer, decorator syntax changed, get_context() removed, WebSocket removed. Standalone fastmcp continued independently at v4.0.3 with stable API.

## Decision

Use standalone fastmcp>=4.0,<5. Decorator: @mcp.tool (no parens). Run: mcp.run(). Better dynamic tool registration for tier control.

## Rejected Alternative

from mcp.server.fastmcp import FastMCP (v1, dead)

## Rationale

from fastmcp import FastMCP (v4.0.3, active)

## Impact

All geo_mcp.py imports and decorators

## Reversibility

Moderate — change imports and pin

## Evidence

See related files for supporting evidence.

## Related Files

- KB-14-all-decisions-summary
- KB-08-mcp-sdk-v2-migration
- KB-08-fastmcp-standalone
