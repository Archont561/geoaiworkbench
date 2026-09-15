---
id: KB-01-yin-et-al-2025
title: "Yin et al. (2025) — LiveMCP-101"
category: literature
subcategory: paper-summary
tags: [livemcp, benchmark, dynamic-execution, parallel-reference, yin-et-al]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
  - KB-01-wang-et-al-2025
authoritative: false
implementation_status: specified
references:
  - yin2025livemcp
llm_hints:
  primary_purpose: "MCP benchmark with 41 servers and parallel reference execution for time-varying tool outputs"
  key_facts:
    - "41 MCP servers, 260 tools"
    - "Parallel reference execution handles time-varying outputs"
    - "Sub-60% success rate on hard multi-step tasks"
    - "Stress tests MCP-enabled agents"
  common_questions:
    - "What is LiveMCP-101?"
    - "What is parallel reference execution?"
    - "Why do agents fail on hard tasks?"
---

# Yin et al. (2025) — LiveMCP-101

## Full Citation

Yin, M., Shen, D., Xu, S., Han, J.-J., Dong, S., Zhang, M., Hu, Y., Liu, S., Wang, S., Indurthi, S., Wang, X., Chen, Y., & Song, K. (2025). LiveMCP-101: Stress Testing and Diagnosing MCP-enabled Agents on Challenging Queries. *ArXiv, abs/2508.15760*.

## What This Paper Says

Stress-test benchmark for MCP-enabled agents on challenging queries. Introduces parallel reference execution to handle time-varying tool outputs.

### Benchmark Composition

- **41 MCP servers**
- **260 tools** total
- Challenging multi-step queries
- Real-world scenarios

### Parallel Reference Execution

**Novel evaluation technique:**

Time-varying tools (e.g., "current weather", "stock prices") produce different outputs at different times. Comparing against static reference is impossible.

**Solution:**
1. Run reference implementation in parallel with agent
2. Both see same "current" state
3. Compare outputs at same moment
4. Enables evaluation of live/dynamic tools

### Diagnostic Framework

- Per-step failure analysis
- Error categorization
- Query difficulty stratification

## Key Findings

- **Sub-60% success rate on hard multi-step tasks** — significant capability gap
- **Dependency order failures dominate** on complex queries
- **Time-varying tools problematic** without parallel reference
- Even strong models struggle beyond 3-4 tool chain length

## Why This Paper Matters

- **Documents MCP capability gap** — motivates continued research
- **Introduces parallel reference technique** — useful methodology
- **Validates multi-step evaluation** approach

## Relevance to GeoAIWorkbench

**Moderate relevance.**

### Applicable Findings

1. **Sub-60% baseline** — expected difficulty range for advanced GIS tasks
2. **Multi-step failure mode** — validates PB2 (difficulty moderation)
3. **Diagnostic per-step analysis** — informs GeoAIWorkbench step tracking

### Non-Applicable

- Parallel reference execution not needed (GeoAIWorkbench tasks are deterministic)
- Time-varying tools not in GeoMCP (all GIS operations are pure functions)

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.3 | MCP benchmarks (production scale) |
| Chapter IV | Section 4.5 | Difficulty expectations |
| Chapter VI | Section 6.2 | Multi-step failure comparison |

## Related Papers

- Wang et al. (2025) MCP-Bench — Similar scale
- Fan et al. (2025) MCPToolBench++ — Larger scale, static tasks
- Mo et al. (2025) LiveMCPBench — Focuses on tool count

## Key Quote

*"Sub-60% success rate on hard multi-step MCP queries reveals a significant capability gap even for state-of-the-art LLM agents."* — Yin et al. (2025)

## BibTeX Key

`yin2025livemcp`
