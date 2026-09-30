---
id: KB-15-cli-agent-docs
title: "CLI Agent Documentation Links"
category: external-references
subcategory: agents
tags: [cli-agents, opencode, claude-code, codex, goose, gemini-cli, cline, aider, urls]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [4, 7]
related:
  - backlog-decision-6
  - KB-15-github-repositories
authoritative: false
implementation_status: specified
llm_hints:
  primary_purpose: "Documentation URLs for all evaluated CLI agents"
  key_facts:
    - "4 primary agents: OpenCode, Claude Code, Codex, Goose"
    - "2 backup agents: Gemini CLI, Cline CLI"
    - "Aider excluded (no native MCP)"
    - "Each agent has different MCP config format"
    - "All 4 agents run in all 3 conditions (MCP-5, MCP-15, CodeGen)"
  common_questions:
    - "How do I configure MCP for OpenCode?"
    - "What is the Claude Code config file?"
    - "Can I use Goose with local Ollama?"
    - "Does Cline work outside VS Code?"
    - "How do I switch between MCP-5 and MCP-15 conditions?"
---

# CLI Agent Documentation

Documentation for all CLI agents evaluated (or considered) in GeoAIWorkbench.

## Primary Agents (4)

### OpenCode

- **Site:** https://opencode.ai
- **GitHub:** https://github.com/opencode-ai/opencode
- **Version:** v2.x (exact version verified per benchmark run)
- **License:** Open source
- **MCP Support:** ✅ Native

#### MCP Configuration for MCP-5

File: `opencode.json` in working directory

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "servers": {
      "geoai": {
        "type": "local",
        "command": ["pixi", "run", "mcp-server"],
        "cwd": "/path/to/project",
        "env": {
          "GEOMCP_TIER": "5"
        }
      }
    }
  }
}
```

#### MCP Configuration for MCP-15

Same as above but with `"GEOMCP_TIER": "15"`.

#### CodeGen Configuration

Empty `mcp` section, PyQGIS available via subprocess:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {}
}
```

⚠️ **Breaking change (v2):** Config schema changed from `mcp.<name>` to `mcp.servers.<name>`.

#### Headless Modes

- `opencode acp` — ACP stdio protocol (used for benchmark automation)
- `opencode web` — Web server mode

#### ACP vs A2A

`opencode acp` uses **ACP (Agent Client Protocol)**, NOT A2A. See [KB-04-protocol-stack](../04-architecture/protocol-stack.md).

### Claude Code

- **Docs:** https://docs.anthropic.com/en/docs/claude-code
- **License:** Proprietary (Anthropic)
- **MCP Support:** ✅ Native
- **BYOM:** ❌ Anthropic models only

#### MCP Configuration for MCP-5

File: `.mcp.json` (project-level) or `~/.claude.json` (global)

```json
{
  "mcpServers": {
    "geoai": {
      "command": "pixi",
      "args": ["run", "mcp-server"],
      "env": {
        "GEOMCP_TIER": "5"
      }
    }
  }
}
```

#### MCP Configuration for MCP-15

Same as above but with `"GEOMCP_TIER": "15"`.

#### Headless Mode

```bash
claude --print "Your task here"
```

Also supports `--mcp-config` CLI flag for custom config paths (useful for switching between MCP-5 and MCP-15 configs).

#### Rate Limits

Depends on:
- Subscription tier (Free / Pro / Team / Enterprise)
- API vs subscription access
- Model selected (Claude Sonnet 4, Opus 4, etc.)

No single number applies universally.

### Codex CLI

- **GitHub:** https://github.com/openai/codex
- **License:** Open source
- **Version:** 0.153.3 (verified)
- **MCP Support:** ✅ Native
- **BYOM:** ❌ OpenAI models only (verified)

#### MCP Configuration for MCP-5

File: `~/.codex/config.toml`

```toml
[mcp_servers.geoai]
command = "pixi"
args = ["run", "mcp-server"]
env = { GEOMCP_TIER = "5" }
```

#### MCP Configuration for MCP-15

Same as above but with `env = { GEOMCP_TIER = "15" }`.

#### Sandbox Mode

Codex ships with `bwrap` sandbox on Linux. Configuration in `config.toml`:

```toml
[sandbox]
mode = "workspace-write"
```

### Goose

- **Site:** https://block.github.io/goose/
- **GitHub:** https://github.com/block/goose
- **License:** Open source
- **MCP Support:** ✅ Native (70+ documented extensions)
- **BYOM:** ✅ **Excellent** — Anthropic, OpenAI, Google, Ollama, OpenRouter, Azure, Bedrock

