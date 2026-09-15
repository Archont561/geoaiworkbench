---
id: KB-08-duckdb-vs-sqlite
title: "Decision: DuckDB vs SQLite for Queries"
category: technology-decisions
subcategory: decision
tags: [decision, duckdb,vs,sqlite]
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
  primary_purpose: "DuckDB vs SQLite for Queries — rationale and outcome"
  key_facts:
    - "DuckDB >=1.1 for all queries; JSONL remains canonical source; SQLite not used"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: DuckDB vs SQLite for Queries

## Context

Query engine for JSONL results

## Analysis

DuckDB: queries JSONL directly (read_json_auto), no import step, columnar storage, faster aggregations, spatial extension available; SQLite: requires import step, row-based, more setup

## Decision

DuckDB >=1.1 for all queries; JSONL remains canonical source; SQLite not used

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
