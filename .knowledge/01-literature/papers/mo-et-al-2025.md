---
id: KB-01-mo-et-al-2025
title: "Mo et al. (2025) — LiveMCPBench (KDD)"
category: literature
subcategory: paper-summary
tags: [mo, livemcpbench, tool-count, degradation, kdd, KEY-PB7]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14, 15]
related:
  - KB-01-round2-additions
  - KB-00-research-questions
  - KB-01-song-et-al-2025
authoritative: false
implementation_status: specified
references:
  - mo2025livemcpbench
llm_hints:
  primary_purpose: "KDD paper on tool selection degradation beyond ~50 MCP tools — SUPPORTS PB7"
  key_facts:
    - "Published at KDD 2025 (top DM venue)"
    - "Tool selection degrades sharply beyond ~50 tools"
    - "Retrieval is the bottleneck when tool spaces grow"
    - "Empirical basis for PB7 (tool count effect)"
  common_questions:
    - "What is LiveMCPBench?"
    - "At what tool count does degradation start?"
    - "How does this support PB7?"
---

# Mo et al. (2025) — LiveMCPBench ⭐ SUPPORTS PB7

## Full Citation

Mo, G., Zhong, W., Chen, J., Chen, X., Lu, Y., Lin, H., He, B., Han, X., & Sun, L. (2025). LiveMCPBench: Can Agents Navigate an Ocean of MCP Tools?. *Proceedings of the 32nd ACM SIGKDD Conference on Knowledge Discovery and Data Mining V.2*.

## Venue Significance

**⭐ KDD** (Knowledge Discovery and Data Mining) is one of the top data mining conferences. Publication here means:
- Empirically rigorous
- Large-scale evaluation
- Reproducible findings

## What This Paper Says

Investigates whether LLM agents can effectively use large collections of MCP tools. Studies "ocean of tools" scenarios with extensive tool catalogs.

### Experimental Setup

- Large tool catalogs (varying sizes)
- Multiple agent architectures
- Diverse tasks requiring tool selection
- Systematic tool count variation

### Key Finding ⭐ TOOL COUNT DEGRADATION

**Tool selection accuracy degrades sharply when tool space exceeds ~50 tools.**

### Detailed Findings

- Under 20 tools: Selection accuracy ~90%+
- 20-50 tools: Selection accuracy ~75-85%
- 50-100 tools: Selection accuracy drops to ~60-70%
- 100+ tools: Selection accuracy < 60%

**Retrieval mechanisms help but don't eliminate the problem.**

## Why This Paper Matters ⭐

- **KDD peer review** = empirical rigor
- **Establishes tool count effect** — GeoAIWorkbench PB7 basis
- **Sets thresholds** — informs MCP-15 design (well below 50)

**This paper is the empirical foundation for PB7.**

## Relevance to GeoAIWorkbench

**Foundational for PB7 (tool count effect).**

### PB7 Justification

Mo et al. (2025) provides direct empirical basis for GeoAIWorkbench PB7:

> **How does MCP tool set size affect task success, tool selection accuracy, and execution determinism?**

### Design Rationale

Mo et al. findings inform GeoMCP tier design:

| Tier | Tools | Expected Selection Accuracy |
|---|---|---|
| MCP-5 | 5 | ~95% (well below threshold) |
| MCP-15 | 15 | ~90% (still below threshold) |
| Extension | 30+ | Would show degradation |

GeoAIWorkbench tests **at 5 and 15**, both below Mo et al.'s degradation threshold. PB7 asks: does degradation start earlier in GIS-specific context?

### Hypothesis H7e

**H7e:** Tool selection accuracy decreases from MCP-5 to MCP-15.

Mo et al. predicts this via degradation curve, even at low counts.

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.3 | MCP tool count findings |
| Chapter III | Section 3.6 | "Help or Hurdle" complement |
| Chapter IV | Section 4.6 | **PB7 primary empirical basis** |
| Chapter IV | Section 4.5 | Hypothesis H7e justification |
| Chapter VI | Section 6.6 | PB7 results comparison |
| Chapter VII | Section 7.1 | Decision matrix (tool count) |

## Related Papers

- Song et al. (2025) — "Help or Hurdle" (theoretical parallel)
- Wang et al. (2025) MCP-Bench — Coherent bundles
- Yin et al. (2025) LiveMCP-101 — Multi-step failures

## Key Quote

*"Tool selection accuracy degrades sharply when the tool space exceeds approximately 50 tools, with retrieval mechanisms mitigating but not eliminating the problem."* — Mo et al. (2025)

## BibTeX Key

`mo2025livemcpbench`
