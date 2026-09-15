---
id: KB-14-decision-security-dim
title: "Decision: Security: PB5 as First-Class Dimension"
category: decisions-log
subcategory: decision
tags: [decision, decision,security,dim]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-14-all-decisions-summary
  - KB-01-hou-et-al-2025
  - KB-10-security-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision record: Security: PB5 as First-Class Dimension"
  key_facts:
    - "Choice: Add PB5 research question. Add Layer 7 (Security) to metrics. Add 5 adversarial tasks. Add attack surface analysis. Security becomes mandatory, not optional."
    - "Rejected: Security as afterthought (original)"
  common_questions:
    - "Why was this decision made?"
    - "What was the alternative?"
---

# Decision: Security: PB5 as First-Class Dimension

## Context

Whether to include security evaluation

## Analysis

Hou et al. (2025) in ACM TOSEM (top SE journal) established MCP security as mandatory. Fan et al. (2025) showed community servers unsafe. Maloyan & Namiot (2026) demonstrated practical attacks. Zhang MSB (2025) provided attack benchmark.

## Decision

Add PB5 research question. Add Layer 7 (Security) to metrics. Add 5 adversarial tasks. Add attack surface analysis. Security becomes mandatory, not optional.

## Rejected Alternative

Security as afterthought (original)

## Rationale

Would ignore top-venue evidence; thesis incomplete

## Impact

layer7-security.md, ADV tasks, PB5

## Reversibility

Moderate — adds new RQ and metric layer

## Evidence

See related files for supporting evidence.

## Related Files

- KB-14-all-decisions-summary
- KB-01-hou-et-al-2025
- KB-10-security-overview
