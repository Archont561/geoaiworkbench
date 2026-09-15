---
id: KB-01-akinboyewa-et-al-2025
title: "Akinboyewa et al. (2025) — GIS Copilot"
category: literature
subcategory: paper-summary
tags: [gis-copilot, qgis, plugin, code-generation, akinboyewa]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 12]
related:
  - KB-01-original-13-references
  - KB-01-li-ning-2023
authoritative: false
implementation_status: specified
references:
  - akinboyewa2025giscopilot
llm_hints:
  primary_purpose: "First QGIS-embedded LLM agent for spatial analysis"
  key_facts:
    - "QGIS plugin using natural language"
    - "Code generation only (no MCP)"
    - "High success on basic/intermediate, challenges on advanced"
    - "Uses documentation over key GIS tools"
  common_questions:
    - "What is GIS Copilot?"
    - "How does it differ from GeoAIWorkbench?"
    - "Why is it code-generation only?"
---

# Akinboyewa et al. (2025) — GIS Copilot

## Full Citation

Akinboyewa, T., Li, Z., Ning, H., & Lessani, M. (2024/2025). GIS Copilot: towards an autonomous GIS agent for spatial analysis. *International Journal of Digital Earth, 18*.

## What This Paper Says

Presents GIS Copilot, a QGIS-embedded LLM agent that receives natural language queries and generates PyQGIS code for spatial analysis. Includes documentation over key GIS tools and parameters. Incorporates external libraries such as GeoPandas.

### Architecture

- QGIS plugin (Python)
- Natural language input via chat interface
- LLM (GPT-4) generates PyQGIS code
- Code executed in QGIS Python console
- Results shown in QGIS canvas

### Documentation Approach

- Provides LLM with QGIS tool documentation
- Includes parameter descriptions
- No MCP protocol — direct prompt engineering

## Key Findings

- **High success on basic tasks:** ~90% (single buffer, single clip)
- **Good success on intermediate tasks:** ~75% (buffer + clip pipeline)
- **Challenges on advanced tasks:** ~45% (multi-step with reasoning)
- Documentation helps but doesn't eliminate errors
- Advanced tasks fail on: parameter selection, workflow ordering, error recovery

### Success Rate Table

| Task Complexity | Success Rate |
|---|---|
| Basic (single operation) | ~90% |
| Intermediate (2-3 operations) | ~75% |
| Advanced (4+ operations) | ~45% |

## Why This Paper Matters

- **First QGIS-embedded LLM agent** — direct precedent for GeoAIWorkbench
- **Establishes difficulty stratification** — informs GeoAIWorkbench task tiers
- **Documents advanced task failure** — motivates PB2 (difficulty moderation)
- **Code generation baseline** — GeoAIWorkbench compares MCP against similar setup

## Relevance to GeoAIWorkbench

Very high relevance:

1. **Direct competitor** — must differentiate GeoAIWorkbench from GIS Copilot
2. **Justifies difficulty stratification** — advanced tasks are the challenge zone
3. **Justifies MCP paradigm study** — GIS Copilot only tests code generation
4. **QGIS integration precedent** — architecture patterns applicable

### Differentiation from GIS Copilot

| Aspect | GIS Copilot | GeoAIWorkbench |
|---|---|---|
| Paradigms | Code generation only | 3 conditions (MCP-5, MCP-15, CodeGen) |
| Agents | Single (GPT-4 in plugin) | 4 external CLI agents |
| Evaluation | Manual + heuristic | 7-layer metrics, 1,800 runs |
| Security | Not evaluated | PB5 with 5 adversarial tasks |
| Tool count | N/A (code gen) | PB7 (MCP-5 vs MCP-15) |

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter I | Section 1.3 | QGIS integration precedent |
| Chapter II | Section 2.1 | GIS agent systems |
| Chapter IV | Section 4.3 | Difficulty stratification justification |
| Chapter VI | Section 6.2 | Baseline comparison for advanced task failures |

## Related Papers

- Li & Ning (2023) — Vision that GIS Copilot operationalizes
- Han et al. (2026) — More sophisticated but similar concept
- Wu et al. (2025) — Multi-agent alternative
- Ning et al. (2025) — Data retrieval extension

## Key Quote

*"GIS Copilot demonstrates high success on basic and intermediate tasks but reveals persistent challenges in fully autonomous advanced multistep spatial analysis."* — Akinboyewa et al. (2025)

## Critique / Limitations

- Only code generation paradigm tested
- Single LLM backend (GPT-4)
- No systematic difficulty definitions
- No security analysis
- Small task set
- Manual verification (labor-intensive)

## BibTeX Key

`akinboyewa2025giscopilot`
