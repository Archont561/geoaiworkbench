---
id: KB-01-bibliography-overview
title: "Bibliography Overview — 33+ References"
category: literature
subcategory: overview
tags: [bibliography, references, literature-review, overview]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 12, 14]
related:
  - KB-01-original-13-references
  - KB-01-round1-additions
  - KB-01-round2-additions
  - KB-01-research-gaps
  - KB-01-citation-placement-guide
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Master overview of all 33+ references organized by discovery round"
  key_facts:
    - "Round 0: 13 initial references (foundational + protocols)"
    - "Round 1: +11 references (Consensus scan 1)"
    - "Round 2: +9 references (Consensus scan 2)"
    - "Total: 33+ references"
    - "Every paper mapped to thesis chapter"
  common_questions:
    - "What is the complete bibliography?"
    - "How were references discovered?"
    - "Which paper is most important?"
---

# Bibliography Overview

Complete listing of all references used in the GeoAIWorkbench thesis, organized by discovery round.

## Discovery Timeline

| Round | Date | Source | Count | Purpose |
|---|---|---|---|---|
| **Round 0** | Initial | Manual literature review | 13 | Foundation + protocols |
| **Round 1** | 2026-09-11 | Consensus AI search | +11 | Related work expansion |
| **Round 2** | 2026-09-11 | Consensus AI search (protocol focus) | +9 | MCP-specific evidence |
| **Total** | | | **33** | Complete bibliography |

## Reference Categories

### Foundational Papers (Round 0)
- Li & Ning (2023) — LLM-Geo foundational autonomous GIS paper
- Li et al. (2025) — Autonomous GIS research agenda
- Peffers et al. (2007) — DSRM methodology

### GIS Agent Systems (Round 0)
- Akinboyewa et al. (2025) — GIS Copilot
- Han et al. (2026) — GISclaw
- Wu et al. (2025) — GeoColab
- Ning et al. (2025) — Data retrieval agent

### Benchmarks (Rounds 0-2)
- Zhang et al. (2025) — GeoAnalystBench ⭐ **primary task source**
- Yu et al. (2026) — GeoAgentBench + PEA metric
- Wang et al. (2025) — MCP-Bench
- Yin et al. (2025) — LiveMCP-101
- Fan et al. (2025) — MCPToolBench++
- Mo et al. (2025) — LiveMCPBench (KDD) ⭐ **supports PB7**
- Bandi et al. (2026) — MCP-Atlas
- Luo et al. (2025) — MCP-Universe

### Key Comparison Studies (Rounds 0-2)
- Luo et al. (2026) — GeoJSON Agents (function calling vs code gen) ⭐ **closest prior work**
- Krechetova & Kochedykov (2025) — GeoBenchX
- Díaz-Ireland et al. (2026) — GeoNatureAgent
- Shabbir et al. (2025) — ThinkGeo (remote sensing)

### Multi-Agent Frameworks (Rounds 1-2)
- Liang et al. (2026) — GeoAgentic-RAG
- Mansourian & Oucheikh (2026) — Multi-agent QGIS
- Chen et al. (2024) — GeoAgent

### Protocol Documentation (Round 0)
- MCP specification (Anthropic)
- ACP specification

### Protocol Analysis (Rounds 1-2)
- Strickland et al. (2026) — ED/CF Pareto framework
- Nargund et al. (2025) — MCP lightweight framework
- Mastouri et al. (2025) — AutoMCP OpenAPI compiler
- Ehtesham et al. (2025) — Protocol survey (MCP/ACP/A2A/ANP)

### Security & Failure Modes (Round 2)
- Hou et al. (2025) — MCP security threats (ACM TOSEM) ⭐ **PB5 foundation**
- Song et al. (2025) — "Help or Hurdle" critical analysis ⭐ **supports PB7**
- Fan et al. (2026) — Information fidelity (AAMAS) ⭐ **PB6 theoretical basis**
- Maloyan & Namiot (2026) — Breaking the Protocol
- Zhang et al. (2025) — MCP Security Bench (MSB)

## Most Critical References (⭐ Marked)

For thesis writing, prioritize these:

1. **Zhang et al. (2025)** — GeoAnalystBench — provides 50 tasks used as benchmark
2. **Luo et al. (2026)** — GeoJSON Agents — closest prior work, need to differentiate
3. **Hou et al. (2025)** — MCP Security (TOSEM) — mandates security dimension
4. **Song et al. (2025)** — "Help or Hurdle" — theoretical basis for PB7
5. **Mo et al. (2025)** — LiveMCPBench — empirical basis for tool count degradation
6. **Fan et al. (2026)** — Information Fidelity (AAMAS) — theoretical basis for PB6
7. **Peffers et al. (2007)** — DSRM — methodological framework for entire thesis

## Chapter-by-Chapter Distribution

| Thesis Chapter | Primary References |
|---|---|
| Chapter I (GIS Automation) | Li & Ning (2023), Li et al. (2025), Akinboyewa et al. (2025) |
| Chapter II (LLM Agents) | Han et al. (2026), Wu et al. (2025), Ning et al. (2025), Chen et al. (2024), Liang et al. (2026), Mansourian & Oucheikh (2026) |
| Chapter III (MCP Protocol) | MCP spec, ACP spec, Nargund et al. (2025), Mastouri et al. (2025), Ehtesham et al. (2025), Wang et al. (2025), Yin et al. (2025), Fan et al. (2025), Hou et al. (2025), Song et al. (2025), Fan et al. (2026) |
| Chapter IV (Experiment Design) | Peffers et al. (2007), Luo et al. (2026), Strickland et al. (2026), Yu et al. (2026), Zhang et al. (2025) |
| Chapter V (Implementation) | MCP spec, FastMCP docs, Bandi et al. (2026) |
| Chapter VI (Results) | Krechetova & Kochedykov (2025), Díaz-Ireland et al. (2026), Shabbir et al. (2025), Mo et al. (2025) |
| Chapter VII (Evaluation) | Hou et al. (2025), Zhang et al. (2025) MSB, Maloyan & Namiot (2026), Song et al. (2025) |

## BibTeX Location

All entries stored in: `thesis/literature.bib`

Managed via: JabRef 5.15+ (recommended)

## Related Files

- [KB-01-original-13-references](original-13-references.md) — Round 0 details
- [KB-01-round1-additions](round1-additions.md) — Round 1 details
- [KB-01-round2-additions](round2-additions.md) — Round 2 details
- [KB-01-research-gaps](research-gaps.md) — 10 gaps identified
- [KB-01-citation-placement-guide](citation-placement-guide.md) — Where to cite each paper
- [KB-01-related-work-map](related-work-map.md) — How papers relate to each other
