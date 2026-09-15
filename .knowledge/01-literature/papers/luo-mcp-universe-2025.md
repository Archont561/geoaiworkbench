---
id: KB-01-luo-mcp-universe-2025
title: "Luo et al. (2025) — MCP-Universe"
category: literature
subcategory: paper-summary
tags: [luo, mcp-universe, benchmark, real-world]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14]
related:
  - KB-01-round2-additions
  - KB-01-wang-et-al-2025
  - KB-01-bandi-et-al-2026
authoritative: false
implementation_status: specified
references:
  - luo2025mcpuniverse
llm_hints:
  primary_purpose: "Real-world MCP benchmark confirming planning and dependency chaining failures"
  key_facts:
    - "Real-world MCP servers benchmark"
    - "Confirms planning and dependency failures"
    - "Complements MCP-Bench and MCP-Atlas"
    - "Same author family as Luo et al. 2026 GeoJSON but different paper"
  common_questions:
    - "What is MCP-Universe?"
    - "Is this the same as GeoJSON Agents?"
    - "How does it complement other benchmarks?"
---

# Luo Z. et al. (2025) — MCP-Universe

## Full Citation

Luo, Z., Shen, Z., Yang, W., Zhao, Z., Jwalapuram, P., Saha, A., Sahoo, D., Savarese, S., Xiong, C., & Li, J. (2025). MCP-Universe: Benchmarking Large Language Models with Real-World Model Context Protocol Servers. *ArXiv, abs/2508.14704*.

## What This Paper Says

Real-world MCP benchmark focusing on production servers. Confirms planning and dependency chaining as primary failure modes.

### Note on Author Confusion

**Different Luo et al.** than GeoJSON Agents:
- Luo, Q. et al. (2026) — GeoJSON Agents (KEY prior work)
- **Luo, Z. et al. (2025)** — MCP-Universe (this paper)

Different research groups, different topics.

### Benchmark Characteristics

- Real production MCP servers
- Diverse domains
- Complex multi-step scenarios
- Emphasis on realistic conditions

## Key Findings

- Planning failures dominate
- Dependency chaining challenges
- Real-world conditions harder than synthetic
- Server quality varies dramatically

## Why This Paper Matters

- **Confirms multi-step failure patterns** (matches Wang et al., Yin et al., Bandi et al.)
- **Emphasizes production-grade evaluation**
- **Adds to MCP benchmark landscape**

## Relevance to GeoAIWorkbench

**Low-moderate relevance.**

### Confirmation Value

Adds to consensus that multi-step MCP tasks are hard. GeoAIWorkbench PB2 (difficulty moderation) should expect similar patterns.

### Not Applicable

- Different domain (general vs GIS)
- Not paradigm comparison

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.3 | MCP benchmarks landscape |
| Chapter VI | Section 6.2 | Multi-step failure confirmation |

## Related Papers

- Wang et al. (2025) MCP-Bench
- Yin et al. (2025) LiveMCP-101
- Bandi et al. (2026) MCP-Atlas

## BibTeX Key

`luo2025mcpuniverse`