#### MCP Configuration for MCP-5

Uses "extensions" concept. Configure via `goose configure`:

```yaml
extensions:
  geoai_mcp5:
    type: stdio
    command: pixi
    args: [run, mcp-server]
    env:
      GEOMCP_TIER: "5"
```

#### MCP Configuration for MCP-15

```yaml
extensions:
  geoai_mcp15:
    type: stdio
    command: pixi
    args: [run, mcp-server]
    env:
      GEOMCP_TIER: "15"
```

#### Headless Mode

```bash
goose run --instructions "Your task here" --with-extension geoai_mcp5
goose run --instructions "Your task here" --with-extension geoai_mcp15
```

Also supports recipes (YAML workflows) for CI.

## Backup Agents (2)

### Gemini CLI

- **GitHub:** https://github.com/google-gemini/gemini-cli
- **Version:** 0.59.0 stable (September 8, 2026)
- **License:** Open source
- **MCP Support:** ✅ Native

#### MCP Configuration

File: `~/.gemini/settings.json`

```json
{
  "mcpServers": {
    "geoai_mcp5": {
      "command": "pixi",
      "args": ["run", "mcp-server"],
      "cwd": "/path/to/project",
      "env": {
        "GEOMCP_TIER": "5"
      },
      "timeout": 30000,
      "trust": true
    },
    "geoai_mcp15": {
      "command": "pixi",
      "args": ["run", "mcp-server"],
      "cwd": "/path/to/project",
      "env": {
        "GEOMCP_TIER": "15"
      },
      "timeout": 30000,
      "trust": true
    }
  },
  "mcp": {
    "allowed": ["geoai_mcp5", "geoai_mcp15"],
    "excluded": []
  }
}
```

### Cline CLI

- **GitHub:** https://github.com/cline/cline
- **Version:** 3.0.24
- **License:** Apache-2.0
- **MCP Support:** ✅ Native

#### Standalone CLI Usage

```bash
cline "Run this task"
cline --json "List all layers"
```

Works outside VS Code (previously IDE-only).

## Excluded Agents

### Aider

- **Site:** https://aider.chat
- **GitHub:** https://github.com/Aider-AI/aider
- **Version:** 0.86.0
- **License:** Apache-2.0
- **MCP Support:** ❌ **Not native** (may have community plugins)
- **Excluded from benchmark:** No verified native MCP support

## Comparison Matrix

| Agent | Version | MCP | Config Format | Headless | BYOM | License |
|---|---|---|---|---|---|---|
| OpenCode | v2.x | ✅ | `opencode.json` | `acp` / `web` | Provider-dep | Open |
| Claude Code | current | ✅ | `.mcp.json` | `--print` | ❌ Claude only | Proprietary |
| Codex CLI | 0.153.3 | ✅ | `config.toml` | Sandbox | ❌ OpenAI only | Open |
| Goose | current | ✅ | YAML config | `goose run` | ✅ **Yes** | Open |
| Gemini CLI | 0.59.0 | ✅ | `settings.json` | Yes | Google-dep | Open |
| Cline CLI | 3.0.24 | ✅ | `.mcp.json`-style | `cline --json` | Provider-dep | Apache-2.0 |
| Aider | 0.86.0 | ❌ | N/A | Yes | ✅ | Apache-2.0 |

## 3-Condition Configuration Pattern

For each agent, the benchmark harness generates 3 config files:

- `agent_mcp5.json` — MCP with GEOMCP_TIER=5
- `agent_mcp15.json` — MCP with GEOMCP_TIER=15
- `agent_codegen.json` — No MCP, PyQGIS available via shell

The harness dispatches to the appropriate config based on the current condition:

```python
config_paths = {
    ("opencode", "mcp5"): "configs/opencode_mcp5.json",
    ("opencode", "mcp15"): "configs/opencode_mcp15.json",
    ("opencode", "codegen"): "configs/opencode_codegen.json",
    # ... same for other agents
}
```

## Version Pinning for Reproducibility

GeoAIWorkbench pins agent versions via installation scripts:

```bash
# scripts/install_agents.sh
npm install -g @anthropic-ai/claude-code@1.0.24
npm install -g @openai/codex@0.153.3
npm install -g @google-gemini/gemini-cli@0.59.0
npm install -g cline@3.0.24
# OpenCode and Goose via their respective installers
```

Exact versions recorded in every JSONL trajectory event.

## Related

- **Selection rationale:** backlog `decision-6`
- **Protocol clarification:** [KB-04-protocol-stack](../04-architecture/protocol-stack.md)
- **GitHub URLs:** [KB-15-github-repositories](github-repositories.md)
