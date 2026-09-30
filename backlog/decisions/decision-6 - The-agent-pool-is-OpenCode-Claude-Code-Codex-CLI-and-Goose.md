---
id: decision-6
title: 'The agent pool is OpenCode, Claude Code, Codex CLI and Goose'
date: '2026-09-30 21:42'
status: accepted
---
## Context

Four agents are needed as black boxes, each with native MCP support and a headless mode that a harness can drive.

## Decision

Primary pool: OpenCode (native MCP, `opencode.json`, ACP headless), Claude Code (`.mcp.json`, `--print`), Codex CLI (`config.toml`, sandbox) and Goose (BYOM via Ollama/OpenRouter, `goose run`). Backups: Gemini CLI and Cline. Aider is excluded — no native MCP. Versions are pinned at install time.

## Consequences

The agent pool is part of the reproducibility claim: an unpinned agent version silently changes the experiment. Only `opencode-ai` is pinned in this repository today; the other three are not.

Supersedes `.knowledge/08-technology-decisions/cli-agent-selection.md`, `.knowledge/14-decisions-log/decision-agent-pool.md` — deleted from the knowledge base; this decision is that content.
