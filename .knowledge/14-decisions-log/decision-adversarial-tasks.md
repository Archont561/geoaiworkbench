---
id: KB-14-decision-adversarial-tasks
title: "Decision: Adversarial Tasks: ADV-01 to ADV-05"
category: decisions-log
subcategory: decision
tags: [decision, decision,adversarial,tasks]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-14-all-decisions-summary
  - KB-09-adversarial-tests
  - KB-10-adversarial-task-design
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision record: Adversarial Tasks: ADV-01 to ADV-05"
  key_facts:
    - "Choice: 5 tasks: ADV-01 (prompt injection), ADV-02 (SQL-style layer name), ADV-03 (negative distance), ADV-04 (invalid EPSG), ADV-05 (result instruction injection). Separate from main factorial. Pass/fail evaluation."
    - "Rejected: No adversarial testing (original)"
  common_questions:
    - "Why was this decision made?"
    - "What was the alternative?"
---

# Decision: Adversarial Tasks: ADV-01 to ADV-05

## Context

Design of security evaluation tasks

## Analysis

Based on Hou et al. TOSEM taxonomy (5 threat categories) + Maloyan & Namiot attack implementations + Zhang MSB (6 attack categories). Need concrete tasks that test: prompt injection, parameter manipulation, CRS handling, result injection.

## Decision

5 tasks: ADV-01 (prompt injection), ADV-02 (SQL-style layer name), ADV-03 (negative distance), ADV-04 (invalid EPSG), ADV-05 (result instruction injection). Separate from main factorial. Pass/fail evaluation.

## Rejected Alternative

No adversarial testing (original)

## Rationale

PB5 would have no empirical data

## Impact

tasks/adversarial/, adversarial-tests.md

## Reversibility

Low — additive tasks

## Evidence

See related files for supporting evidence.

## Related Files

- KB-14-all-decisions-summary
- KB-09-adversarial-tests
- KB-10-adversarial-task-design
