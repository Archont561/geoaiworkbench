---
id: KB-07-phase4-analysis
title: "Phase: Experiment Analysis"
category: tooling
subcategory: phase
tags: [tooling, phase, phase4,analysis]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-toolchain-overview
  - KB-06-statistics-implementation
  - KB-03-statistical-tests
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tools and workflow for Experiment Analysis"
  key_facts:
    - "Tools: Polars 1.0+, DuckDB 1.1+, scipy 1.14+, statsmodels 0.14+, matplotlib 3.9+, seaborn 0.13+"
  common_questions:
    - "What tools are used for Experiment Analysis?"
---

# Phase: Experiment Analysis

## Tools

Polars 1.0+, DuckDB 1.1+, scipy 1.14+, statsmodels 0.14+, matplotlib 3.9+, seaborn 0.13+

## Details

Polars for fast DataFrame operations on JSONL; DuckDB for direct SQL queries on JSONL files (SELECT * FROM read_json_auto); scipy for statistical tests; statsmodels for ANOVA; matplotlib+seaborn for publication plots

## Key Commands

```bash
pixi run benchmark-analyse; duckdb -c 'SELECT * FROM read_json_auto("results/*.jsonl")'
```

## Related Files

- KB-07-toolchain-overview
- KB-06-statistics-implementation
- KB-03-statistical-tests
