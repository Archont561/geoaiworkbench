---
id: decision-12
title: Polars is the DataFrame library; pandas is not included
date: '2026-09-30 21:42'
status: accepted
---
## Context

A DataFrame library for analysis over roughly 1,800 result rows.

## Decision

Polars >= 1.0 for analysis, DuckDB for ad-hoc SQL. pandas is not included.

## Consequences

Polars is admittedly oversized for 1,800 rows; it is chosen for native NDJSON reading and to avoid a second DataFrame dialect appearing later. Anything in the analysis code that assumes a pandas API is a bug.

Source: `.knowledge/08-technology-decisions/polars-vs-pandas.md`.
