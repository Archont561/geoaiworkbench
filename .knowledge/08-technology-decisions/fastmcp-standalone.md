---
id: KB-08-fastmcp-standalone
title: "Decision: FastMCP Standalone vs MCP SDK"
category: technology-decisions
subcategory: decision
tags: [decision, fastmcp,standalone]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-15-fastmcp-docs
  - KB-08-mcp-sdk-v2-migration
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "FastMCP Standalone vs MCP SDK — rationale and outcome"
  key_facts:
    - "Use standalone fastmcp>=4.0,<5; @mcp.tool decorator (no parens); mcp.run() for stdio; better dynamic tool registration for tier control"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: FastMCP Standalone vs MCP SDK

## Context

Whether to use mcp.server.fastmcp (v1) or standalone fastmcp package

## Analysis

FastMCP 1.0 was incorporated into mcp SDK in 2024 but standalone project continued independently; mcp SDK v2 removed FastMCP class entirely; standalone fastmcp now at v4.0.3 with stable API

## Decision

Use standalone fastmcp>=4.0,<5; @mcp.tool decorator (no parens); mcp.run() for stdio; better dynamic tool registration for tier control

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
- KB-08-mcp-sdk-v2-migration
