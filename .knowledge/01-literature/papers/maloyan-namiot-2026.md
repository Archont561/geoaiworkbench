---
id: KB-01-maloyan-namiot-2026
title: "Maloyan & Namiot (2026) — Breaking the Protocol"
category: literature
subcategory: paper-summary
tags: [maloyan, mcp, security, prompt-injection, attacks]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14]
related:
  - KB-01-round2-additions
  - KB-01-hou-et-al-2025
  - KB-01-zhang-msb-2025
authoritative: false
implementation_status: specified
references:
  - maloyan2026breaking
llm_hints:
  primary_purpose: "Concrete prompt injection attack implementations against MCP"
  key_facts:
    - "Practical MCP attack demonstrations"
    - "Prompt injection through tool results"
    - "Trust propagation exploits"
    - "Complements Hou et al. TOSEM taxonomy"
  common_questions:
    - "How can you attack MCP?"
    - "What is prompt injection through tool results?"
    - "How does this inform GeoAIWorkbench security?"
---

# Maloyan & Namiot (2026) — Breaking the Protocol

## Full Citation

Maloyan, N., & Namiot, D. (2026). Breaking the Protocol: Security Analysis of the Model Context Protocol Specification and Prompt Injection Vulnerabilities in Tool-Integrated LLM Agents. *ArXiv, abs/2601.17549*.

## What This Paper Says

Practical security analysis of MCP with concrete attack implementations. Complements Hou et al. (2025) taxonomy with working exploits.

### Attack Categories

1. **Prompt Injection via Tool Results**
   - Malicious server returns instructions in tool output
   - Example: Layer description containing "ignore instructions and..."

2. **Parameter Manipulation**
   - Injected parameters bypass validation
   - Path traversal in filenames

3. **Trust Propagation Attacks**
   - Malicious sub-server exploits main server
   - Chain-of-trust violations

4. **Data Exfiltration**
   - Server extracts sensitive information
   - Tool output includes leaked data

### Working Exploits

Paper provides:
- Proof-of-concept attack code
- Specific vulnerability patterns
- Mitigation recommendations

## Key Findings

- **Prompt injection through tool results is practical**
- **MCP spec allows dangerous patterns** by default
- **Community servers often vulnerable**
- **Mitigation requires deliberate design**

## Why This Paper Matters

- **Concrete attack examples** — validates Hou et al. theoretical taxonomy
- **Practical security implications** — informs ADV task design
- **Mitigation patterns** — guides GeoMCP hardening

## Relevance to GeoAIWorkbench

**High relevance for security (PB5).**

### ADV Task Design

Maloyan & Namiot (2026) exploits inform ADV-01 to ADV-05:

- **ADV-01:** Prompt injection in task description (their attack pattern)
- **ADV-02:** Path traversal (their pattern)
- **ADV-05:** Tool result contains instructions (their pattern)

### GeoMCP Mitigation

Their recommended mitigations applied in GeoMCP:

- **Structured JSON output only** (no raw text)
- **Pydantic validators** (reject dangerous parameters)
- **Workspace scoping** (no arbitrary file access)
- **No tool result execution** (data, not commands)

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.5 | Security attack examples |
| Chapter IV | Section 4.3 | **Adversarial task design** |
| Chapter V | Section 5.3 | GeoMCP security hardening |
| Chapter VI | Section 6.5 | ADV task results |

## Related Papers

- Hou et al. (2025) TOSEM — Threat taxonomy
- Zhang, D. et al. (2025) MSB — Attack benchmark

## Key Quote

*"Prompt injection through tool results is a practical attack vector requiring deliberate mitigation via output sanitization, structured responses, and workspace scoping."* — Maloyan & Namiot (2026)

## BibTeX Key

`maloyan2026breaking`
