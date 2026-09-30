---
id: TASK-4
title: Declare the analysis toolchain in pixi.toml
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
updated_date: '2026-09-30 21:53'
labels:
  - orchestration
  - environment
milestone: m-3
dependencies: []
documentation:
  - .knowledge/07-tooling/phase4-analysis.md
  - .knowledge/03-metrics/statistical-tests.md
priority: medium
ordinal: 4000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Layers 1-7 of the metrics framework and the statistical plan name concrete libraries — DuckDB for querying the JSONL result stream, Polars for the DataFrames, scipy and statsmodels for the tests — and none of them is in any environment today. The analysis half of the project currently has no environment to run in, which is discovered at week 6 rather than now. decision-11 and decision-12 fix the choices; this is the manifest change that makes them real.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 pixi.toml declares duckdb>=1.1, polars>=1.0, scipy and statsmodels, and pixi.lock records a solve containing them
- [ ] #2 The analysis dependencies live in their own feature, so the bun environment and any non-analysis solve do not carry them
- [ ] #3 pandas and sqlite are absent from the analysis feature, per decision-11 and decision-12
- [ ] #4 A smoke check proves the stack imports and that DuckDB can read_json_auto a sample JSONL from the repository
<!-- AC:END -->
