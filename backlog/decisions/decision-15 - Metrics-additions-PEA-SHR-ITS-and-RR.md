---
id: decision-15
title: 'Metrics additions: PEA, SHR, ITS and RR'
date: '2026-09-30 21:50'
status: accepted
---
## Context

The original plan measured task success rate and an output quality score and nothing else. Round 1 literature showed that leaves the most GIS-specific failure mode unmeasured: an agent that calls the right tool with the wrong parameter.

## Decision

Add parameter accuracy (PEA) to Layer 2, self-healing rate (SHR) and iterations-to-success (ITS) to Layers 4 and 5, and rejection rate (RR) to Layer 1. Roughly 28 metrics across the seven layers, every one of them computable in all three conditions.

## Consequences

Additive and low-risk: no metric was removed, and nothing in the earlier design becomes invalid. The constraint it imposes is that a metric with no CodeGen analogue cannot be primary, because the central comparison has to stay comparable.

Supersedes: basic TSR + OQS only. Detail lives in `.knowledge/03-metrics/` (layers 1-7 and statistical-tests).

Supersedes `.knowledge/14-decisions-log/decision-metrics-additions.md` — deleted from the knowledge base; this decision is that content.
