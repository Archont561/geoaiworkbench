---
id: KB-01-ehtesham-et-al-2025
title: "Ehtesham et al. (2025) — Protocol Survey"
category: literature
subcategory: paper-summary
tags: [ehtesham, protocol-survey, mcp, acp, a2a, anp, interoperability]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14]
related:
  - KB-01-round2-additions
  - KB-01-mcp-spec
  - KB-01-acp-spec
  - KB-04-protocol-stack
authoritative: false
implementation_status: specified
references:
  - ehtesham2025survey
llm_hints:
  primary_purpose: "Systematic comparison of MCP, ACP, A2A, ANP protocols"
  key_facts:
    - "First systematic protocol comparison"
    - "Positions MCP as tool layer, A2A as agent layer"
    - "Clarifies confusion between protocols"
    - "Established stack model used by GeoAIWorkbench"
  common_questions:
    - "How do these protocols compare?"
    - "What is ANP?"
    - "Why is MCP for tools and A2A for agents?"
---

# Ehtesham et al. (2025) — Protocol Survey

## Full Citation

Ehtesham, A., Singh, A., Gupta, G. K., & Kumar, S. (2025). A survey of agent interoperability protocols: Model Context Protocol (MCP), Agent Communication Protocol (ACP), Agent-to-Agent Protocol (A2A), and Agent Network Protocol (ANP). *ArXiv, abs/2505.02279*.

## What This Paper Says

First systematic survey comparing agent interoperability protocols. Clarifies the distinctions between MCP, ACP, A2A, and ANP that are commonly confused in the literature.

### Four Protocols Compared

1. **MCP** (Model Context Protocol) — Agent ↔ Tools
   - Anthropic-driven
   - Vertical integration
   - JSON-RPC over stdio/HTTP

2. **ACP** (Agent Communication Protocol) — historical name, merged into A2A
   - Note: separate from Agent Client Protocol (also called ACP by OpenCode)

3. **A2A** (Agent-to-Agent Protocol) — Agent ↔ Agent
   - Google-driven (initially)
   - Horizontal integration
   - HTTP-based
   - AAIF governance

4. **ANP** (Agent Network Protocol) — Broader network layer
   - Network-scale coordination
   - Future-oriented
   - Less mature

### Protocol Stack Model ⭐ ADOPTED BY GEOAIWORKBENCH

```
┌──────────────────────────────────────────┐
│  ANP (Network Layer)                      │
│  Agent network coordination               │
├──────────────────────────────────────────┤
│  A2A (Agent Layer)                        │
│  Agent-to-agent communication             │
├──────────────────────────────────────────┤
│  MCP (Tool Layer)                         │
│  Agent-to-tool integration                │
└──────────────────────────────────────────┘
```

## Key Findings

- **Protocols address different concerns** — not competing
- **Confusion is common** due to overlapping names (ACP vs ACP)
- **MCP most mature** for tool integration
- **A2A gaining traction** for multi-agent coordination
- **ANP nascent**

## Why This Paper Matters

- **First systematic protocol comparison**
- **Clarifies terminology** (critical for Chapter III)
- **Establishes stack model** used by GeoAIWorkbench

## Relevance to GeoAIWorkbench

**High relevance for Chapter III clarity.**

### Direct Application

GeoAIWorkbench Chapter III uses Ehtesham et al.'s stack model to distinguish:

- MCP = Studied paradigm (tool integration)
- ACP = How harness invokes OpenCode (Agent Client Protocol, NOT the historical ACP)
- A2A = Deferred future work

### Clarity Requirement

Chapter III MUST clearly explain:
1. Two "ACPs" exist (historical Agent Communication ≠ Agent Client)
2. MCP and A2A serve different purposes (not competitors)
3. GeoAIWorkbench studies MCP layer only

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.2 | **Protocol stack model** |
| Chapter III | Section 3.2 | Distinguish MCP/ACP/A2A/ANP |
| Chapter VII | Section 7.4 | Future work (A2A extension) |

## Related Papers

- MCP Spec — Studied protocol
- ACP Spec (OpenCode) — Automation only
- A2A Spec — Future work

## Key Quote

*"MCP, ACP, A2A, and ANP address complementary rather than competing concerns in the agent interoperability stack, with confusion often arising from overlapping terminology and naming conventions."* — Ehtesham et al. (2025)

## BibTeX Key

`ehtesham2025survey`
