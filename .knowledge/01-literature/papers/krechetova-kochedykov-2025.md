---
id: KB-01-krechetova-kochedykov-2025
title: "Krechetova & Kochedykov (2025) — GeoBenchX"
category: literature
subcategory: paper-summary
tags: [geobenchx, benchmark, multi-model, rejection-rate, krechetova]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
  - KB-01-diaz-ireland-et-al-2026
authoritative: false
implementation_status: specified
references:
  - krechetova2025geobenchx
llm_hints:
  primary_purpose: "GIS benchmark evaluating multiple commercial LLMs, introduces Rejection Rate metric"
  key_facts:
    - "Tests Claude, Gemini, GPT-4o, GPT-4.1, o3-mini, o4-mini"
    - "Simple tool-calling agent framework"
    - "Introduces Rejection Rate as important metric"
    - "Tracks token efficiency systematically"
  common_questions:
    - "What is GeoBenchX?"
    - "What is Rejection Rate?"
    - "Which models were tested?"
---

# Krechetova & Kochedykov (2025) — GeoBenchX

## Full Citation

Krechetova, V., & Kochedykov, D. (2025). GeoBenchX: Benchmarking LLMs in Agent Solving Multistep Geospatial Tasks. *Proceedings of the 1st ACM SIGSPATIAL International Workshop on Generative and Agentic AI for Multi-Modality Space-Time Intelligence*.

## What This Paper Says

Presents GeoBenchX, a benchmark evaluating multiple commercial LLMs on multistep geospatial tasks using a simple tool-calling agent framework.

### Models Tested

- Claude (Anthropic)
- Gemini (Google)
- GPT-4o (OpenAI)
- GPT-4.1 (OpenAI)
- o3-mini (OpenAI)
- o4-mini (OpenAI)

### Agent Architecture

- Simple tool-calling agent
- Standard MCP-like interface
- No sophisticated planning
- Focus on model capabilities, not architecture

### Metrics Introduced

- Task accuracy
- **Rejection Rate (RR)** ⭐ **ADOPTED BY GEOAIWORKBENCH**
- Token efficiency
- Solution length

## Key Findings

- **Models differ significantly in rejection behavior** — some refuse unsolvable tasks, others attempt
- Token efficiency varies dramatically across models
- Rejection Rate reveals model "confidence" characteristics
- Simple architecture sufficient to reveal model differences

## Why This Paper Matters

- **Introduces Rejection Rate (RR)** — adopted by GeoAIWorkbench Layer 1
- **Validates multi-model comparison approach**
- **Reveals importance of failure mode analysis**

## Relevance to GeoAIWorkbench

**High relevance — metric adoption.**

### Direct Adoption

**Rejection Rate (RR)** added to GeoAIWorkbench:

```
RR = |{tasks where agent refused or declared unsolvable}| / |total_tasks|
```

Detected via pattern matching in agent output:
- "I cannot solve this"
- "Not possible"
- "Beyond my capabilities"
- "Insufficient information"

### Methodological Precedent

GeoAIWorkbench multi-model comparison (4 agents) follows GeoBenchX pattern:
- Different providers (Anthropic, OpenAI, Google, open-source)
- Same task set
- Fair comparison via same framework

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter II | Section 2.5 | GIS benchmarks with multi-model |
| Chapter IV | Section 4.4 | **RR metric adoption** |
| Chapter IV | Section 4.5 | Multi-model comparison precedent |
| Chapter VI | Section 6.3 | Model comparison discussion |
| Chapter VI | Section 6.4 | RR analysis |

## Related Papers

- Díaz-Ireland et al. (2026) GeoNatureAgent — Similar multi-model approach
- Han et al. (2026) — 6 LLM backends

## Key Quote

*"Models differ not just in task accuracy but also in rejection behavior on unsolvable tasks and in token efficiency, both of which matter for automated benchmark design."* — Krechetova & Kochedykov (2025)

## BibTeX Key

`krechetova2025geobenchx`
