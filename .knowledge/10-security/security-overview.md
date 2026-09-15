---
id: KB-10-security-overview
title: "Security Overview — Layer 7"
category: security
subcategory: overview
tags: [security, overview, layer7, PB5, hou-et-al]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14, 15]
related:
  - KB-03-layer7-security
  - KB-01-hou-et-al-2025
  - KB-00-research-questions
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Security as first-class evaluation dimension in GeoAIWorkbench"
  key_facts:
    - "Security added after Hou et al. (2025) ACM TOSEM"
    - "Layer 7 in metrics framework"
    - "PB5 research question"
    - "4 security metrics: ASS, PIR, PVC, DER"
    - "5 adversarial tasks"
  common_questions:
    - "Why is security a metric?"
    - "What security threats exist?"
    - "How is security evaluated?"
---

# Security Overview — Layer 7

## Why Security Is First-Class

Hou et al. (2025) in ACM TOSEM established that MCP security is not optional:
- MCP enlarges the attack surface
- Protocol-specific risks (prompt injection, trust propagation)
- Community MCP servers often unsafe (Fan et al., 2025)

GeoAIWorkbench adds security as **Layer 7** and **PB5**.

## Threat Model (Hou et al. Taxonomy Applied)

| Threat | GeoMCP Risk | Mitigation |
|---|---|---|
| Capability Exposure | Medium (15 tools in MCP-15) | P1: No execute_code |
| Prompt Injection | Medium (tool results as context) | Output sanitization |
| Trust Propagation | Low (single server) | No server chaining |
| Parameter Manipulation | Low-Medium | Pydantic validators |
| Data Exfiltration | Low | Workspace scoping |

## Security Metrics

| Metric | MCP-5 | MCP-15 | CodeGen |
|---|---|---|---|
| Attack Surface Size | 24 | 93 | ∞ |
| Prompt Injection Resistance | TBD | TBD | TBD |
| Param Validation Coverage | 100% | 100% | 0% |
| Data Exfiltration Risk | Low | Low-Medium | High |

## Security by Condition

### MCP-5 (Safest)
- 5 constrained tools
- No code execution
- Pydantic validation on all params
- Structured JSON output only
- Workspace scoped

### MCP-15 (Moderate)
- 15 tools (larger surface)
- `calculate_field` introduces expression risk
- All params still validated
- Same output sanitization

### CodeGen (Highest Risk)
- Unlimited code execution
- No schema validation
- Agent can access any file, network, process
- Mitigated only by Docker sandbox

## Related Files

- [KB-03-layer7-security](../03-metrics/layer7-security.md)
- [KB-10-threat-taxonomy-hou](threat-taxonomy-hou.md)
- [KB-10-adversarial-task-design](adversarial-task-design.md)
- [KB-01-hou-et-al-2025](../01-literature/papers/hou-et-al-2025.md)
