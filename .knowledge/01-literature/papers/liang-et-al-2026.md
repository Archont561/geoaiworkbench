---
id: KB-01-liang-et-al-2026
title: "Liang et al. (2026) — GeoAgentic-RAG"
category: literature
subcategory: paper-summary
tags: [geoagentic-rag, multi-agent, rag, visual-insight, liang]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
  - KB-01-wu-et-al-2025
authoritative: false
implementation_status: specified
references:
  - liang2026geoagentic
llm_hints:
  primary_purpose: "Multi-agent framework unifying retrieval and executable spatial analysis"
  key_facts:
    - "Multi-agent framework"
    - "Unified RAG + executable spatial analysis"
    - "Visual insight generation"
    - "Comparable to GeoColab in architecture"
  common_questions:
    - "What is GeoAgentic-RAG?"
    - "How does it use RAG?"
    - "How does it compare to GeoColab?"
---

# Liang et al. (2026) — GeoAgentic-RAG

## Full Citation

Liang, C.-Y., Cui, Y., Shi, R., Zha, G., Yin, X., Xiao, M., Xu, D., Duan, X., & Huang, B. (2026). GeoAgentic-RAG: A Multi-Agent framework for autonomous geospatial reasoning and visual insight generation with LLM. *International Journal of Applied Earth Observation and Geoinformation*.

## What This Paper Says

Multi-agent framework that unifies retrieval-augmented generation (RAG) with executable spatial analysis. Focuses on visual insight generation from geospatial data.

### Architecture

- Multi-agent design
- RAG-enhanced planning
- Executable spatial analysis
- Visual output generation

### Key Innovation

**Unified RAG + Execution:**
- RAG retrieves relevant knowledge
- Agents plan based on retrieval
- Execute spatial analysis
- Generate visualizations

## Key Findings

- Combined RAG + execution outperforms either alone
- Multi-agent coordination adds complexity but improves results
- Visual output generation quality depends on both planning and execution

## Why This Paper Matters

- **Alternative multi-agent architecture** to GeoColab
- **Emphasis on visual output** — different from analytical focus
- **RAG integration precedent** — informs future extensions

## Relevance to GeoAIWorkbench

**Low-moderate relevance.**

### Alternative Approach

GeoAIWorkbench doesn't use:
- RAG (black-box agents)
- Multi-agent coordination
- Visual output focus

### Comparison Point

Chapter II can compare architectures:
- GeoColab (Wu et al., 2025)
- GeoAgentic-RAG (Liang et al., 2026)
- GISclaw Dual Agent (Han et al., 2026)
- GeoJSON Agents (Luo et al., 2026)
- **GeoAIWorkbench (single-agent, black-box)**

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter II | Section 2.2 | Multi-agent GIS systems |
| Chapter II | Section 2.3 | RAG in GIS agents |
| Chapter VII | Section 7.4 | Future work (multi-agent + RAG) |

## Related Papers

- Wu et al. (2025) GeoColab — Also multi-agent + RAG
- Chen et al. (2024) GeoAgent — Planner + executor
- Han et al. (2026) — Dual Agent

## BibTeX Key

`liang2026geoagentic`
