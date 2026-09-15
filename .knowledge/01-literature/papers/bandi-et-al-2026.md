---
id: KB-01-bandi-et-al-2026
title: "Bandi et al. (2026) — MCP-Atlas"
category: literature
subcategory: paper-summary
tags: [mcp-atlas, benchmark, real-servers, competency, bandi]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14]
related:
  - KB-01-round2-additions
  - KB-01-wang-et-al-2025
authoritative: false
implementation_status: specified
references:
  - bandi2026mcpatlas
llm_hints:
  primary_purpose: "Large-scale MCP benchmark with real MCP servers, sub-60% success on hard tasks"
  key_facts:
    - "Large-scale benchmark with real MCP servers"
    - "Sub-60% success on hard multi-step tasks"
    - "Tool-use competency framework"
    - "Confirms MCP capability gap"
  common_questions:
    - "What is MCP-Atlas?"
    - "How does it compare to MCP-Bench?"
    - "What are the sub-60% results?"
---

# Bandi et al. (2026) — MCP-Atlas

## Full Citation

Bandi, C., Hertzberg, B., Boo, G., Polakam, T., Da, J., Hassaan, S., Sharma, M., Park, A., Hernandez, E., Rambado, D., Salazar, I., Cruz, R. M. O., Rane, C., Levin, B., Kenstler, B., & Liu, B. (2026). MCP-Atlas: A Large-Scale Benchmark for Tool-Use Competency with Real MCP Servers. *ArXiv, abs/2602.00933*.

## What This Paper Says

Large-scale MCP benchmark using real production MCP servers. Framework for measuring tool-use competency across diverse scenarios.

### Benchmark Characteristics

- Real MCP servers (not synthesized)
- Tool-use competency framework
- Diverse task scenarios
- Multi-step orchestration required

### Competency Framework

Measures:
- Tool discovery
- Tool selection
- Parameter inference
- Multi-tool orchestration
- Error recovery

## Key Findings

- **Sub-60% success on hard multi-step tasks** — matches LiveMCP-101 findings
- Real MCP servers reveal capability gaps
- Tool count matters for orchestration
- Error recovery limits practical deployment

## Why This Paper Matters

- **Independent confirmation** of MCP capability gap (Yin et al. 2025)
- **Real server evaluation** — validates realistic scenarios
- **Tool-use competency framework** — reusable

## Relevance to GeoAIWorkbench

**Moderate relevance.**

### Confirms Expected Difficulty

Bandi et al. + Yin et al. both report sub-60% on hard tasks. GeoAIWorkbench should expect similar range on advanced GIS tasks (PB2).

### Not Applicable

- Different domain (general vs GIS)
- Different tool count
- Not paradigm comparison

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.3 | MCP benchmarks landscape |
| Chapter IV | Section 4.5 | Expected difficulty range |
| Chapter VI | Section 6.2 | Comparison to sub-60% findings |

## Related Papers

- Wang et al. (2025) MCP-Bench
- Yin et al. (2025) LiveMCP-101
- Fan et al. (2025) MCPToolBench++

## Key Quote

*"Real MCP servers reveal significant capability gaps, with sub-60% success rates on hard multi-step tasks even for state-of-the-art LLMs."* — Bandi et al. (2026)

## BibTeX Key

`bandi2026mcpatlas`
