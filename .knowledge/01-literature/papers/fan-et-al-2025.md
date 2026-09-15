---
id: KB-01-fan-et-al-2025
title: "Fan et al. (2025) — MCPToolBench++"
category: literature
subcategory: paper-summary
tags: [mcptoolbench, benchmark, mcp-ecosystem, safety, fan-et-al]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
  - KB-01-wang-et-al-2025
  - KB-01-yin-et-al-2025
authoritative: false
implementation_status: specified
references:
  - fan2025mcptoolbench
llm_hints:
  primary_purpose: "Large-scale MCP benchmark analyzing 22K+ repos and 1.5K benchmark items"
  key_facts:
    - "1,500 benchmark items from real marketplace configs"
    - "22,000+ MCP-tagged GitHub repositories analyzed"
    - "Fewer than 5% actually include servers"
    - "Reports safety, reliability, privacy risks in community servers"
  common_questions:
    - "How big is the MCP ecosystem?"
    - "What safety risks exist?"
    - "How was the benchmark built?"
---

# Fan et al. (2025) — MCPToolBench++

## Full Citation

Fan, S., Ding, X., Zhang, L., & Mo, L. (2025). MCPToolBench++: A Large Scale AI Agent Model Context Protocol MCP Tool Use Benchmark. *ArXiv, abs/2508.07575*.

## What This Paper Says

Large-scale empirical study of the MCP ecosystem plus a benchmark synthesized from real marketplace configurations.

### Ecosystem Analysis

- **22,000+ MCP-tagged GitHub repositories** analyzed
- **Fewer than 5%** actually include MCP servers
- Ecosystem growing rapidly but with quality issues
- Safety, reliability, privacy risks common in community servers

### Benchmark Details

- **1,500 benchmark items** synthesized from real MCP marketplace configs
- Covers diverse domains
- Includes safety adversarial cases
- Uses real production servers where possible

## Key Findings

- **MCP adoption gap:** Many repos claim MCP support but few implement servers
- **Safety uneven:** Community MCP servers have inconsistent safety practices
- **Privacy risks:** Some servers leak sensitive data
- **Prompt injection vulnerabilities** widespread

## Why This Paper Matters

- **Validates paradigm boundary approach** — community servers have `execute_code` risks
- **Quantifies safety concerns** in MCP ecosystem
- **Provides comparison baseline** for GeoAIWorkbench security analysis

## Relevance to GeoAIWorkbench

**Moderate-high relevance.**

### Direct Applications

1. **Paradigm boundary justification** — evidence that many MCP servers are unsafe
2. **Adversarial task design** — informs ADV-01 to ADV-05 patterns
3. **Attack surface analysis** — provides context for GeoMCP security posture
4. **Ecosystem context** — Chapter III discussion

### Design Validation

GeoAIWorkbench's decision to build custom GeoMCP (rather than use community qgis-mcp) is validated by:
- Community servers often expose `execute_code`
- Safety practices inconsistent
- Privacy leakage possible

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.3 | MCP ecosystem statistics |
| Chapter III | Section 3.5 | Security concerns baseline |
| Chapter IV | Section 4.3 | Adversarial task design justification |
| Chapter V | Section 5.3 | GeoMCP security hardening rationale |

## Related Papers

- Wang et al. (2025) MCP-Bench — Similar scale benchmark
- Yin et al. (2025) LiveMCP-101 — Multi-step benchmark
- Hou et al. (2025) — Security threats framework

## Key Quote

*"MCP ecosystems grew rapidly by mid-2025, with over 4,000 MCP servers across marketplace and GitHub communities, but fewer than 5% of 22,000+ MCP-tagged repositories actually included servers."* — Fan et al. (2025)

## BibTeX Key

`fan2025mcptoolbench`
