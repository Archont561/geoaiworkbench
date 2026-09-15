---
id: KB-01-han-et-al-2026
title: "Han et al. (2026) — GISclaw"
category: literature
subcategory: paper-summary
tags: [gisclaw, open-source, dual-agent, benchmarks, han-et-al]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 12]
related:
  - KB-01-original-13-references
  - KB-01-luo-et-al-2026
authoritative: false
implementation_status: specified
references:
  - han2026gisclaw
llm_hints:
  primary_purpose: "Open-source GIS agent with Dual Agent architecture, 1800 controlled experiments"
  key_facts:
    - "6 LLM backends tested"
    - "Up to 96% task success on GeoAnalystBench"
    - "Dual Agent architecture DEGRADES strong models"
    - "1800 controlled experiments (precedent for GeoAIWorkbench)"
    - "Bootstrap CIs and Cliff's delta"
  common_questions:
    - "What is GISclaw?"
    - "What is the Dual Agent finding?"
    - "How does it compare to LLM-Geo?"
---

# Han et al. (2026) — GISclaw

## Full Citation

Han, J., Lee, J., Shim, Y., Kim, J., & Lee, J.-J. (2026). GISclaw: A Comprehensive Open-Source LLM Agent System for Realistic Multi-Step Geospatial Analysis.

## What This Paper Says

Presents GISclaw, an open-source end-to-end GIS agent supporting vector, raster, and tabular data. Backend-agnostic (cloud APIs + locally deployed open-weight LLMs). Uses persistent Python sandbox, prompt rules, error memory.

### Architecture

- **Single Agent** — Direct LLM → code generation → execution
- **Dual Agent** — Planner LLM + Executor LLM
- Three-layer protocol:
  1. Code structure analysis
  2. Reasoning-process assessment
  3. Type-specific output verification (multimodal vision + programmatic comparison)

### Experimental Design

- 1,800 controlled experiments
- 6 LLM backends: GPT-4, Claude, Gemini, and 3 open-weight models
- Bootstrap 95% CIs
- Wilcoxon signed-rank tests
- Cliff's delta effect sizes

## Key Findings

- **Up to 96% task success** on GeoAnalystBench
- **Dual Agent DEGRADES strong models** — planner LLM often makes suboptimal decisions
- Dual Agent provides marginal gains for weaker models only
- Persistent Python sandbox critical for multi-step tasks
- Error memory enables self-correction

### Findings Table

| Model | Single Agent | Dual Agent |
|---|---|---|
| GPT-4 (strong) | 96% | 88% (degrades) |
| Claude (strong) | 94% | 87% (degrades) |
| Open-weight (weak) | 62% | 68% (improves) |

## Why This Paper Matters

- **Provides methodology precedent** — 1,800 experiments with bootstrap CIs
- **Shows Dual Agent tradeoffs** — not universally beneficial
- **Establishes benchmark baseline** — 96% on GeoAnalystBench
- **Validates open-source approach** — reproducible full-stack agent

## Relevance to GeoAIWorkbench

Very high relevance:

1. **Sample size precedent** — GeoAIWorkbench targets 1,800 runs (matches Han et al.)
2. **Statistical methodology** — Adopt bootstrap CIs, Cliff's delta, paired Wilcoxon
3. **Baseline comparison** — Can compare GeoAIWorkbench MCP-15 to GISclaw code generation
4. **Architecture lesson** — Single-agent design in GeoAIWorkbench is validated
5. **QGIS integration precedent** — GISclaw uses similar QGIS integration

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter II | Section 2.2 | GIS agent systems review |
| Chapter IV | Section 4.4 | Statistical methodology precedent |
| Chapter IV | Section 4.4 | Sample size justification |
| Chapter VI | Comparison | Baseline TSR comparison |
| Chapter VII | Section 7.4 | Multi-agent as future work |

## Related Papers

- Wu et al. (2025) GeoColab — Also multi-agent
- Akinboyewa et al. (2025) GIS Copilot — Single-agent QGIS
- Chen et al. (2024) GeoAgent — Planner-worker pattern

## Key Quote

*"Dual Agent architecture consistently degrades strong models... providing marginal gains only for weaker LLM backends."* — Han et al. (2026)

## Critique / Limitations

- Only tests code generation paradigm (no MCP comparison)
- No security dimension
- Fixed prompt templates (no dynamic prompt optimization)
- Limited task diversity (uses GeoAnalystBench only)

## BibTeX Key

`han2026gisclaw`
