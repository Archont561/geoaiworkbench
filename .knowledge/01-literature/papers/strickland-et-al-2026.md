---
id: KB-01-strickland-et-al-2026
title: "Strickland et al. (2026) — ED vs CF Pareto Front"
category: literature
subcategory: paper-summary
tags: [strickland, pareto, execution-determinism, conversational-flexibility, tradeoff]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 12]
related:
  - KB-01-original-13-references
  - KB-00-glossary-terms
authoritative: false
implementation_status: specified
references:
  - strickland2026pareto
llm_hints:
  primary_purpose: "Theoretical framework: Execution Determinism vs Conversational Flexibility tradeoff"
  key_facts:
    - "Empirical Pareto front between ED and CF"
    - "No reviewed system achieves both simultaneously"
    - "Proposed schema-gated orchestration"
    - "Provides theoretical basis for ED metric"
  common_questions:
    - "What is ED vs CF?"
    - "Why is there a tradeoff?"
    - "How does GeoAIWorkbench use this?"
---

# Strickland et al. (2026) — Execution Determinism vs Conversational Flexibility

## Full Citation

Strickland, K., et al. (2026). Empirical Pareto Front Between Execution Determinism and Conversational Flexibility in LLM Agent Systems.

## What This Paper Says

Identifies fundamental tradeoff between execution determinism (ED) and conversational flexibility (CF) in LLM agent systems. Shows empirical Pareto front — no reviewed system achieves both simultaneously.

### Key Concepts

**Execution Determinism (ED):**
- Same input → same output across repeated runs
- Predictable behavior
- Necessary for production reliability
- Achieved by: schema constraints, temperature=0, deterministic sampling

**Conversational Flexibility (CF):**
- Agent handles open-ended, multi-turn dialogue
- Adapts to novel situations
- Necessary for user experience
- Achieved by: high temperature, free-form generation, creative reasoning

### The Pareto Front

```
ED
 │  ┌───────────╮
 │  │           │
 │  │  Pareto   │
 │  │   Front   │
 │  │           │
 │  ╰───────────┘
 │
 └────────────────► CF
```

Systems fall on the front; improvements in one dimension come at cost of the other.

### Proposed Solution: Schema-Gated Orchestration

- Use schemas (like MCP tools) for structured operations
- Use free-form generation for open-ended reasoning
- Route between paradigms based on task type

## Key Findings

- No production system achieves both high ED and high CF
- MCP tool calling → high ED, low CF
- Free-form code generation → high CF, low ED
- Hybrid approaches show promise

## Why This Paper Matters

- **Theoretical foundation for ED metric** in GeoAIWorkbench
- **Explains why paradigm tradeoff exists** — fundamental, not implementation detail
- **Predicts MCP-5 has highest ED** — validated by GeoAIWorkbench PB7 hypothesis H7d

## Relevance to GeoAIWorkbench

**Very high relevance — theoretical basis for key metrics and hypotheses.**

### Direct Application

1. **ED metric** — GeoAIWorkbench Layer 4 directly measures ED across 3 repetitions
2. **CF metric implicit** — CodeGen success on open-ended tasks proxies CF
3. **Hypothesis H7d** — MCP-5 > MCP-15 on ED (fewer choices = more consistent)
4. **Design principle** — GeoMCP tiers enable capability/determinism tradeoff (P8)

### Predicted Position on Pareto Front

| Paradigm | ED | CF |
|---|---|---|
| MCP-5 | High | Low |
| MCP-15 | Medium | Medium |
| CodeGen | Low | High |

**GeoAIWorkbench empirically validates this ordering.**

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.6 | Protocol tradeoff theory |
| Chapter IV | Section 4.4 | **ED metric theoretical foundation** |
| Chapter IV | Section 4.5 | Hypothesis H7d justification |
| Chapter VI | Section 6.4 | ED results interpretation |
| Chapter VII | Section 7.1 | Decision matrix (ED vs CF tradeoff) |

## Related Papers

- Fan et al. (2026) AAMAS — Formal information fidelity model (complementary)
- Song et al. (2025) — "Help or Hurdle" (related tradeoff analysis)

## Key Quote

*"An empirical Pareto front exists between Execution Determinism and Conversational Flexibility; no reviewed LLM agent system achieves both simultaneously."* — Strickland et al. (2026)

## Critique / Limitations

- Theoretical framework, limited empirical data
- "Schema-gated orchestration" proposed but not fully evaluated
- No formal proof of the Pareto front (empirical only)

## GeoAIWorkbench Contribution

GeoAIWorkbench extends Strickland et al. by:

1. **Empirically measuring ED** in GIS-specific context
2. **Showing tier effect on ED** (PB7)
3. **Providing quantitative ED numbers** for all 3 paradigms

## BibTeX Key

`strickland2026pareto`
