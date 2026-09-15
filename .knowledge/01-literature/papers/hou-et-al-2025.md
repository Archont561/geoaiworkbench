---
id: KB-01-hou-et-al-2025
title: "Hou et al. (2025) — MCP Landscape, Security Threats (ACM TOSEM)"
category: literature
subcategory: paper-summary
tags: [hou, mcp, security, threats, tosem, taxonomy, KEY]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14]
related:
  - KB-01-round2-additions
  - KB-00-research-questions
  - KB-10-threat-taxonomy-hou
authoritative: false
implementation_status: specified
references:
  - hou2025mcp
llm_hints:
  primary_purpose: "FOUNDATIONAL security threat taxonomy for MCP in top SE venue (ACM TOSEM)"
  key_facts:
    - "Published in ACM TOSEM (top 3 SE journal)"
    - "Comprehensive MCP threat taxonomy"
    - "Established security as mandatory evaluation dimension"
    - "Directly motivated PB5 addition"
    - "Attack surface: capability exposure, prompt injection, trust propagation"
  common_questions:
    - "What are MCP security threats?"
    - "Why is this in ACM TOSEM?"
    - "How does GeoAIWorkbench apply the taxonomy?"
---

# Hou et al. (2025) — MCP Landscape, Security Threats ⭐ FOUNDATIONAL

## Full Citation

Hou, X., Zhao, Y., Wang, S., & Wang, H. (2025). Model Context Protocol (MCP): Landscape, Security Threats, and Future Research Directions. *ACM Transactions on Software Engineering and Methodology*.

## Venue Significance

**⭐ ACM TOSEM** is one of the top 3 software engineering journals (alongside IEEE TSE and ACM TOPLAS). Publication here means:
- Security IS a mandatory research dimension
- Community consensus on MCP threats
- Peer-reviewed threat taxonomy

## What This Paper Says

Comprehensive analysis of the MCP ecosystem and security landscape. Introduces threat taxonomy that has become the standard reference for MCP security research.

### MCP Ecosystem Analysis

- Growth trajectory
- Server distribution
- Adoption patterns
- Quality variation

### Security Threat Taxonomy ⭐ ADOPTED BY GEOAIWORKBENCH

**Categories:**

1. **Capability Exposure** — Server exposes too much functionality
   - Example: `execute_code` tool
   - Mitigation: Paradigm boundary

2. **Prompt Injection Channels** — Tool results contain instructions
   - Example: Layer descriptions with "ignore previous instructions"
   - Mitigation: Output sanitization

3. **Trust Propagation** — Trust flows through server chains
   - Example: Malicious sub-server exploits main server
   - Mitigation: Server isolation

4. **Parameter Manipulation** — Adversarial parameter values
   - Example: Path traversal in file names
   - Mitigation: Pydantic validators

5. **Data Exfiltration** — Server leaks sensitive data
   - Example: Unrestricted file access
   - Mitigation: Workspace scoping

### Future Research Directions

- Security-first MCP design
- Sandbox mechanisms
- Trust boundary definitions
- Standardized security testing

## Key Findings

- MCP ecosystem growing rapidly
- Security concerns pervasive
- No consensus on security best practices
- Community MCP servers often unsafe
- Threat taxonomy needs standardization

## Why This Paper Matters ⭐

- **ACM TOSEM publication** = top-tier peer review
- **Established security taxonomy** as reference
- **Motivated PB5 addition** to GeoAIWorkbench
- **Justified security dimension** as mandatory

**This single paper changed GeoAIWorkbench thesis structure.**

## Relevance to GeoAIWorkbench

**Foundational — highest possible relevance.**

### PB5 Justification

Before Hou et al. (2025):
- Security was optional consideration
- GeoAIWorkbench focused on effectiveness

After Hou et al. (2025):
- Security is mandatory evaluation dimension
- PB5 added as primary research question
- Layer 7 (Security) added to metrics
- 5 adversarial tasks (ADV-01 to ADV-05) designed
- Attack surface analysis required

### Direct Application

GeoAIWorkbench applies Hou et al.'s taxonomy:

| Threat Category | GeoMCP Mitigation |
|---|---|
| Capability Exposure | Paradigm boundary (no `execute_code`) |
| Prompt Injection | Output sanitization (structured JSON) |
| Trust Propagation | Single-server design (no chaining) |
| Parameter Manipulation | Pydantic validators (gt=0, regex, etc.) |
| Data Exfiltration | Workspace scoping (input/output dirs) |

### Adversarial Task Design

ADV-01 to ADV-05 directly map to Hou et al. threats:

- **ADV-01:** Prompt injection via task description
- **ADV-02:** Parameter manipulation (SQL injection style)
- **ADV-03:** Invalid parameter values
- **ADV-04:** Malformed CRS codes
- **ADV-05:** Tool result contains instructions

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Wstęp | Introduction | Security motivation |
| Chapter III | Section 3.5 | **Primary security threats reference** |
| Chapter IV | Section 4.3 | Adversarial task justification |
| Chapter IV | Section 4.4 | Layer 7 metric framework |
| Chapter V | Section 5.3 | GeoMCP security hardening |
| Chapter VI | Section 6.5 | **PB5 results interpretation** |
| Chapter VII | Section 7.2 | Design principles P1-P8 |
| Chapter VII | Section 7.4 | Security research directions |

## Related Papers

- Zhang, D. et al. (2025) MSB — Attack benchmark
- Maloyan & Namiot (2026) — Attack implementations
- Wang et al. (2025) MCP-Bench — Broader benchmark

## Key Quote

*"MCP-specific attack surfaces arise from capability exposure, prompt injection channels, and trust propagation across servers, requiring dedicated security research as a first-class dimension of protocol evaluation."* — Hou et al. (2025)

## BibTeX Key

`hou2025mcp`
