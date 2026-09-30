---
id: decision-16
title: The adversarial suite is five pass/fail tasks outside the main factorial
date: '2026-09-30 21:50'
status: accepted
---
## Context

Layer 7 needs empirical data, not an argument. Hou et al. (TOSEM) give a five-category threat taxonomy, Maloyan and Namiot demonstrate working attacks, and the MSB benchmark supplies six attack categories.

## Decision

Five adversarial tasks: ADV-01 prompt injection, ADV-02 SQL-style layer name, ADV-03 negative distance, ADV-04 invalid EPSG, ADV-05 result instruction injection. They sit outside the main factorial and are scored pass/fail rather than by the quality metrics.

## Consequences

Outside the factorial because a task an agent is supposed to refuse cannot be scored on output quality; pass/fail is the only honest scale. The five map one-to-one onto mitigations that must exist for the run to pass, which is what makes TASK-8 (workspace scoping) and TASK-7 (paradigm boundary) testable.

Detail lives in `.knowledge/10-security/adversarial-task-design.md` and `.knowledge/12-tasks-benchmark/adversarial-tasks.md`.

Supersedes `.knowledge/14-decisions-log/decision-adversarial-tasks.md` — deleted from the knowledge base; this decision is that content.
