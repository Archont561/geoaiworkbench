---
id: KB-01-acp-spec
title: "Agent Client Protocol Specification"
category: literature
subcategory: protocol-spec
tags: [acp, protocol, specification, opencode, editor-agent]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 4, 7]
related:
  - KB-01-original-13-references
  - KB-01-mcp-spec
  - KB-04-protocol-stack
authoritative: false
implementation_status: specified
references:
  - agentClientProtocol
llm_hints:
  primary_purpose: "ACP protocol specification for editor ↔ agent communication"
  key_facts:
    - "JSON-RPC over stdio"
    - "Editor drives agent (vertical)"
    - "NOT the same as A2A (agent ↔ agent)"
    - "Used by OpenCode (opencode acp), Cline, Zed"
    - "Most common confusion: ACP vs A2A"
  common_questions:
    - "What is ACP?"
    - "How does it differ from A2A?"
    - "What is opencode acp?"
---

# Agent Client Protocol (ACP) Specification

## Full Citation

Agent Client Protocol Specification. Various sources: OpenCode docs, Zed, Cline documentation.

## What This Specification Defines

JSON-RPC 2.0 protocol for editor/IDE ↔ coding agent communication over stdio.

### Scope

- **Editor ↔ Agent** (vertical, editor drives agent)
- Editor sends: task descriptions, file paths, user commands
- Agent responds: streaming updates, tool calls, results

### ⚠️ CRITICAL DISTINCTION: ACP ≠ A2A

**Most common confusion in the field.**

| Protocol | Scope | Direction | Governance |
|---|---|---|---|
| **ACP** | Editor ↔ Agent | Vertical | OpenCode/Zed |
| **A2A** | Agent ↔ Agent | Horizontal | AAIF |
| **MCP** | Agent ↔ Tools | Vertical | Anthropic |

**ACP did NOT merge into A2A.** The ACP that merged into A2A in August 2025 was a DIFFERENT ACP (Agent Communication Protocol), not this one.

### Current ACP (Agent Client Protocol)

- Used by: **OpenCode** (`opencode acp`), **Cline**, **Zed**
- Transport: stdio only
- Format: JSON-RPC

## Key Components

### Session Lifecycle
- Editor starts agent process
- Agent registers capabilities
- Editor sends messages
- Agent streams responses
- Editor closes session

### Message Types
- `task/execute` — Editor gives agent a task
- `response/stream` — Agent streams response
- `tool/call` — Agent invokes tool
- `session/close` — Editor terminates

## Why This Matters

- **Not directly used by GeoAIWorkbench as protocol**
- **Used indirectly:** benchmark harness invokes OpenCode via `opencode acp`
- **Distinction critical:** MCP is the studied protocol, ACP is just how we drive OpenCode

## Relevance to GeoAIWorkbench

**Low direct relevance, high importance for clarity.**

### Direct Application
- **Benchmark automation** — OpenCode invoked via `opencode acp` for headless benchmark runs
- **Not evaluated** — ACP is not the studied paradigm

### Clarity Requirement

Chapter III must clearly distinguish:

- MCP = "what the agent uses to talk to tools" (studied paradigm)
- ACP = "how the benchmark harness talks to the agent" (automation only)
- A2A = "how agents talk to each other" (not used, future work)

Failure to distinguish leads to reader confusion.

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.2 | Protocol stack clarification (MCP vs ACP vs A2A) |
| Chapter V | Section 5.5 | Benchmark automation setup |
| Chapter VII | Section 7.4 | A2A as future work (distinguish) |

## Related References

- MCP Spec — Different protocol (tool integration)
- Ehtesham et al. (2025) — Formal protocol survey clarifies distinctions
- OpenCode docs — https://opencode.ai — practical ACP usage

## Key Quote

*"The Agent Client Protocol enables editor-driven interaction with coding agents through structured JSON-RPC over stdio, distinct from agent-to-agent communication protocols."* — Various ACP sources

## Distinction Cheat Sheet

Copy-paste for thesis:

```
MCP (Model Context Protocol)
  agent → tools/resources
  Anthropic

ACP (Agent Client Protocol)
  editor → agent
  OpenCode/Zed/Cline
  ≠ A2A

A2A (Agent-to-Agent Protocol)
  agent ↔ agent
  AAIF governance
  Formerly separate ACP (different name)
```

## BibTeX Key

`agentClientProtocol`

## URL

- OpenCode docs: https://opencode.ai
- Zed docs: https://zed.dev
