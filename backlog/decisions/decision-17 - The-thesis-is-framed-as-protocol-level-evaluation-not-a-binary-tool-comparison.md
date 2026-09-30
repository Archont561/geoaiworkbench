---
id: decision-17
title: >-
  The thesis is framed as protocol-level evaluation, not a binary tool
  comparison
date: '2026-09-30 21:50'
status: accepted
---
## Context

The original framing was "is MCP better than code generation?" — binary, and answerable only with "it depends". Round 2 literature (Hou TOSEM, Fan AAMAS, the Ehtesham survey) evaluates protocols along several axes instead.

## Decision

Frame the work as: how does MCP as a tool-integration protocol affect interoperability, planning, parameterisation, output validity and security in GIS automation? Five evaluation dimensions, positioned at the protocol level rather than at a tool comparison.

## Consequences

Same data, different claim: nothing in the experimental design changes, but the results tables are organised by dimension and a per-dimension result that contradicts the headline stops being an embarrassment and becomes the finding. Reversal is cheap — it is a framing, not a measurement.

Detail lives in `.knowledge/02-research-design/evaluation-dimensions.md` and `.knowledge/11-thesis/thesis-structure.md`.

Supersedes `.knowledge/14-decisions-log/decision-thesis-framing.md` — deleted from the knowledge base; this decision is that content.
