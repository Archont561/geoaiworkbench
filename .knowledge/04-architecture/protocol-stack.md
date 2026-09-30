---
id: KB-04-protocol-stack
title: "Decision: MCP vs ACP vs A2A Protocol Stack"
category: technology-decisions
subcategory: decision
tags: [decision, protocol,stack,clarification]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - backlog-decision-register
  - KB-01-ehtesham-et-al-2025
  - KB-01-mcp-spec
  - KB-01-acp-spec
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "MCP vs ACP vs A2A Protocol Stack — rationale and outcome"
  key_facts:
    - "MCP is the studied paradigm; ACP is automation-only (how harness invokes OpenCode); A2A deferred to future work; Chapter III must clearly distinguish all three"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: MCP vs ACP vs A2A Protocol Stack

## Context

Distinguishing three commonly confused protocols

## Analysis

MCP = Agent→Tools (vertical, Anthropic); ACP (Agent Client Protocol) = Editor→Agent (vertical, OpenCode/Zed); A2A = Agent↔Agent (horizontal, AAIF); CRITICAL: OpenCode's 'opencode acp' uses ACP not A2A; historical ACP (Agent Communication Protocol) merged into A2A but is DIFFERENT from Agent Client Protocol

## Decision

MCP is the studied paradigm; ACP is automation-only (how harness invokes OpenCode); A2A deferred to future work; Chapter III must clearly distinguish all three

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-01-ehtesham-et-al-2025
- KB-01-mcp-spec
- KB-01-acp-spec
