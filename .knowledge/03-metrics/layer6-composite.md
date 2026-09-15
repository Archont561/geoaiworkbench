---
id: KB-03-layer6-composite
title: "Layer 6 — Composite Scores"
category: metrics
subcategory: layer6
tags: [metrics, composite, weighted-score, cost-performance, reliability]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3]
related:
  - KB-03-metrics-overview
  - KB-01-diaz-ireland-et-al-2026
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Layer 6 composite scores combining multiple metrics"
  key_facts:
    - "Weighted Task Score combines Layers 1-5"
    - "Cost-Performance Ratio from Díaz-Ireland et al."
    - "Difficulty-Adjusted Score normalizes by task difficulty"
    - "Reliability Index combines ED and SHR"
  common_questions:
    - "What is the overall score?"
    - "How is cost-performance calculated?"
    - "Which composite is most important?"
---

# Layer 6 — Composite Scores

## Metrics

### 1. Weighted Task Score (WTS)

**Formula:**
```
WTS = 0.30 × TSR + 0.25 × OQS + 0.20 × PCS + 0.15 × PEA + 0.10 × ED
```

**Range:** [0, 1]

**Rationale:** Balances success, quality, workflow, parameters, and determinism.

**Weights justified by:**
- TSR (30%) — Most important practical metric
- OQS (25%) — Output quality matters for GIS
- PCS (20%) — Partial credit for complex tasks
- PEA (15%) — Parameter correctness
- ED (10%) — Reproducibility

### 2. Difficulty-Adjusted Score (DAS)

**Formula:**
```
DAS = Σ(TSR_difficulty × difficulty_weight) / Σ(difficulty_weight)
```

**Difficulty weights:**
- Basic: 1.0
- Intermediate: 2.0
- Advanced: 3.0

**Purpose:** Rewards paradigms that perform well on hard tasks, not just easy ones.

### 3. Cost-Performance Ratio (CPR) ⭐ KEY for PB3

**Formula:**
```
CPR = TSR / mean_tokens_per_task
```

**Units:** Success rate per 1000 tokens

**Source:** Díaz-Ireland et al. (2026) cost-accuracy Pareto analysis

**Purpose:** Identifies most cost-effective agent-paradigm combinations.

**Expected pattern:**
- MCP-5: High CPR (low tokens, decent success)
- MCP-15: Medium CPR (more tokens for schemas)
- CodeGen: Variable CPR (depends on code length)

### 4. Reliability Index (RI)

**Formula:**
```
RI = 0.60 × ED + 0.40 × SHR
```

**Range:** [0, 1]

**Purpose:** Combines determinism and self-healing into single reliability measure.

**Expected pattern:** MCP-5 > MCP-15 > CodeGen

## Reporting Format

| Paradigm | Agent | WTS | DAS | CPR | RI |
|---|---|---|---|---|---|
| MCP-5 | OpenCode | 0.78 | 0.72 | 0.45 | 0.82 |
| MCP-15 | OpenCode | 0.81 | 0.79 | 0.38 | 0.76 |
| CodeGen | OpenCode | 0.75 | 0.80 | 0.28 | 0.65 |

## Related Files

- [KB-01-diaz-ireland-et-al-2026](../01-literature/papers/diaz-ireland-et-al-2026.md) — CPR basis
- [KB-03-layer1-task-success](layer1-task-success.md) — TSR component
- [KB-03-layer4-execution](layer4-execution.md) — ED component
