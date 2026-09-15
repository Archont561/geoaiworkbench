---
id: KB-01-luo-et-al-2026
title: "Luo et al. (2026) — GeoJSON Agents (KEY PRIOR WORK)"
category: literature
subcategory: paper-summary
tags: [geojson-agents, function-calling, code-generation, comparison, luo-et-al, KEY]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 2, 12]
related:
  - KB-01-original-13-references
  - KB-00-project-overview
  - KB-00-research-questions
authoritative: false
implementation_status: specified
references:
  - luo2026geojson
llm_hints:
  primary_purpose: "CLOSEST PRIOR WORK — direct comparison of function calling vs code generation"
  key_facts:
    - "Only prior systematic comparison of the two paradigms"
    - "Code generation: 97.14%, Function calling: 85.71%"
    - "Only GPT-4o, only GeoJSON data, only one custom framework"
    - "GeoAIWorkbench extends this to QGIS + real MCP + multiple agents"
  common_questions:
    - "What is GeoJSON Agents?"
    - "How does GeoAIWorkbench differ?"
    - "Why is this the key prior work?"
---

# Luo et al. (2026) — GeoJSON Agents ⭐ KEY PRIOR WORK

## Full Citation

Luo, Q., Lin, Q., Xu, L., Wu, S., Mao, R., Wang, C., Feng, H., Huang, B., & Du, Z. (2026). GeoJSON agents: a multi-agent LLM architecture for geospatial analysis—function calling vs. code generation. *Big Earth Data*.

## What This Paper Says

**The most important prior work for GeoAIWorkbench.** First and only systematic comparison of function calling vs code generation paradigms in geospatial context.

### Architecture

- Multi-agent framework:
  - Product Manager (task decomposition)
  - Algorithm Engineer (workflow design)
  - Programmer (code/tool implementation)
  - Worker (execution)

### Experimental Setup

- **Only GPT-4o** as backend
- **Only GeoJSON** data (not shapefiles, rasters, etc.)
- **Custom framework** (not standard MCP)
- Function calling via GPT-4o's native mechanism
- Code generation via Python execution
- Task suite: geospatial operations on GeoJSON

## Key Findings

- **Code generation: 97.14% accuracy**
- **Function calling: 85.71% accuracy**
- Code generation better for complex/open-ended tasks
- Function calling more stable for structured/repetitive operations
- Function calling wins on execution consistency
- Code generation wins on flexibility

### Results Table

| Paradigm | Success Rate | Best For |
|---|---|---|
| Code Generation | **97.14%** | Complex, open-ended |
| Function Calling | 85.71% | Structured, repetitive |

## Why This Paper Matters

**⭐ THE most important paper for positioning GeoAIWorkbench.** Every claim GeoAIWorkbench makes must be positioned relative to this work.

## Relevance to GeoAIWorkbench

**Extremely high relevance.** GeoAIWorkbench directly extends this work.

### How GeoAIWorkbench Differs from Luo et al. (2026)

| Aspect | Luo et al. (2026) | GeoAIWorkbench |
|---|---|---|
| Data | GeoJSON only | QGIS shapefiles + rasters (real-world) |
| Environment | Custom framework | Real QGIS + Processing framework |
| Protocol | Custom function calling | **Standard MCP protocol** |
| Agents | GPT-4o only | 4 CLI agents (OpenCode, Claude, Codex, Goose) |
| Paradigms | 2 (function calling, code gen) | **3 (MCP-5, MCP-15, CodeGen)** |
| Tool count | Fixed | **Variable (5 vs 15) — PB7** |
| Security | Not evaluated | **PB5 with 5 adversarial tasks** |
| Reps | Single run | **3 repetitions for ED** |
| Statistical rigor | Basic | Bootstrap CIs, Cliff's delta, Bonferroni |
| Sample size | ~200 runs | **1,800 runs** |

### GeoAIWorkbench's 5 Contributions Over Luo et al.

1. **Real MCP protocol** (not custom framework)
2. **Multiple production agents** (not single GPT-4o)
3. **QGIS environment** (not GeoJSON only)
4. **Tool count experiment** (not fixed tool set)
5. **Security dimension** (not just success rate)

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Wstęp | Introduction | Establish research question exists |
| Chapter II | Section 2.4 | Compare/contrast prior work |
| Chapter IV | Section 4.2 | **Primary prior work to differentiate** |
| Chapter IV | Section 4.5 | Hypothesis basis (paradigm tradeoff) |
| Chapter VI | Section 6.1 | Baseline comparison |
| Chapter VII | Section 7.1 | Decision matrix contextualization |

## Related Papers

- Luo et al. (2025) — arXiv preprint of same work
- Han et al. (2026) — Code generation only
- Wu et al. (2025) — Multi-agent but code gen only

## Key Quote

*"Code generation achieved 97.14% accuracy while function calling reached 85.71%, with code generation better for complex open-ended tasks and function calling more stable for structured operations."* — Luo et al. (2026)

## Critique / Limitations (Important for GeoAIWorkbench)

- **Only GPT-4o** — generalization unclear
- **Only GeoJSON** — narrow data type
- **Custom framework** — not real MCP protocol
- **No repetitions** — no execution determinism measure
- **No security** — attack surface unmeasured
- **Fixed tool count** — no tool count effect study
- **Single-run analysis** — no confidence intervals

**Every one of these limitations is addressed by GeoAIWorkbench.**

## BibTeX Key

`luo2026geojson`
