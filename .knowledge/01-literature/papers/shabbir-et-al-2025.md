---
id: KB-01-shabbir-et-al-2025
title: "Shabbir et al. (2025) — ThinkGeo"
category: literature
subcategory: paper-summary
tags: [thinkgeo, remote-sensing, tool-augmented, step-metrics, shabbir]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
authoritative: false
implementation_status: specified
references:
  - shabbir2025thinkgeo
llm_hints:
  primary_purpose: "Tool-augmented agent benchmark for remote sensing tasks with step-wise metrics"
  key_facts:
    - "Remote sensing focus (different from GeoAnalystBench vector focus)"
    - "Introduces step-wise metrics: ToolAcc, ArgAcc, StepAcc"
    - "Diagnostic value beyond binary success"
    - "Provides granular failure analysis"
  common_questions:
    - "What is ThinkGeo?"
    - "What are ToolAcc, ArgAcc, StepAcc?"
    - "How does it apply to vector tasks?"
---

# Shabbir et al. (2025) — ThinkGeo

## Full Citation

Shabbir, A., Munir, M. A., Dudhane, A., Sheikh, M. U., Khan, M. H., Fraccaro, P., Bernabé-Moreno, J., Khan, F., & Khan, S. (2025). ThinkGeo: Evaluating Tool-Augmented Agents for Remote Sensing Tasks. *ArXiv, abs/2505.23752*.

## What This Paper Says

Benchmark for tool-augmented LLM agents on remote sensing tasks. Introduces granular step-wise metrics that diagnose failure modes beyond binary task success.

### Focus Area

- **Remote sensing tasks** (different from vector GIS focus of GeoAnalystBench)
- Satellite imagery analysis
- Raster operations
- Multi-modal processing

### Step-Wise Metrics ⭐ ADOPTED PATTERN

1. **ToolAcc** — Tool selection accuracy
2. **ArgAcc** — Argument (parameter) accuracy
3. **StepAcc** — Overall step correctness
4. **Final correctness** — Task-level outcome

### Diagnostic Value

Enables understanding:
- Did agent pick wrong tool? → ToolAcc failure
- Did agent pick right tool with wrong params? → ArgAcc failure
- Did steps execute correctly? → StepAcc failure
- Did final output match? → Final correctness

Binary success alone hides these distinctions.

## Key Findings

- **Step-wise metrics reveal failure decomposition** invisible to binary success
- **Tool selection often correct but arguments wrong** — supports PEA emphasis
- **Multi-step tasks accumulate errors** — early failures cascade
- Remote sensing tasks reveal different failure patterns than vector tasks

## Why This Paper Matters

- **Validates step-wise metric pattern** — GeoAIWorkbench Layer 2 follows similar structure
- **Confirms PEA importance** — argument accuracy is critical
- **Provides diagnostic framework** — beyond binary success

## Relevance to GeoAIWorkbench

**Moderate-high relevance for methodology.**

### Metric Alignment

| ThinkGeo | GeoAIWorkbench |
|---|---|
| ToolAcc | Tool Selection Accuracy (Layer 2) |
| ArgAcc | PEA (Layer 2) |
| StepAcc | Workflow Validity (Layer 2) |
| Final correctness | TSR (Layer 1) |

### Non-Applicable

- Remote sensing tasks not in GeoAIWorkbench scope
- Different task types (raster vs vector)
- Different tool sets

### Future Extension

Remote sensing paradigm comparison would be natural extension:
- Add raster-specific MCP tools
- Adapt GeoMCP for satellite imagery
- Include in future work

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter II | Section 2.5 | GIS benchmarks (remote sensing) |
| Chapter IV | Section 4.4 | **Step-wise metrics precedent** |
| Chapter VII | Section 7.4 | Future work (remote sensing extension) |

## Related Papers

- Yu et al. (2026) GeoAgentBench — Also step-wise, vector focus
- Zhang et al. (2025) GeoAnalystBench — Vector focus

## Key Quote

*"Step-wise execution metrics such as ToolAcc, ArgAcc, StepAcc, and final correctness provide diagnostic value for identifying latent failure modes in planning and tool selection."* — Shabbir et al. (2025)

## BibTeX Key

`shabbir2025thinkgeo`
