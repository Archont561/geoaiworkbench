---
id: KB-01-yu-et-al-2026
title: "Yu et al. (2026) — GeoAgentBench + PEA Metric"
category: literature
subcategory: paper-summary
tags: [geoagentbench, benchmark, pea, plan-and-react, yu-et-al]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 6, 12]
related:
  - KB-01-original-13-references
  - KB-01-zhang-et-al-2025
  - KB-03-layer2-workflow
authoritative: false
implementation_status: specified
references:
  - yu2026geoagentbench
llm_hints:
  primary_purpose: "Dynamic execution benchmark with PEA metric adopted by GeoAIWorkbench"
  key_facts:
    - "117 atomic GIS tools"
    - "53 tasks"
    - "PEA (Parameter Execution Accuracy) metric — adopted by GeoAIWorkbench"
    - "Plan-and-React architecture"
    - "Sandbox-based runtime evaluation"
  common_questions:
    - "What is GeoAgentBench?"
    - "What is the PEA metric?"
    - "How does it differ from GeoAnalystBench?"
---

# Yu et al. (2026) — GeoAgentBench

## Full Citation

Yu, B., Yang, C., Hou, D., Liu, C., Liu, J., Wang, C., Zhang, Z., Li, H., & Yang, W. (2026). GeoAgentBench: A Dynamic Execution Benchmark for Tool-Augmented Agents in Spatial Analysis.

## What This Paper Says

Introduces GeoAgentBench, a dynamic execution benchmark that goes beyond static code matching (like GeoAnalystBench) by actually running the generated code and measuring runtime behavior.

### Task Suite

- **117 atomic GIS tools** (extensive coverage)
- **53 tasks** total
- Runtime execution evaluation
- VLM-based verification for maps

### PEA Metric ⭐ ADOPTED BY GEOAIWORKBENCH

**Parameter Execution Accuracy (PEA):**
```
PEA = (correctly_inferred_parameters) / (total_required_parameters)
```

Per tool call. Aggregated per task.

### Plan-and-React Architecture

- Plan step: agent proposes workflow
- React step: agent executes and adapts
- Runtime feedback drives replanning

## Key Findings

- Dynamic evaluation catches errors static analysis misses
- **PEA is the single largest determinant** of task success
- Parameter misalignment dominates failure modes
- Plan-and-React improves multi-step reliability
- VLM (Vision Language Model) useful for cartographic evaluation

## Why This Paper Matters

- **Introduces PEA metric** — GeoAIWorkbench directly adopts this
- **Validates runtime execution** approach (vs static analysis)
- **Shows parameter errors dominate** — informs security/validation design

## Relevance to GeoAIWorkbench

**Very high relevance.**

### Direct Adoptions

1. **PEA metric** — Added to Layer 2 (Workflow Process)
   - MCP source: Extract from MCPMonitor params
   - CodeGen source: Extract from QGIS Workflow IR + `checkParameterValues()`

2. **Runtime execution paradigm** — GeoAIWorkbench uses 4-layer eval including runtime

3. **VLM for map verification** — Consider for cartographic output tasks

### Comparison with GeoAgentBench

| Aspect | GeoAgentBench (Yu et al.) | GeoAIWorkbench |
|---|---|---|
| Tools | 117 atomic | 5 or 15 tiered |
| Tasks | 53 | 50 (from Zhang et al.) |
| Paradigm | Plan-and-React (single) | 3 conditions |
| Metric | PEA + execution | 7-layer framework |
| PEA | Introduced | **Adopted** |

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter II | Section 2.5 | Benchmark landscape |
| Chapter III | Section 3.3 | Dynamic execution benchmarks |
| Chapter IV | Section 4.4 | **PEA metric adoption** |
| Chapter IV | Section 4.5 | Task suite alternatives |
| Chapter VI | Section 6.4 | PEA analysis |
| Chapter VII | Section 7.4 | Runtime evaluation as best practice |

## Related Papers

- Zhang et al. (2025) — Static counterpart (GeoAnalystBench)
- Han et al. (2026) — Also uses runtime execution
- Wang et al. (2025) MCP-Bench — General MCP with runtime execution

## Key Quote

*"Parameter Execution Accuracy (PEA) emerges as the single largest determinant of task success, with parameter misalignment dominating failure modes in dynamic GIS environments."* — Yu et al. (2026)

## Critique / Limitations

- **117 tools may be too many** — some overlap
- **Plan-and-React only** — no paradigm comparison
- **Limited security analysis**
- **No tool count variation study**

## BibTeX Key

`yu2026geoagentbench`
