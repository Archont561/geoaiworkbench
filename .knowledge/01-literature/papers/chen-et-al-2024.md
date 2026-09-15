---
id: KB-01-chen-et-al-2024
title: "Chen et al. (2024) — GeoAgent"
category: literature
subcategory: paper-summary
tags: [geoagent, planner-executor, chen-et-al]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
  - KB-01-liang-et-al-2026
authoritative: false
implementation_status: specified
references:
  - chen2024geoagent
llm_hints:
  primary_purpose: "Planner-executor pattern for geospatial data analysis"
  key_facts:
    - "Planner + Executor + Feedback loop"
    - "Predates most 2025 systems"
    - "Foundational planner-worker precedent"
  common_questions:
    - "What is GeoAgent?"
    - "What is planner-executor?"
    - "How does it compare to newer systems?"
---

# Chen et al. (2024) — GeoAgent

## Full Citation

Chen, Y., Wang, W., Lobry, S., & Kurtz, C. (2024). An LLM Agent for Automatic Geospatial Data Analysis. *ArXiv, abs/2410.18792*.

## What This Paper Says

Planner-executor pattern for automatic geospatial data analysis. Provides feedback loop between components.

### Architecture

- **Planner** — Decomposes task into steps
- **Executor** — Runs each step
- **Feedback loop** — Executor errors inform planner
- **Retry mechanism** — Adjusts plan based on failures

### Design Philosophy

- Simple two-agent design
- Focus on planning-execution separation
- Feedback for adaptation
- Early precedent in the field

## Key Findings

- Planner-executor separation improves complex task handling
- Feedback loop enables self-correction
- Simple architecture sufficient for many tasks

## Why This Paper Matters

- **Early precedent for planner-worker pattern**
- **Predates most 2025 systems** — foundational
- **Simpler than later multi-agent** — sometimes sufficient

## Relevance to GeoAIWorkbench

**Low direct relevance.**

### Non-Applicable

GeoAIWorkbench uses:
- Single-agent design (black box)
- No planner-executor separation
- Retries via agent's own logic

### Historical Context

Provides background:
- Field evolution from Chen et al. (2024) → later multi-agent systems
- Justifies GeoAIWorkbench's single-agent choice (simpler, comparable)

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter II | Section 2.2 | Multi-agent GIS history |
| Chapter IV | Section 4.2 | Single vs multi-agent decision |
| Chapter VII | Section 7.4 | Multi-agent as future work |

## Related Papers

- Han et al. (2026) — Dual Agent (evolved from planner-executor)
- Wu et al. (2025) GeoColab — More sophisticated multi-agent
- Liang et al. (2026) — Multi-agent + RAG

## BibTeX Key

`chen2024geoagent`
