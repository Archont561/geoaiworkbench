---
id: KB-01-wang-et-al-2025
title: "Wang et al. (2025) — MCP-Bench"
category: literature
subcategory: paper-summary
tags: [mcp-bench, benchmark, mcp, tool-use, wang-et-al]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
  - KB-01-fan-et-al-2025
  - KB-01-yin-et-al-2025
authoritative: false
implementation_status: specified
references:
  - wang2025mcpbench
llm_hints:
  primary_purpose: "Production-grade MCP benchmark with 28 servers and 250 tools"
  key_facts:
    - "28 production MCP servers"
    - "250 tools total"
    - "Scores tool validity, dependency order, planning, task completion"
    - "Emphasizes coherent tool bundles over flat tool lists"
    - "Repository: Accenture/mcp-bench"
  common_questions:
    - "What is MCP-Bench?"
    - "How does it evaluate MCP servers?"
    - "What does 'coherent bundles' mean?"
---

# Wang et al. (2025) — MCP-Bench

## Full Citation

Wang, Z., Chang, Q., Patel, H., Biju, S., Wu, C., Liu, Q., Ding, A., Rezazadeh, A., Shah, A., Bao, Y., & Siow, E. (2025). MCP-Bench: Benchmarking Tool-Using LLM Agents with Complex Real-World Tasks via MCP Servers. *ArXiv, abs/2508.20453*.

## What This Paper Says

Production-grade MCP benchmark using 28 real MCP servers with 250 tools total. Focuses on complex real-world tasks that require multi-tool orchestration.

### Benchmark Composition

- **28 production MCP servers**
- **250 tools** total
- Real-world tasks requiring dependency chains
- Cross-server orchestration scenarios

### Evaluation Framework

Scores:
- Tool validity (does the tool exist?)
- Schema compliance (are params correct?)
- Runtime success (does execution succeed?)
- **Dependency order** (are tools called in correct sequence?)
- Planning quality
- Task completion

### Key Design Principle

**Coherent tool bundles > flat tool lists**

MCP-Bench servers group related tools together (e.g., a "database" server has query/update/delete tools that share concepts). This is more realistic than random tool collections.

## Key Findings

- **Coherent tool bundles improve success rates**
- **Cross-server orchestration is the hardest task type**
- **Dependency order errors are common** even for strong models
- Server design quality matters more than tool count alone

## Why This Paper Matters

- **Validates small composable bundle approach** for GeoMCP
- **Provides evaluation framework** structure
- **Establishes production benchmarks** as MCP evaluation standard

## Relevance to GeoAIWorkbench

**High relevance.**

### Design Validation

GeoMCP's 5-tool (MCP-5) or 15-tool (MCP-15) design is validated by MCP-Bench findings:

- Not too few (impractical)
- Not too many (selection degradation)
- **Coherent bundle** (all GIS geoprocessing) — matches MCP-Bench principle
- Clear dependency structure (layer_info → operation → output)

### Metric Adoption

GeoAIWorkbench Layer 2 (Workflow Process) directly follows MCP-Bench:
- Tool Selection Accuracy
- Workflow Validity
- Step Order Accuracy (dependency)

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.3 | MCP benchmarks landscape |
| Chapter IV | Section 4.4 | Metric framework precedent |
| Chapter IV | Section 4.6 | Tool count rationale (coherent bundles) |
| Chapter V | Section 5.2 | GeoMCP design principles |
| Chapter VI | Section 6.1 | Comparison to MCP-Bench numbers |

## Related Papers

- Fan et al. (2025) MCPToolBench++ — Larger scale
- Yin et al. (2025) LiveMCP-101 — Dynamic execution
- Mo et al. (2025) LiveMCPBench — Ocean of tools

## Key Quote

*"MCP-Bench evaluates 28 production servers with 250 tools, showing that coherent tool bundles supporting intra-server dependency chains outperform large flat tool lists."* — Wang et al. (2025)

## Repository

- **GitHub:** https://github.com/Accenture/mcp-bench
- **Config directories:** `config/`, `mcp_servers/`, `tasks/`
- **Provides:** Reusable evaluation infrastructure

## BibTeX Key

`wang2025mcpbench`
