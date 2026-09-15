---
id: KB-08-decision-tool-count
title: "Decision: Tool Count: 5 vs 15 vs Unlimited"
category: technology-decisions
subcategory: decision
tags: [decision, decision,tool,count]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-01-mo-et-al-2025
  - KB-01-song-et-al-2025
  - KB-05-three-condition-experiment
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tool Count: 5 vs 15 vs Unlimited — rationale and outcome"
  key_facts:
    - "3 conditions: MCP-5 (Tier 1-2), MCP-15 (Tier 1-5), CodeGen (unlimited); GEOMCP_TIER env var; tests inverted-U hypothesis (PB7)"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: Tool Count: 5 vs 15 vs Unlimited

## Context

How many MCP tools to expose

## Analysis

Mo et al. (2025): degradation beyond ~50 tools; Song et al. (2025): MCP can hurt via context pollution; Wang et al. (2025): coherent bundles work best; Fan et al. (2026): fidelity degrades with chain length; 5 tools = paradigm-clean baseline; 15 tools = realistic GIS toolkit; both below degradation threshold

## Decision

3 conditions: MCP-5 (Tier 1-2), MCP-15 (Tier 1-5), CodeGen (unlimited); GEOMCP_TIER env var; tests inverted-U hypothesis (PB7)

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-01-mo-et-al-2025
- KB-01-song-et-al-2025
- KB-05-three-condition-experiment
