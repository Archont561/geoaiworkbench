---
id: KB-14-decision-metrics-additions
title: "Decision: Metrics: PEA, SHR, ITS, RR Additions"
category: decisions-log
subcategory: decision
tags: [decision, decision,metrics,additions]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-14-all-decisions-summary
  - KB-03-metrics-overview
  - KB-01-yu-et-al-2026
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision record: Metrics: PEA, SHR, ITS, RR Additions"
  key_facts:
    - "Choice: Add PEA to Layer 2, SHR and ITS to Layer 4/5, RR to Layer 1. Total metrics: ~28 across 7 layers."
    - "Rejected: Basic TSR + OQS only (original)"
  common_questions:
    - "Why was this decision made?"
    - "What was the alternative?"
---

# Decision: Metrics: PEA, SHR, ITS, RR Additions

## Context

Which additional metrics to include beyond basic TSR/OQS

## Analysis

Round 1 literature revealed: Yu et al. (2026) PEA critical for GIS. Mansourian & Oucheikh (2026) SHR and ITS for self-healing. Krechetova & Kochedykov (2025) RR for rejection behavior. All validated by multiple papers.

## Decision

Add PEA to Layer 2, SHR and ITS to Layer 4/5, RR to Layer 1. Total metrics: ~28 across 7 layers.

## Rejected Alternative

Basic TSR + OQS only (original)

## Rationale

Would miss parameter correctness, self-healing, rejection patterns

## Impact

metrics.py, all layer files

## Reversibility

Low — additive, no breaking changes

## Evidence

See related files for supporting evidence.

## Related Files

- KB-14-all-decisions-summary
- KB-03-metrics-overview
- KB-01-yu-et-al-2026
