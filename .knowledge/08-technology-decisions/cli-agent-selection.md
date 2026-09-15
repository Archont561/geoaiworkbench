---
id: KB-08-cli-agent-selection
title: "Decision: CLI Agent Selection"
category: technology-decisions
subcategory: decision
tags: [decision, cli,agent,selection]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-15-cli-agent-docs
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "CLI Agent Selection — rationale and outcome"
  key_facts:
    - "4 primary: OpenCode, Claude Code, Codex, Goose; 2 backup: Gemini CLI, Cline; config per paradigm per agent; pin versions in install_agents.sh"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: CLI Agent Selection

## Context

Which 4 agents to use as black boxes

## Analysis

OpenCode: native MCP, opencode.json, ACP headless; Claude Code: native MCP, .mcp.json, --print mode, no BYOM; Codex CLI: native MCP, config.toml, sandbox, no BYOM; Goose: native MCP, BYOM (Ollama/OpenRouter), goose run headless; Gemini CLI: backup, 0.59.0; Cline CLI: backup, 3.0.24 standalone; Aider: excluded (no native MCP)

## Decision

4 primary: OpenCode, Claude Code, Codex, Goose; 2 backup: Gemini CLI, Cline; config per paradigm per agent; pin versions in install_agents.sh

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-15-cli-agent-docs
