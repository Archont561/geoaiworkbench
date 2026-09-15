---
id: KB-08-polars-vs-pandas
title: "Decision: Polars vs pandas for Analysis"
category: technology-decisions
subcategory: decision
tags: [decision, polars,vs,pandas]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-06-metrics-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Polars vs pandas for Analysis — rationale and outcome"
  key_facts:
    - "Polars >=1.0 for all analysis; DuckDB for ad-hoc SQL queries; pandas not included"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: Polars vs pandas for Analysis

## Context

DataFrame library for benchmark results

## Analysis

Polars: Rust-based, 5-10x faster, native JSONL reading (read_ndjson), lazy evaluation, better memory; pandas: more ecosystem but slower, no native JSONL; GeoAIWorkbench processes 1,800 JSONL rows — Polars overkill but future-proof

## Decision

Polars >=1.0 for all analysis; DuckDB for ad-hoc SQL queries; pandas not included

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-06-metrics-implementation
