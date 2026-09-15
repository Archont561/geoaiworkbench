---
id: KB-01-citation-placement-guide
title: "Where to Cite Each Paper in the Thesis"
category: literature
subcategory: citation-guide
tags: [citations, thesis-writing, chapter-mapping]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 12]
related:
  - KB-01-bibliography-overview
  - KB-11-thesis-structure
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Where to cite each of the 33+ references in specific thesis chapters"
  key_facts:
    - "Every reference mapped to specific chapter and section"
    - "Some papers cited in multiple chapters"
    - "Optimizes writing efficiency"
  common_questions:
    - "Where should I cite Zhang et al.?"
    - "Which papers go in Chapter III?"
    - "How do I structure the literature review?"
---

# Citation Placement Guide

Where to cite each of the 33+ references within the thesis chapter structure.

## Chapter-by-Chapter Citation Map

### Wstęp (Introduction)

**Purpose:** Establish problem, motivate research questions.

**Primary citations:**
- Li & Ning (2023) — "Autonomous GIS vision"
- Li et al. (2025) — "Research agenda gaps"
- Luo et al. (2026) — "The paradigm question exists"
- Hou et al. (2025) — "Security matters"

**Cite once briefly:** Peffers et al. (2007) for methodology preview.

### Chapter I: GIS Automation Systems

**Purpose:** Establish GIS automation landscape and role of QGIS.

**Primary citations:**
- Li & Ning (2023) — Foundational
- Li et al. (2025) — Autonomy levels framework
- Akinboyewa et al. (2025) — GIS Copilot as QGIS precedent
- Ning et al. (2025) — Data retrieval capability
- Mansourian & Oucheikh (2026) — QGIS multi-agent example

**Secondary citations:**
- General QGIS/PyQGIS references (not required in bibliography if using primary sources)

### Chapter II: LLM Agents for GIS

**Purpose:** Review LLM-based GIS agent systems.

**Primary citations:**
- Han et al. (2026) — GISclaw architecture
- Wu et al. (2025) — GeoColab multi-agent
- Chen et al. (2024) — GeoAgent planning
- Liang et al. (2026) — GeoAgentic-RAG
- Krechetova & Kochedykov (2025) — GeoBenchX evaluation
- Díaz-Ireland et al. (2026) — GeoNatureAgent

**Discussion section (comparison):**
- Luo et al. (2026) — Function calling vs code generation debate
- Shabbir et al. (2025) — ThinkGeo (different domain but relevant)

### Chapter III: Model Context Protocol

**Purpose:** Define MCP, position in protocol stack, review MCP literature.

**Section 3.1 — MCP Specification**
- MCP Spec (Anthropic)
- Nargund et al. (2025) — Lightweight framework
- Mastouri et al. (2025) — AutoMCP OpenAPI

**Section 3.2 — Protocol Stack Positioning**
- Ehtesham et al. (2025) — MCP vs ACP vs A2A vs ANP
- ACP Spec (distinguish from A2A)
- Note about ACP → A2A merger

**Section 3.3 — MCP Ecosystem**
- Wang et al. (2025) — MCP-Bench 250 tools
- Yin et al. (2025) — LiveMCP-101
- Fan et al. (2025) — MCPToolBench++
- Mo et al. (2025) — LiveMCPBench (large-scale)
- Bandi et al. (2026) — MCP-Atlas
- Luo et al. (2025) — MCP-Universe

**Section 3.4 — Information Fidelity Theory**
- Fan et al. (2026) — AAMAS martingale model

**Section 3.5 — Security Threats**
- Hou et al. (2025) — TOSEM taxonomy
- Maloyan & Namiot (2026) — Breaking the Protocol
- Zhang et al. (2025) — MCP Security Bench (MSB)

**Section 3.6 — Help or Hurdle**
- Song et al. (2025) — Critical analysis
- Krechetova & Kochedykov (2025) — Rejection behavior evidence

### Chapter IV: Experiment Design

**Purpose:** Define the 3-condition factorial design.

**Section 4.1 — Methodology**
- Peffers et al. (2007) — DSRM (dominant citation, cite multiple times)

**Section 4.2 — Prior Comparison Studies**
- Luo et al. (2026) — Closest prior work, must differentiate
- Discuss GeoJSON only, single agent, no security dimension

**Section 4.3 — Task Suite**
- Zhang et al. (2025) — GeoAnalystBench 50 tasks
- Note ArcPy → PyQGIS adaptation
- Compare to alternatives: GeoAgentBench (Yu et al., 2026), ThinkGeo (Shabbir et al., 2025)

**Section 4.4 — Metrics Framework**
- Yu et al. (2026) — PEA metric adoption
- Mansourian & Oucheikh (2026) — SHR, ITS metrics
- Krechetova & Kochedykov (2025) — RR metric
- Han et al. (2026) — Bootstrap CIs, Cliff's delta

**Section 4.5 — Theoretical Framework**
- Strickland et al. (2026) — ED vs CF Pareto (basis for ED metric)

