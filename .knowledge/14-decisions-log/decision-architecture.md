---
id: KB-14-decision-architecture
title: "Decision: Architecture: Separate MCP Process"
category: decisions-log
subcategory: decision
tags: [decision, decision,architecture]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-14-all-decisions-summary
  - KB-04-separate-process-architecture
  - KB-04-asyncio-in-qt
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision record: Architecture: Separate MCP Process"
  key_facts:
    - "Choice: Separate process: MCP server (asyncio, stdio) + QGIS bridge (Qt, TCP localhost:9876). Proven pattern. ~1-5ms IPC latency negligible."
    - "Rejected: Embedded QThread worker (original design)"
  common_questions:
    - "Why was this decision made?"
    - "What was the alternative?"
---

# Decision: Architecture: Separate MCP Process

## Context

Whether to embed MCP server in QGIS or run separately

## Analysis

FastMCP needs asyncio event loop. QGIS owns Qt event loop. Two loops on same thread = conflict. QThread+asyncio fragile. qasync unmaintained. Existing qgis-mcp uses separate process successfully.

## Decision

Separate process: MCP server (asyncio, stdio) + QGIS bridge (Qt, TCP localhost:9876). Proven pattern. ~1-5ms IPC latency negligible.

## Rejected Alternative

Embedded QThread worker (original design)

## Rationale

Asyncio+Qt event loop conflict; fragile threading

## Impact

bridge.py, plugin.py, geo_mcp.py

## Reversibility

High — requires new bridge component

## Evidence

See related files for supporting evidence.

## Related Files

- KB-14-all-decisions-summary
- KB-04-separate-process-architecture
- KB-04-asyncio-in-qt
