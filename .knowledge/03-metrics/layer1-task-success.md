---
id: KB-03-layer1-task-success
title: "Layer 1 — Task Success Metrics"
category: metrics
subcategory: layer1
tags: [metrics, task-success, TSR, pass-at-k, completion, rejection]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3, 12]
related:
  - KB-03-metrics-overview
  - KB-00-research-questions
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Layer 1 metrics: TSR, Pass@1, Pass@3, Completion Rate, Rejection Rate"
  key_facts:
    - "TSR = primary metric for PB1"
    - "Pass@1 = single attempt, Pass@3 = any of 3 attempts"
    - "RR (Rejection Rate) added from Krechetova & Kochedykov"
    - "All metrics identical across 3 conditions"
  common_questions:
    - "What is TSR?"
    - "How is Pass@3 calculated?"
    - "What is Rejection Rate?"
---

# Layer 1 — Task Success Metrics

## Metrics

### 1. Task Success Rate (TSR)

**Formula:**
```
TSR = |{passed tasks}| / |{total tasks}|
```

**Definition:** Fraction of tasks where agent output passes OutputVerifier.

**Range:** [0, 1]

**Primary metric for:** PB1

**Computation:** OutputVerifier returns pass/fail per task. TSR = mean across tasks.

### 2. Pass@1

**Formula:**
```
Pass@1 = |{tasks passed on first attempt}| / |{total tasks}|
```

**Definition:** Fraction of tasks passed on the very first execution attempt.

**Range:** [0, 1]

**Measures:** Raw capability without self-healing.

### 3. Pass@3

**Formula:**
```
Pass@3 = |{tasks passed on at least one of 3 attempts}| / |{total tasks}|
```

**Definition:** Fraction of tasks passed in at least one of three repetitions.

**Range:** [0, 1]

**Measures:** Capability with self-healing. Gap between Pass@1 and Pass@3 indicates recovery ability.

### 4. Completion Rate

**Formula:**
```
Completion Rate = |{tasks where agent produced any output}| / |{total tasks}|
```

**Definition:** Fraction of tasks where agent produced some output file, regardless of correctness.

**Range:** [0, 1]

**Measures:** Willingness to attempt. Distinguishes "tried and failed" from "refused".

### 5. Rejection Rate (RR) ⭐ NEW

**Formula:**
```
RR = |{tasks where agent refused or declared unsolvable}| / |{total tasks}|
```

**Definition:** Fraction of tasks where agent explicitly refused to attempt.

**Range:** [0, 1]

**Source:** Krechetova & Kochedykov (2025) GeoBenchX

**Detection:** Pattern matching in agent output:
- "I cannot solve this"
- "Not possible with available tools"
- "Beyond my capabilities"
- "Insufficient information"
- "This task requires capabilities I don't have"

**Measures:** Agent confidence and honesty. High RR may indicate appropriate caution or inappropriate refusal.

## Metric Relationships

```
Completion Rate + Rejection Rate ≈ 1.0
  (small gap for timeout/crash cases)

Pass@1 ≤ Pass@3 ≤ TSR (when TSR = Pass@3)

Pass@3 - Pass@1 = Self-healing gap
  (larger gap = more recovery capability)
```

## Reporting Format

| Paradigm | Agent | Pass@1 | Pass@3 | TSR | Completion | RR |
|---|---|---|---|---|---|---|
| MCP-5 | OpenCode | 0.72 | 0.84 | 0.84 | 0.96 | 0.04 |
| MCP-15 | OpenCode | 0.76 | 0.88 | 0.88 | 0.98 | 0.02 |
| CodeGen | OpenCode | 0.68 | 0.86 | 0.86 | 0.94 | 0.06 |

## Statistical Tests

- **PB1:** One-way ANOVA on TSR (3 paradigms) + Tukey HSD
- **PB3:** Two-way ANOVA on TSR (agent × paradigm)
- **PB7:** Paired t-test on TSR (MCP-5 vs MCP-15)

## Related Files

- [KB-03-layer4-execution](layer4-execution.md) — ITS, SHR (related to Pass@1/3 gap)
- [KB-03-statistical-tests](statistical-tests.md) — Test details
