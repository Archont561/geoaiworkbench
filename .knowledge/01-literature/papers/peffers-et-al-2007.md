---
id: KB-01-peffers-et-al-2007
title: "Peffers et al. (2007) — Design Science Research Methodology"
category: literature
subcategory: paper-summary
tags: [dsrm, methodology, design-science, peffers, KEY-METHODOLOGY]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 12]
related:
  - KB-01-original-13-references
  - KB-00-project-overview
  - KB-02-methodology-dsrm
authoritative: false
implementation_status: specified
references:
  - peffers2007design
llm_hints:
  primary_purpose: "Methodological framework for building artifacts + empirical evaluation"
  key_facts:
    - "6-step Design Science Research Methodology"
    - "Framework for combining artifact creation + empirical study"
    - "Standard in information systems research"
    - "Justifies GeoMCP as design science artifact"
  common_questions:
    - "What is DSRM?"
    - "What are the 6 steps?"
    - "Why use DSRM for this thesis?"
---

# Peffers et al. (2007) — Design Science Research Methodology

## Full Citation

Peffers, K., Tuunanen, T., Rothenberger, M. A., & Chatterjee, S. (2007). A Design Science Research Methodology for Information Systems Research.

## What This Paper Says

Provides the canonical 6-step Design Science Research Methodology (DSRM) for information systems research. Frameworks for combining artifact creation with empirical evaluation.

### The 6 Steps

1. **Problem identification and motivation**
2. **Objectives of a solution**
3. **Design and development**
4. **Demonstration**
5. **Evaluation**
6. **Communication**

Each step iterates as needed.

### Applicability

- Any research producing a novel artifact
- Any research combining building + empirical evaluation
- Fits: software plugins, algorithms, frameworks, methodologies

## Key Contribution

**Legitimizes dual contribution work:** building an artifact AND evaluating it empirically as a single coherent research project.

## Why This Paper Matters

- **Standard methodology** in information systems research
- **Justifies GeoMCP** as design science artifact
- **Provides structure** for thesis chapters
- **Widely accepted** in top venues

## Relevance to GeoAIWorkbench

**Extremely high — methodological foundation.**

### Direct Application

| DSRM Step | GeoAIWorkbench Implementation |
|---|---|
| 1. Problem identification | GIS analysts need reliable LLM automation; two paradigms exist without rigorous comparison |
| 2. Objectives | 6 research questions (PB1-PB5, PB7) covering success, difficulty, agent interaction, execution, security, tool count |
| 3. Design & Development | GeoMCP plugin as artifact (with tier control, security hardening) |
| 4. Demonstration | 1,800-run controlled benchmark |
| 5. Evaluation | 7-layer metrics framework with statistical rigor (bootstrap CIs, Cliff's delta, Bonferroni) |
| 6. Communication | Master's thesis + open-source release + potential journal article |

### Iterative Refinement

DSRM allows iteration:
- After Step 5 (evaluation), may refine Step 3 (design) based on findings
- GeoAIWorkbench uses this: MCP-15 was added after initial design (Step 3 iteration based on literature review)

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Wstęp | Introduction | Methodological framework preview |
| Chapter IV | Section 4.1 | **Primary methodology declaration** |
| Chapter IV | All sections | Reference DSRM steps repeatedly |
| Chapter V | Section 5.1 | Design & Development step |
| Chapter VI | Introduction | Evaluation step |
| Wnioski | Conclusion | Communication step (thesis + release) |

## Related Papers

- Hevner et al. (2004) — Original design science principles
- No direct GIS DSRM applications in literature (GeoAIWorkbench is a first)

## Key Quote

*"Design science research produces both a novel artifact and empirical validation of that artifact's utility, addressing real-world problems through rigorous research methodology."* — Peffers et al. (2007)

## Critique / Limitations

- Original from 2007; some methodological updates exist
- Less prescriptive than empirical-only methodologies
- Requires justifying both artifact and evaluation quality

## Application in Thesis

Each chapter can be introduced with DSRM step:

- Chapter IV: *"Following the DSRM framework of Peffers et al. (2007), this chapter presents the design and development of GeoMCP (Step 3)..."*
- Chapter V: *"Continuing the DSRM cycle, this chapter details the implementation (Step 3) and demonstration setup (Step 4)..."*
- Chapter VI: *"This chapter presents the evaluation (Step 5) of GeoMCP across three experimental conditions..."*

## BibTeX Key

`peffers2007design`
