---
id: KB-08-separate-process-decision
title: "Decision: Separate MCP Process vs Embedded"
category: technology-decisions
subcategory: decision
tags: [decision, separate,process,decision]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-04-separate-process-architecture
  - KB-04-asyncio-in-qt
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Separate MCP Process vs Embedded — rationale and outcome"
  key_facts:
    - "Separate process: MCP server (asyncio) + QGIS bridge (Qt) connected via TCP localhost:9876; proven pattern; ~1-5ms IPC latency negligible vs LLM seconds"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: Separate MCP Process vs Embedded

## Context

Whether to run MCP server inside QGIS process

## Analysis

FastMCP needs asyncio event loop; QGIS owns Qt event loop; two loops on same thread = conflict; QThread+asyncio.run() fragile; qasync unmaintained; existing qgis-mcp uses separate process; crash isolation benefit

## Decision

Separate process: MCP server (asyncio) + QGIS bridge (Qt) connected via TCP localhost:9876; proven pattern; ~1-5ms IPC latency negligible vs LLM seconds

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-04-separate-process-architecture
- KB-04-asyncio-in-qt
