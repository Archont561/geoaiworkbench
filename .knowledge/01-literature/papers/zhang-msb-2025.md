---
id: KB-01-zhang-msb-2025
title: "Zhang D. et al. (2025) — MCP Security Bench (MSB)"
category: literature
subcategory: paper-summary
tags: [zhang, msb, mcp-security-bench, attacks, benchmark]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14]
related:
  - KB-01-round2-additions
  - KB-01-hou-et-al-2025
  - KB-01-maloyan-namiot-2026
authoritative: false
implementation_status: specified
references:
  - zhang2025msb
llm_hints:
  primary_purpose: "Dedicated attack benchmark for MCP agents with 6 attack categories"
  key_facts:
    - "6 attack categories for MCP security testing"
    - "Systematic attack benchmark"
    - "Complements Hou et al. taxonomy"
    - "Note: Different Zhang than GeoAnalystBench"
  common_questions:
    - "What is MSB?"
    - "What are the 6 attack categories?"
    - "Is this the same Zhang as GeoAnalystBench?"
---

# Zhang D. et al. (2025) — MCP Security Bench (MSB)

## Full Citation

Zhang, D., Li, Z., Luo, X., Liu, X., Li, P., & Xu, W. (2025). MCP Security Bench (MSB): Benchmarking Attacks Against Model Context Protocol in LLM Agents. *ArXiv, abs/2510.15994*.

## Note on Author Confusion

**Different Zhang** than GeoAnalystBench:
- Zhang, Q. et al. (2025) — GeoAnalystBench (primary task source)
- **Zhang, D. et al. (2025)** — MSB (this paper)

Different research groups, different topics.

## What This Paper Says

Dedicated attack benchmark for MCP agents. Systematizes 6 attack categories with concrete test cases.

### 6 Attack Categories

1. **Prompt Injection** — Tool results contain instructions
2. **Parameter Manipulation** — Adversarial parameter values
3. **Data Exfiltration** — Tool leaks sensitive data
4. **Tool Confusion** — Trick agent into wrong tool
5. **Chain Attacks** — Multi-server exploitation
6. **Resource Abuse** — Denial of service via tools

### Benchmark Contribution

- Standardized attack test cases
- Systematic evaluation methodology
- Reproducible security assessment

## Key Findings

- Most MCP servers vulnerable to multiple attack categories
- Prompt injection most common
- Parameter manipulation second
- Community servers particularly at risk

## Why This Paper Matters

- **Standardized security testing** — reproducible attacks
- **6-category framework** — extends Hou et al.
- **Attack benchmark methodology**

## Relevance to GeoAIWorkbench

**High relevance for PB5.**

### ADV Task Alignment

GeoAIWorkbench ADV-01 to ADV-05 cover 5 of 6 MSB categories:

| ADV Task | MSB Category |
|---|---|
| ADV-01 | Prompt Injection |
| ADV-02 | Parameter Manipulation |
| ADV-03 | Parameter Manipulation |
| ADV-04 | Parameter Manipulation |
| ADV-05 | Prompt Injection (via tool result) |

**Not covered:** Chain Attacks (single server), Resource Abuse (rate limiting not tested).

### Methodology

MSB systematic approach informs GeoAIWorkbench ADV task design:
- Standardized test cases
- Reproducible outcomes
- Attack success/failure clear

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.5 | Security attack benchmarks |
| Chapter IV | Section 4.3 | ADV task categorization |
| Chapter VI | Section 6.5 | **PB5 results comparison** |

## Related Papers

- Hou et al. (2025) TOSEM — Threat taxonomy
- Maloyan & Namiot (2026) — Attack implementations

## Key Quote

*"MSB categorizes MCP attacks into 6 systematic categories: prompt injection, parameter manipulation, data exfiltration, tool confusion, chain attacks, and resource abuse."* — Zhang, D. et al. (2025)

## BibTeX Key

`zhang2025msb`
