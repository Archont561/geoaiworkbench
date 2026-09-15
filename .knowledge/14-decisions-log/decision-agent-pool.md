---
id: KB-14-decision-agent-pool
title: "Decision: Agent Pool: 4 Primary CLI Agents"
category: decisions-log
subcategory: decision
tags: [decision, decision,agent,pool]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-14-all-decisions-summary
  - KB-08-cli-agent-selection
  - KB-15-cli-agent-docs
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision record: Agent Pool: 4 Primary CLI Agents"
  key_facts:
    - "Choice: 4 primary: OpenCode, Claude Code, Codex CLI, Goose. 2 backup: Gemini CLI, Cline CLI. Pin versions. 12 config files (4×3 conditions)."
    - "Rejected: Custom-built agents (original idea)"
  common_questions:
    - "Why was this decision made?"
    - "What was the alternative?"
---

# Decision: Agent Pool: 4 Primary CLI Agents

## Context

Which production CLI agents to evaluate

## Analysis

Surveyed all major CLI agents for MCP support, headless mode, BYOM. OpenCode: native MCP, ACP headless. Claude Code: native MCP, --print. Codex: native MCP, sandbox. Goose: native MCP, BYOM. Gemini CLI: backup. Cline: backup. Aider: excluded (no MCP).

## Decision

4 primary: OpenCode, Claude Code, Codex CLI, Goose. 2 backup: Gemini CLI, Cline CLI. Pin versions. 12 config files (4×3 conditions).

## Rejected Alternative

Custom-built agents (original idea)

## Rationale

Would defeat black-box premise; not reproducible

## Impact

configs/ directory, cli-agent-docs

## Reversibility

Low — swap agent configs

## Evidence

See related files for supporting evidence.

## Related Files

- KB-14-all-decisions-summary
- KB-08-cli-agent-selection
- KB-15-cli-agent-docs
