---
id: KB-14-decision-tool-count-expansion
title: "Decision: Tool Count: 3-Condition Experiment"
category: decisions-log
subcategory: decision
tags: [decision, decision,tool,count,expansion]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-14-all-decisions-summary
  - KB-01-mo-et-al-2025
  - KB-01-song-et-al-2025
  - KB-05-three-condition-experiment
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision record: Tool Count: 3-Condition Experiment"
  key_facts:
    - "Choice: Add MCP-15 (Tier 1-5, 15 tools) alongside MCP-5 (Tier 1-2, 5 tools). Add PB7 research question. 3 conditions × 4 agents × 50 tasks × 3 reps = 1,800 runs. GEOMCP_TIER env var for runtime control."
    - "Rejected: 2 conditions only: MCP-5 vs CodeGen (original)"
  common_questions:
    - "Why was this decision made?"
    - "What was the alternative?"
---

# Decision: Tool Count: 3-Condition Experiment

## Context

Whether to add MCP-15 as second MCP condition

## Analysis

Mo et al. (2025, KDD) showed tool selection degrades beyond ~50 tools. Song et al. (2025) showed MCP can hurt via context pollution. Fan et al. (2026, AAMAS) formalized information degradation. No GIS-specific tool count study exists. 5 tools criticized as unrealistically limited.

## Decision

Add MCP-15 (Tier 1-5, 15 tools) alongside MCP-5 (Tier 1-2, 5 tools). Add PB7 research question. 3 conditions × 4 agents × 50 tasks × 3 reps = 1,800 runs. GEOMCP_TIER env var for runtime control.

## Rejected Alternative

2 conditions only: MCP-5 vs CodeGen (original)

## Rationale

Would miss tool count effect; 5 tools criticized

## Impact

geo_mcp.py tier control, PB7, 600 additional runs

## Reversibility

Moderate — adds condition but uses same code

## Evidence

See related files for supporting evidence.

## Related Files

- KB-14-all-decisions-summary
- KB-01-mo-et-al-2025
- KB-01-song-et-al-2025
- KB-05-three-condition-experiment
