---
id: KB-01-diaz-ireland-et-al-2026
title: "Díaz-Ireland et al. (2026) — GeoNatureAgent"
category: literature
subcategory: paper-summary
tags: [geonatureagent, benchmark, open-weight, pareto, cost-accuracy, diaz-ireland]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
  - KB-01-krechetova-kochedykov-2025
authoritative: false
implementation_status: specified
references:
  - diazireland2026geonatureagent
llm_hints:
  primary_purpose: "Environmental GIS benchmark testing 8 frontier and open-weight models with 3 seeds"
  key_facts:
    - "8 models tested (frontier + open-weight)"
    - "3 seeds per model (matches GeoAIWorkbench 3 reps)"
    - "Open-weight models occupy Pareto frontier"
    - "Treats capability and cost as orthogonal axes"
  common_questions:
    - "What is GeoNatureAgent?"
    - "Are open-weight models competitive?"
    - "Why 3 seeds?"
---

# Díaz-Ireland et al. (2026) — GeoNatureAgent

## Full Citation

Díaz-Ireland, G., Prieto-Herráez, D., Peces, M. G., Velázquez, J., & Jain, D. (2026). GeoNatureAgent Benchmark: Benchmarking LLM Agents for Environmental Geospatial Analysis Across Frontier and Open-Weight Foundation Models. *ArXiv, abs/2606.12821*.

## What This Paper Says

Environmental geospatial benchmark comparing 8 frontier and open-weight LLM foundation models. Introduces cost-accuracy Pareto analysis for GIS agents.

### Experimental Design

- **8 LLM models** tested:
  - Frontier: GPT-4, Claude, Gemini
  - Open-weight: Llama, Mistral, Qwen, DeepSeek, Falcon
- **3 temperature-1.0 seeds** per model
- Environmental geospatial tasks
- Treats capability and cost as orthogonal axes

### Cost-Accuracy Pareto Analysis

Reports for each model:
- Success rate (capability)
- Per-case cost (dollars, tokens)
- Position on cost-accuracy Pareto front

## Key Findings

- **Open-weight models occupy much of the Pareto frontier** — often near frontier models at lower cost
- **3 seeds reveal significant variance** — single-run reporting insufficient
- Cost matters as much as accuracy for practical deployment
- Model choice depends on cost sensitivity, not just capability

## Why This Paper Matters

- **Validates 3-seed methodology** — matches GeoAIWorkbench 3 repetitions
- **Justifies open-weight consideration** — Goose (BYOM) worth including
- **Cost-accuracy framework** — GeoAIWorkbench PB3 uses similar analysis

## Relevance to GeoAIWorkbench

**Very high relevance.**

### Methodological Adoption

1. **3 repetitions per condition** — matches Díaz-Ireland et al.
2. **Cost tracking** — every JSONL event records tokens
3. **Cost-performance ratio** — GeoAIWorkbench Layer 6 composite metric
4. **Multi-model comparison** — 4 agents (some BYOM-capable)

### Agent Selection Validation

GeoAIWorkbench includes Goose specifically because:
- Goose supports BYOM (Ollama, OpenRouter)
- Enables open-weight evaluation
- Díaz-Ireland et al. shows open-weight competitive

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter II | Section 2.5 | Multi-model GIS benchmarks |
| Chapter IV | Section 4.5 | **3 repetitions justification** |
| Chapter IV | Section 4.5 | Cost analysis framework |
| Chapter VI | Section 6.3 | Cost-performance analysis |
| Chapter VII | Section 7.1 | Decision matrix (cost-sensitive) |

## Related Papers

- Krechetova & Kochedykov (2025) GeoBenchX — Multi-model precedent
- Mansourian & Oucheikh (2026) — 3 seeds
- Han et al. (2026) — 6 LLM backends

## Key Quote

*"Open-weight models occupied much of the cost-accuracy Pareto frontier, indicating that model capability alone should not drive agent selection — cost sensitivity is equally important."* — Díaz-Ireland et al. (2026)

## BibTeX Key

`diazireland2026geonatureagent`
