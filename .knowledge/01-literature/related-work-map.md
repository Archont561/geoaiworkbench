---
id: KB-01-related-work-map
title: "How Papers Relate to Each Other"
category: literature
subcategory: relationships
tags: [related-work, dependencies, citations, evolution]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-01-bibliography-overview
  - KB-01-citation-placement-guide
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Map showing how the 33+ references relate to each other"
  key_facts:
    - "Li & Ning (2023) is the foundation paper"
    - "Luo et al. (2026) is the closest prior work to differentiate against"
    - "Zhang et al. (2025) provides the benchmark tasks"
    - "Hou et al. (2025) provides the security framework"
  common_questions:
    - "How do these papers relate?"
    - "What is the intellectual lineage?"
    - "Which paper builds on which?"
---

# Related Work Map

Visualization of how the 33+ references relate to each other and to GeoAIWorkbench.

## Intellectual Lineage

```
                    Li & Ning (2023) — LLM-Geo
                    "Autonomous GIS concept"
                            │
              ┌─────────────┼─────────────┐
              │             │             │
              ▼             ▼             ▼
     Li et al. (2025)  Ning et al.  Akinboyewa et al.
     "Research         (2025)       (2025)
     agenda"           "Data        "GIS Copilot
                       retrieval"    in QGIS"
              │             │             │
              └─────────────┼─────────────┘
                            │
                    ┌───────┴───────┐
                    │               │
                    ▼               ▼
              Han et al.      Wu et al.
              (2026)          (2025)
              "GISclaw"       "GeoColab
                              multi-agent"
                    │               │
                    └───────┬───────┘
                            │
                            ▼
                    Mansourian & Oucheikh (2026)
                    "Multi-agent QGIS + CoT + RAG"
                            │
                            ▼
                    Liang et al. (2026)
                    "GeoAgentic-RAG"
```

## Comparison Studies Evolution

```
Luo et al. (2025)   ─────────►   Luo et al. (2026)
"GeoJSON Agents            "GeoJSON Agents
arXiv preprint"            Big Earth Data version"
                                    │
                                    │
                                    ▼
                        GeoAIWorkbench
                        (this thesis)
                        - QGIS instead of GeoJSON
                        - Real MCP protocol
                        - Multiple agents
                        - Security dimension
                        - Tool count experiment
```

## Benchmark Evolution

```
Zhang et al. (2025)  ──►  Yu et al. (2026)  ──►  MCP-Bench (Wang et al. 2025)
"GeoAnalystBench"        "GeoAgentBench"           "General MCP"
   │                        │                          │
   ├─ Static code           ├─ Runtime exec            ├─ Cross-server
   ├─ 50 tasks              ├─ 117 tools               ├─ 250 tools
   ├─ ArcPy                 ├─ PEA metric              ├─ 28 servers
   └─ CodeBLEU              └─ Plan-and-React          └─ Real MCP
                                                          │
                                                          ▼
                                              LiveMCP-101 (Yin et al. 2025)
                                              LiveMCPBench (Mo et al. 2025)
                                              MCPToolBench++ (Fan et al. 2025)
                                              MCP-Atlas (Bandi et al. 2026)
                                              MCP-Universe (Luo et al. 2025)
```

## Security Framework Evolution

```
Hou et al. (2025) — ACM TOSEM
"MCP Landscape, Security Threats"
        │
        │ ├── Capability exposure
        │ ├── Prompt injection channels
        │ └── Trust propagation
        │
        └────────┬──────────┬──────────┐
                 │          │          │
                 ▼          ▼          ▼
        Maloyan &   Zhang MSB   GeoAIWorkbench
        Namiot      (2025)      (this thesis)
        (2026)      "MCP        - 5 ADV tasks
        "Breaking   Security    - Attack surface
        Protocol"    Bench"     - Layer 7 metrics
```

## Protocol Analysis Cross-References

```
                    MCP Spec (Anthropic)
                            │
              ┌─────────────┼─────────────┐
              │             │             │
              ▼             ▼             ▼
        Nargund et al.  Mastouri et al.  Ehtesham et al.
        (2025)          (2025)           (2025)
        "Lightweight"    "AutoMCP        "Protocol
                        OpenAPI"          Survey"
                                              │
                                              ▼
                                     Song et al. (2025)
                                     "Help or Hurdle?"
                                              │
                                              ▼
                                     Fan et al. (2026)
                                     "AAMAS Information
                                      Fidelity"
```

## MCP Tool Count Chain

```
Wang et al. (2025)                    Mo et al. (2025)
"MCP-Bench 250 tools"                "LiveMCPBench: tool
"coherent bundles work"              selection degrades
        │                            beyond ~50 tools"
        │                                     │
        │              Song et al. (2025)    │
        │            "Help or Hurdle: MCP    │
        │            can hurt performance"   │
        │                                     │
        └──────────────┼─────────────────────┘
                       │
                       ▼
              GeoAIWorkbench PB7
              MCP-5 vs MCP-15
              (first GIS-specific test)
```

## Metric Adoption

```
Yu et al. (2026) PEA metric
        │
        ▼
GeoAIWorkbench Layer 2

Mansourian & Oucheikh (2026)
Self-healing ratio, ITS
        │
        ▼
GeoAIWorkbench Layer 4, 5

Krechetova & Kochedykov (2025)
Rejection Rate, token tracking
        │
        ▼
GeoAIWorkbench Layer 1, 4

Han et al. (2026)
Bootstrap CIs, Cliff's delta
        │
        ▼
GeoAIWorkbench statistical pipeline
```

## Methodological Foundation

```
Peffers et al. (2007) DSRM
        │
        ├── Problem identification
        ├── Objectives
        ├── Design & Development ────► GeoMCP plugin
        ├── Demonstration          ────► 1,800 runs
        ├── Evaluation             ────► 7-layer metrics
        └── Communication          ────► Thesis + article
```

## Papers That Cite Each Other

Notable citation chains:

- Han et al. (2026) cites Zhang et al. (2025), Yu et al. (2026), Luo et al. (2026)
- Wu et al. (2025) cites Li & Ning (2023), Chen et al. (2024)
- Luo et al. (2026) cites Li & Ning (2023), Zhang et al. (2025)
- Ehtesham et al. (2025) cites all protocol specs
- Hou et al. (2025) cites Wang et al. (2025), Yin et al. (2025)
- Song et al. (2025) cites Mo et al. (2025), Fan et al. (2025)

## GeoAIWorkbench Position in the Landscape

```
                        ┌─────────────────────────┐
                        │   GeoAIWorkbench        │
                        │   (this thesis)         │
                        │                         │
                        │   - QGIS + MCP          │
                        │   - 3 conditions        │
                        │   - Tool count study    │
                        │   - Security dimension  │
                        │   - Black box agents    │
                        │   - 1,800 runs          │
                        └────────────┬────────────┘
                                     │
              ┌──────────────────────┼──────────────────────┐
              │                      │                      │
              ▼                      ▼                      ▼
   Advances over               Fills gap in            Extends
   Luo et al. (2026):          MCP evaluation:         Zhang et al. (2025):
   - QGIS not GeoJSON          - GIS-specific          - QGIS not ArcPy
   - Multiple agents           - Tool count study      - Runtime exec
   - Real MCP protocol         - Security dim          - MCP paradigm
   - Security dimension        - 3 conditions          - Multiple agents
   - 1800 runs not 200         - Production agents     - Modern metrics
```

## Related File

- [KB-01-citation-placement-guide](citation-placement-guide.md) — Where to cite each paper in thesis chapters
