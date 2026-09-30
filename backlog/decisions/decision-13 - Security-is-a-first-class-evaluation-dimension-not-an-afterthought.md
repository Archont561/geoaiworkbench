---
id: decision-13
title: 'Security is a first-class evaluation dimension, not an afterthought'
date: '2026-09-30 21:42'
status: accepted
---
## Context

Whether to evaluate security at all. Hou et al. (2025, ACM TOSEM) established MCP security as mandatory; Fan et al. (2025) showed community servers are unsafe; Maloyan and Namiot (2026) demonstrated practical attacks.

## Decision

Security is a first-class dimension: research question PB5, Layer 7 of the metrics framework, five adversarial tasks (ADV-01 prompt injection, ADV-02 SQL-style layer name, ADV-03 negative distance, ADV-04 invalid EPSG, ADV-05 result instruction injection) evaluated pass/fail outside the main factorial, and an attack-surface analysis per condition.

## Consequences

The largest structural difference between the paradigms — CodeGen executes arbitrary PyQGIS, MCP executes validated calls — now carries a cost rather than reading as pure flexibility. The paradigm boundary (no `execute_code` tool, ever) becomes an invariant with a test attached.

Source: `.knowledge/14-decisions-log/decision-security-dim.md`, `.knowledge/10-security/security-overview.md`, `.knowledge/14-decisions-log/decision-adversarial-tasks.md`.
