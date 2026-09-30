---
id: decision-11
title: DuckDB queries the JSONL results; SQLite is not used
date: '2026-09-30 21:42'
status: accepted
---
## Context

A query engine for the JSONL result stream produced by 1,800 runs.

## Decision

DuckDB >= 1.1, querying the JSONL directly with `read_json_auto`. JSONL stays the canonical source; SQLite is not used.

## Consequences

No import step means no second copy of the results that can drift from the first. DuckDB becomes an analysis-environment dependency this repository must declare.

Source: `.knowledge/08-technology-decisions/duckdb-vs-sqlite.md`.
