---
id: KB-01-round1-additions
title: "Round 1: 11 References from Consensus AI Search"
category: literature
subcategory: round-one
tags: [round1, consensus-search, bibliography, additions]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-bibliography-overview
  - KB-01-original-13-references
  - KB-01-round2-additions
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "11 additional references discovered via Consensus AI search"
  key_facts:
    - "Round 1 focused on GIS + MCP ecosystem expansion"
    - "11 new references added"
    - "Discovered: MCP-Bench, LiveMCP-101, GeoBenchX, ThinkGeo, etc."
    - "Confirmed several design decisions"
  common_questions:
    - "What was discovered in Round 1?"
    - "Which new papers matter most?"
    - "How did Round 1 change the thesis?"
---

# Round 1: Literature Search via Consensus AI

Consensus AI-powered search of the literature added 11 references that were missing from the original 13. Focus was on GIS agents and MCP ecosystem.

## Discovery Method

- **Tool:** Consensus AI (consensus.app)
- **Query strategy:** Multi-mission scan covering MCP ecosystem, GIS agents, CLI tools, protocols, benchmarks
- **Date:** September 2026
- **Focus:** Papers 2025-2026 that weren't in Round 0

## The 11 Additions

### MCP Ecosystem Benchmarks (5)
1. **Fan et al. (2025)** — MCPToolBench++ (1.5K items, 22K+ MCP-tagged repos analyzed)
2. **Wang et al. (2025)** — MCP-Bench (28 servers, 250 tools)
3. **Yin et al. (2025)** — LiveMCP-101 (41 servers, parallel reference execution)
4. **Mastouri et al. (2025)** — AutoMCP (OpenAPI compiler, 76.5%→99.9% success)
5. **Nargund et al. (2025)** — MCP lightweight modular framework

### GIS Agent Systems (3)
6. **Krechetova & Kochedykov (2025)** — GeoBenchX (multi-model GIS benchmark)
7. **Díaz-Ireland et al. (2026)** — GeoNatureAgent (8 models × 3 seeds)
8. **Shabbir et al. (2025)** — ThinkGeo (remote sensing)

### Multi-Agent Frameworks (3)
9. **Liang et al. (2026)** — GeoAgentic-RAG
10. **Mansourian & Oucheikh (2026)** — Multi-agent QGIS (CoT + RAG)
11. **Chen et al. (2024)** — GeoAgent (planner + executor)

## Design Decisions Confirmed by Round 1

Round 1 evidence confirmed several GeoAIWorkbench decisions:

| Decision | Confirming Evidence |
|---|---|
| Small composable tool bundle | MCP-Bench (Wang et al.) shows intra-server dependencies matter more than count |
| Code gen wins on complex, tool calling wins on structured | Now confirmed across multiple systems |
| Execution-based evaluation | GeoAgentBench, GISclaw, ThinkGeo all converge on runtime verification |
| 3 repetitions minimum | GeoNatureAgent, Mansourian & Oucheikh both use 3 seeds |
| QGIS Processing algorithms as tools | Mansourian & Oucheikh directly use this approach |

## Metrics Added Post-Round 1

Round 1 evidence prompted 4 new metrics:

- **PEA** (Parameter Execution Accuracy) — Yu et al. adapted
- **SHR** (Self-Healing Ratio) — Mansourian & Oucheikh
- **ITS** (Iterations to Success) — Mansourian & Oucheikh
- **RR** (Rejection Rate) — Krechetova & Kochedykov

## Statistical Rigor Upgrade

GISclaw (Han et al., 2026) + Round 1 papers set new standard:

- Bootstrap 95% CIs
- Cliff's delta effect sizes
- Paired Wilcoxon tests
- Multiple comparison correction

## What Was Still Missing (Prompted Round 2)

Round 1 did NOT find:

- MCP-specific security papers
- MCP information fidelity theory
- MCP tool count studies
- Protocol comparison surveys

Round 2 filled these gaps.

## File List

Each paper has its own file in `papers/`:

- [KB-01-fan-et-al-2025](papers/fan-et-al-2025.md)
- [KB-01-wang-et-al-2025](papers/wang-et-al-2025.md)
- [KB-01-yin-et-al-2025](papers/yin-et-al-2025.md)
- [KB-01-mastouri-et-al-2025](papers/mastouri-et-al-2025.md)
- [KB-01-nargund-et-al-2025](papers/nargund-et-al-2025.md)
- [KB-01-krechetova-kochedykov-2025](papers/krechetova-kochedykov-2025.md)
- [KB-01-diaz-ireland-et-al-2026](papers/diaz-ireland-et-al-2026.md)
- [KB-01-shabbir-et-al-2025](papers/shabbir-et-al-2025.md)
- [KB-01-liang-et-al-2026](papers/liang-et-al-2026.md)
- [KB-01-mansourian-oucheikh-2026](papers/mansourian-oucheikh-2026.md)
- [KB-01-chen-et-al-2024](papers/chen-et-al-2024.md)

## Related

- [KB-01-round2-additions](round2-additions.md) — Follow-up search
- [KB-01-bibliography-overview](bibliography-overview.md) — Master list
