---
id: KB-08-mcp-sdk-v2-migration
title: "Decision: MCP SDK v1 → v2 Migration"
category: technology-decisions
subcategory: decision
tags: [decision, mcp,sdk,v2,migration]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-15-fastmcp-docs
  - KB-08-fastmcp-standalone
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "MCP SDK v1 → v2 Migration — rationale and outcome"
  key_facts:
    - "Use standalone fastmcp v4.0.3 instead of mcp SDK v2; pin mcp>=1.28,<2 if legacy needed; update all imports and decorator syntax"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: MCP SDK v1 → v2 Migration

## Context

MCP SDK v2.0.0 released July 28, 2026 with breaking changes

## Analysis

FastMCP → MCPServer class rename; from mcp.server.fastmcp import removed; get_context() removed; WebSocket transport removed; synchronous handlers now on worker threads; httpx → httpx2; protocol-level: ping removed, roots/sampling deprecated

## Decision

Use standalone fastmcp v4.0.3 instead of mcp SDK v2; pin mcp>=1.28,<2 if legacy needed; update all imports and decorator syntax

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-15-fastmcp-docs
- KB-08-fastmcp-standalone
