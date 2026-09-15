---
id: KB-01-fan-et-al-2026
title: "Fan et al. (2026) — Information Fidelity Martingale (AAMAS)"
category: literature
subcategory: paper-summary
tags: [fan, mcp, information-fidelity, martingale, aamas, theoretical, KEY]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14]
related:
  - KB-01-round2-additions
  - KB-00-research-questions
authoritative: false
implementation_status: specified
references:
  - fan2026infofidelity
llm_hints:
  primary_purpose: "FORMAL MODEL of MCP information degradation using martingale analysis (AAMAS)"
  key_facts:
    - "Published in AAMAS 2026 (top agent venue)"
    - "Formal martingale model of information degradation"
    - "Predicts fidelity drops with chain length"
    - "Theoretical basis for PB6 (optional)"
  common_questions:
    - "What is information fidelity?"
    - "What is a martingale?"
    - "How does GeoAIWorkbench use this?"
---

# Fan et al. (2026) — Information Fidelity Martingale ⭐ THEORETICAL FOUNDATION

## Full Citation

Fan, F. X., Tan, C., Wattenhofer, R., & Ong, Y. (2026). Information Fidelity in Tool-Using LLM Agents: A Martingale Analysis of the Model Context Protocol. *Proc. of the 25th International Conference on Autonomous Agents and Multiagent Systems*.

## Venue Significance

**⭐ AAMAS** (Autonomous Agents and Multiagent Systems) is the top venue for agent research. Publication here means:
- Theoretically rigorous agent analysis
- Formal model of MCP behavior
- Prediction that can be empirically tested

## What This Paper Says

Formal mathematical model of information degradation across MCP tool chains. Uses martingale analysis to predict how information fidelity decreases as chain length increases.

### Martingale Model

**Concept:**
Information passed through tool chains behaves like a martingale — each step is a "fair game" but expected value decreases over time due to noise, misinterpretation, and error accumulation.

**Formal claim:**
```
E[Fidelity(step_n+1) | Fidelity(step_n)] ≤ Fidelity(step_n)
```

Fidelity monotonically decreases across chain length.

### Predictions

1. Longer chains → lower fidelity
2. Information loss compounds
3. Even correct individual steps accumulate degradation
4. Rate of degradation depends on tool schema quality

## Key Findings

- **Information degrades across MCP tool chains** — mathematically formalized
- Even correct steps lose fidelity
- Chain length ≥ 5 shows significant degradation
- Schema quality affects rate

## Why This Paper Matters ⭐

- **AAMAS peer review** = theoretical rigor
- **Formal model** — beyond empirical observation
- **Predicts specific patterns** that can be tested
- **Motivates PB6 addition** to GeoAIWorkbench (optional)

## Relevance to GeoAIWorkbench

**High relevance for optional PB6.**

### PB6 (Optional) — Information Fidelity

Fan et al. (2026) provides theoretical basis for optional PB6:

> **How does information fidelity degrade across multi-step MCP tool chains in geospatial workflows?**

If time permits, GeoAIWorkbench measures:
- LCP (Longest Correct Prefix) as fidelity proxy
- Chain length effect on TSR
- Fidelity degradation curve

### Empirical Predictions to Test

1. TSR should decrease with chain length (predicted)
2. Effect should be stronger in MCP-15 (more choices)
3. Rate should differ by agent model

### Non-PB6 Applications

Even if PB6 isn't included, Fan et al. informs:
- Task difficulty design (longer chains = harder)
- LCP metric importance (Layer 5)
- Design principle: minimize chain length

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.4 | **Information fidelity theory** |
| Chapter IV | Section 4.5 | PB6 justification |
| Chapter VI | Section 6.7 | PB6 results (if included) |
| Chapter VII | Section 7.2 | Design principle: minimize chains |

## Related Papers

- Strickland et al. (2026) — Related ED/CF tradeoff
- Song et al. (2025) — "Help or Hurdle" (empirical parallel)

## Key Quote

*"MCP tool chains exhibit information fidelity degradation modeled as a supermartingale, with expected fidelity monotonically decreasing as chain length increases."* — Fan et al. (2026)

## BibTeX Key

`fan2026infofidelity`
