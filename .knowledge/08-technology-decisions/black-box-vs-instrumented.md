---
id: KB-08-black-box-vs-instrumented
title: "Decision: Black Box vs Instrumented Agents"
category: technology-decisions
subcategory: decision
tags: [decision, black,box,vs,instrumented]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-04-black-box-constraint
  - KB-00-scope-and-limitations
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Black Box vs Instrumented Agents — rationale and outcome"
  key_facts:
    - "Black box: only MCP logs + output files observed; CodeGen adds code files + runtime traces; no agent internals; any agent swappable"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: Black Box vs Instrumented Agents

## Context

Whether to modify agent internals for observation

## Analysis

Instrumenting agents would: break black-box fairness, create vendor lock-in, require agent-specific code, affect timing metrics, reduce reproducibility; CLI agents don't expose internal APIs; matches real-world deployment

## Decision

Black box: only MCP logs + output files observed; CodeGen adds code files + runtime traces; no agent internals; any agent swappable

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-04-black-box-constraint
- KB-00-scope-and-limitations
