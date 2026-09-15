---
id: KB-07-phase3-execution
title: "Phase: Benchmark Execution"
category: tooling
subcategory: phase
tags: [tooling, phase, phase3,execution]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-toolchain-overview
  - KB-15-cli-agent-docs
  - KB-06-orchestrator-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tools and workflow for Benchmark Execution"
  key_facts:
    - "Tools: Typer 0.12+, Rich 13+, OpenCode, Claude Code, Codex CLI, Goose, DeepEval 4.2"
  common_questions:
    - "What tools are used for Benchmark Execution?"
---

# Phase: Benchmark Execution

## Tools

Typer 0.12+, Rich 13+, OpenCode, Claude Code, Codex CLI, Goose, DeepEval 4.2

## Details

Typer CLI with Rich progress bars and tables; 4 CLI agents as black boxes; DeepEval provides MCP Use, MCP Task Completion, Tool Correctness metrics; agents configured per-condition via JSON/TOML/YAML configs

## Key Commands

```bash
pixi run benchmark-all; pixi run benchmark-status
```

## Related Files

- KB-07-toolchain-overview
- KB-15-cli-agent-docs
- KB-06-orchestrator-implementation
