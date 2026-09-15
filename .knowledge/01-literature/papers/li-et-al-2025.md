---
id: KB-01-li-et-al-2025
title: "Li et al. (2025) — Autonomous GIS Research Agenda"
category: literature
subcategory: paper-summary
tags: [autonomous-gis, research-agenda, autonomy-levels, li-et-al]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 12]
related:
  - KB-01-li-ning-2023
  - KB-01-research-gaps
authoritative: false
implementation_status: specified
references:
  - li2025autonomous
llm_hints:
  primary_purpose: "Full research agenda for autonomous GIS with 5 autonomy levels"
  key_facts:
    - "5 autonomy levels (0-4)"
    - "5 core functions"
    - "3 operational scales"
    - "Raised societal responsibility concerns"
  common_questions:
    - "What are the 5 autonomy levels?"
    - "What are the core functions?"
    - "What ethical concerns are raised?"
---

# Li et al. (2025) — Autonomous GIS Research Agenda

## Full Citation

Li, Z., et al. (2025). Autonomous GIS: research agenda for the next decade.

## What This Paper Says

Extends Li & Ning (2023) into a comprehensive research agenda. Defines dimensions for measuring autonomous GIS capabilities.

### 5 Autonomy Levels

- **Level 0:** No autonomy (human directs every step)
- **Level 1:** Task assistance (agent suggests tools)
- **Level 2:** Constrained execution (agent executes with human approval)
- **Level 3:** Supervised execution (agent runs, human reviews)
- **Level 4:** Full autonomy (agent runs and self-verifies)

### 5 Core Functions

1. Data acquisition and preparation
2. Spatial analysis and modeling
3. Result visualization and communication
4. Workflow orchestration and management
5. Self-improvement and learning

### 3 Operational Scales

- **Local scale** — Single desktop/plugin
- **Regional scale** — Multi-user, shared workflows
- **Global scale** — Cloud-based, planetary-scale analysis

### Societal Responsibility

- Bias in training data affecting analysis outcomes
- Misuse for surveillance, resource extraction
- Environmental impact of large model inference
- Displacement of human GIS analysts

## Key Findings

- Field currently at Levels 1-2 (task assistance / constrained execution)
- Level 4 remains aspirational
- Local scale most mature; global scale unexplored
- Ethical considerations largely unexamined in prior work

## Why This Paper Matters

**Provides the framework** for positioning any GIS agent work. Every research question can be mapped to a specific autonomy level and function.

## Relevance to GeoAIWorkbench

- Positions GeoAIWorkbench at **Autonomy Level 2-3** (constrained execution with review)
- Focuses on **Core Function 2** (spatial analysis) with elements of Functions 1 and 4
- Operates at **Local Scale** (single QGIS installation)
- Addresses societal concern via **PB5 security dimension**

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Wstęp | Introduction | Research context and gap |
| Chapter I | Section 1.2 | Autonomy levels framework |
| Chapter I | Section 1.4 | Core functions overview |
| Chapter VII | Section 7.4 | Future work (higher autonomy levels) |

## Related Papers

- Li & Ning (2023) — Foundational precursor
- Ning et al. (2025) — Function 1 (data retrieval) example
- Han et al. (2026) — Level 2-3 example
- Akinboyewa et al. (2025) — Function 2 example

## Key Quote

*"The path from Level 1 to Level 4 autonomy requires solving fundamental challenges in self-verification, reasoning about spatial semantics, and responsible AI deployment in geospatial contexts."* — Li et al. (2025)

## Critique / Limitations

- No empirical evaluation of any autonomy level
- Levels not operationally defined (hard to measure)
- Societal concerns raised but not investigated
- Framework theoretical

## BibTeX Key

`li2025autonomous`