**Section 4.6 — Tool Count Rationale (PB7)**
- Mo et al. (2025) — Degradation evidence
- Song et al. (2025) — Help or Hurdle
- Wang et al. (2025) — Coherent bundles work

### Chapter V: Implementation

**Purpose:** Describe GeoMCP plugin implementation.

**Section 5.1 — Architecture**
- MCP Spec — protocol foundation
- FastMCP Docs — implementation framework
- qgis-mcp (nkarasiak) — reference architecture (with `execute_code` warning)

**Section 5.2 — Tool Specifications**
- MCP Spec — annotations (readOnlyHint, etc.)
- MCP Blog — Tool Annotations post (2026-03-16)
- MCP Blog — Server Instructions post (2025-11-03)

**Section 5.3 — Security Hardening**
- Hou et al. (2025) — threat categories applied
- Maloyan & Namiot (2026) — injection attacks

**Section 5.4 — Reproducibility**
- Pixi docs — package management
- Peffers et al. (2007) — replication in DSRM

### Chapter VI: Results

**Purpose:** Present experimental results per RQ.

**Section 6.1 — PB1: Overall Success**
- Compare to Luo et al. (2026) baseline numbers
- Compare to Akinboyewa et al. (2025), Han et al. (2026) if applicable

**Section 6.2 — PB2: Difficulty Moderation**
- Zhang et al. (2025) — task difficulty definitions
- Yu et al. (2026) — comparison to their difficulty tiers

**Section 6.3 — PB3: Agent-Paradigm Interaction**
- Díaz-Ireland et al. (2026) — model comparison precedent
- Krechetova & Kochedykov (2025) — token efficiency comparison

**Section 6.4 — PB4: Execution Behavior**
- Yu et al. (2026) — PEA comparison
- Mansourian & Oucheikh (2026) — SHR comparison

**Section 6.5 — PB5: Security**
- Hou et al. (2025) — TOSEM taxonomy validation
- Zhang et al. (2025) MSB — attack comparison
- Maloyan & Namiot (2026) — injection results

**Section 6.6 — PB7: Tool Count**
- Mo et al. (2025) — comparison to their degradation curve
- Song et al. (2025) — help/hurdle analysis

**Section 6.7 — PB6 (Optional): Information Fidelity**
- Fan et al. (2026) — AAMAS martingale model application

### Chapter VII: Evaluation and Practical Guidance

**Purpose:** Synthesize into decision framework and design principles.

**Section 7.1 — Decision Matrix**
- Reference PB1-PB4, PB7 results
- Contextualize with Luo et al. (2026) prior work

**Section 7.2 — Design Principles (P1-P8)**
- MCP Spec — protocol basis
- Hou et al. (2025) — security principles
- Mastouri et al. (2025) — schema-driven approach
- Nargund et al. (2025) — lightweight modular design

**Section 7.3 — Threats to Validity**
- Zhang et al. (2025) — task suite limitations
- Han et al. (2026) — comparison sample size
- Mo et al. (2025) — tool count generalization

**Section 7.4 — Future Work**
- Ning et al. (2025) — data retrieval extension
- Li et al. (2025) — full autonomy levels
- A2A Spec — multi-agent extension
- ThinkGeo (Shabbir et al., 2025) — remote sensing extension

### Wnioski / Zakończenie (Conclusion)

**Purpose:** Summarize contributions.

**Primary citations (revisit):**
- Li & Ning (2023) — Vision realized
- Luo et al. (2026) — Prior work extended
- Hou et al. (2025) — Security enhanced
- Peffers et al. (2007) — DSRM completed

## Citation Frequency Summary

| Reference | Chapters Cited | Frequency |
|---|---|---|
| Zhang et al. (2025) | I, IV, V, VI, VII | ⭐⭐⭐⭐⭐ |
| Luo et al. (2026) | Intro, II, IV, VI, VII | ⭐⭐⭐⭐⭐ |
| Hou et al. (2025) | III, IV, V, VI, VII | ⭐⭐⭐⭐⭐ |
| Yu et al. (2026) | III, IV, V, VI | ⭐⭐⭐⭐ |
| Peffers et al. (2007) | Intro, IV, V, VII | ⭐⭐⭐⭐ |
| Han et al. (2026) | II, IV, VI, VII | ⭐⭐⭐⭐ |
| MCP Spec | III, V, VII | ⭐⭐⭐⭐ |
| Mo et al. (2025) | III, IV, VI, VII | ⭐⭐⭐⭐ |
| Song et al. (2025) | III, IV, VI | ⭐⭐⭐ |
| Others | 1-2 chapters each | ⭐-⭐⭐ |

## Formatting Rules

- Use `authoryear` style in biblatex
- First citation in text: `\parencite[e.g.,][]{zhang2025geoanalystbench}`
- Subsequent: `\parencite{zhang2025geoanalystbench}`
- Grouped citations: `\parencite{zhang2025geoanalystbench,yu2026geoagentbench}`

## Related Files

- [KB-01-bibliography-overview](bibliography-overview.md) — All 33+ references
- [KB-11-thesis-structure](../11-thesis/thesis-structure.md) — Chapter outlines
