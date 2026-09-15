---
id: KB-02-methodology-dsrm
title: "DSRM Methodology Mapping"
category: research-design
subcategory: methodology
tags: [dsrm, peffers, methodology, design-science, steps]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [2, 3]
related:
  - KB-01-peffers-et-al-2007
  - KB-02-final-research-design
  - KB-11-thesis-structure
authoritative: true
implementation_status: specified
references:
  - peffers2007design
llm_hints:
  primary_purpose: "Maps GeoAIWorkbench activities to DSRM 6 steps"
  key_facts:
    - "DSRM = Design Science Research Methodology"
    - "6 steps: problem, objectives, design, demonstration, evaluation, communication"
    - "GeoMCP plugin is the DSRM artifact"
    - "1,800-run benchmark is the demonstration + evaluation"
  common_questions:
    - "What methodology does the thesis use?"
    - "How does DSRM apply?"
    - "What is the artifact?"
---

# DSRM Methodology Mapping

GeoAIWorkbench follows the Design Science Research Methodology (DSRM) of Peffers et al. (2007). This page maps each DSRM step to specific GeoAIWorkbench activities.

## DSRM Step 1: Problem Identification and Motivation

**DSRM definition:** Define the specific research problem and justify the value of a solution.

**GeoAIWorkbench implementation:**
- GIS analysts need reliable LLM-driven automation
- Two paradigms exist (MCP tool calling, code generation) but no rigorous comparison
- Existing comparison (Luo et al., 2026) limited to GeoJSON, single model, custom framework
- No GIS-specific MCP security evaluation
- No GIS-specific tool count study

**Thesis chapter:** Wstęp (Introduction), Chapter I

**Key references:** Li & Ning (2023), Li et al. (2025), Luo et al. (2026), Hou et al. (2025)

## DSRM Step 2: Objectives of a Solution

**DSRM definition:** Infer objectives from problem definition and knowledge of what is possible and feasible.

**GeoAIWorkbench implementation:**
- 7 research questions (PB1-PB7)
- 5 evaluation dimensions
- 7-layer metrics framework
- 3-condition factorial design
- 1,800-run benchmark

**Thesis chapter:** Wstęp, Chapter IV (Section 4.1)

**Key references:** Peffers et al. (2007), Yu et al. (2026), Strickland et al. (2026)

## DSRM Step 3: Design and Development

**DSRM definition:** Create the artifact. Specify its functionality and architecture, then implement.

**GeoAIWorkbench implementation:**
- GeoMCP plugin (FastMCP 4.0.3, 5 or 15 tools)
- TCP bridge to QGIS
- Benchmark harness (monitors, verifier, orchestrator)
- 4-layer CodeGen evaluation pipeline
- Tier control via `GEOMCP_TIER`

**Thesis chapter:** Chapter V (Implementation)

**Key references:** MCP Spec, FastMCP docs, qgis-mcp reference architecture

## DSRM Step 4: Demonstration

**DSRM definition:** Demonstrate the use of the artifact to solve one or more instances of the problem.

**GeoAIWorkbench implementation:**
- 1,800-run controlled benchmark
- 3 paradigms × 4 agents × 50 tasks × 3 repetitions
- 55 tasks total (50 GeoAnalystBench + 5 adversarial)
- Real QGIS environment with real spatial data

**Thesis chapter:** Chapter IV (Section 4.3-4.5), Chapter V (Section 5.5)

**Key references:** Zhang et al. (2025), Han et al. (2026)

## DSRM Step 5: Evaluation

**DSRM definition:** Observe and measure how well the artifact supports a solution to the problem. Compare objectives to results.

**GeoAIWorkbench implementation:**
- 7-layer metrics framework
- Statistical tests (ANOVA, McNemar, chi-square, paired t-test)
- Bootstrap 95% CIs, Cliff's delta, Bonferroni correction
- 4-layer CodeGen evaluation (static/semantic/runtime/artifact)
- Security evaluation (5 adversarial tasks)

**Thesis chapter:** Chapter VI (Results)

**Key references:** Yu et al. (2026), Han et al. (2026), Mansourian & Oucheikh (2026)

## DSRM Step 6: Communication

**DSRM definition:** Communicate the problem and its importance, the artifact, its utility and novelty, the rigor of its design, and its effectiveness to researchers and practitioners.

**GeoAIWorkbench implementation:**
- Master's thesis (Polish, WIT PWr format)
- Open-source release (GitHub + PyPI + QGIS Plugin Repository)
- Zenodo archive with DOI
- Potential journal article (IJDE, TGIS, Big Earth Data)
- This knowledge base (.knowledge/)

**Thesis chapter:** Wnioski (Conclusions), all chapters

## Iterative Refinement

DSRM allows iteration between steps. GeoAIWorkbench iterated:

| Iteration | From → To | What Changed |
|---|---|---|
| 1 | Step 2 → Step 1 | Added PB5 after Hou et al. (TOSEM) |
| 2 | Step 3 → Step 2 | Added MCP-15 tier after Mo et al. (KDD) |
| 3 | Step 3 → Step 3 | Changed architecture to separate MCP process |
| 4 | Step 3 → Step 3 | Changed from `mcp` v1 to `fastmcp` v4 |
| 5 | Step 5 → Step 3 | Added 4-layer CodeGen evaluation after web search |

## Related Files

- [KB-01-peffers-et-al-2007](../01-literature/papers/peffers-et-al-2007.md) — DSRM source
- [KB-02-final-research-design](final-research-design.md) — Complete design
- [KB-11-thesis-structure](../11-thesis/thesis-structure.md) — Chapter mapping
