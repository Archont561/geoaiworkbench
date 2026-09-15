---
id: KB-08-pydantic-v2-choice
title: "Decision: Pydantic v2 vs Dataclasses"
category: technology-decisions
subcategory: decision
tags: [decision, pydantic,v2,choice]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-06-models-pydantic
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Pydantic v2 vs Dataclasses — rationale and outcome"
  key_facts:
    - "Pydantic v2 only; no dataclasses; Annotated types with Field constraints; @field_validator for cross-field checks"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: Pydantic v2 vs Dataclasses

## Context

Data validation framework

## Analysis

dataclasses lack: validation, serialization, JSON schema generation, type coercion; Pydantic v2 is 5-10x faster than v1 (Rust core); FastMCP requires Pydantic for tool schemas; validators (gt=0, regex) critical for paradigm boundary

## Decision

Pydantic v2 only; no dataclasses; Annotated types with Field constraints; @field_validator for cross-field checks

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-06-models-pydantic
