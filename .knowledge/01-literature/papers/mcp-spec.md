---
id: KB-01-mcp-spec
title: "Model Context Protocol Specification (Anthropic)"
category: literature
subcategory: protocol-spec
tags: [mcp, protocol, specification, anthropic, standard]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 4, 7]
related:
  - KB-01-original-13-references
  - KB-15-mcp-official-docs
  - KB-01-acp-spec
authoritative: false
implementation_status: specified
references:
  - anthropicMCP
llm_hints:
  primary_purpose: "Official MCP protocol specification from Anthropic"
  key_facts:
    - "JSON-RPC 2.0 based"
    - "Standardizes tool discovery and invocation"
    - "Latest spec revision: 2026-07-28"
    - "Supports stdio, Streamable HTTP, SSE transports"
    - "Distinct from ACP and A2A"
  common_questions:
    - "What is MCP?"
    - "What version is current?"
    - "What transports does it support?"
---

# Model Context Protocol Specification (Anthropic)

## Full Citation

Anthropic. (2024-2026). Model Context Protocol Specification. https://modelcontextprotocol.io

## What This Specification Defines

Open JSON-RPC 2.0 based standard for connecting LLM agents to external tools, resources, and context.

### Scope

- **Agent ↔ Tools** (vertical, agent uses tools)
- Standardized tool discovery
- Standardized tool invocation
- Structured input/output schemas
- Cross-vendor compatibility

### Distinguished From

- **ACP** — Editor ↔ Agent (not tools)
- **A2A** — Agent ↔ Agent (peer-to-peer)

### Latest Revision

- **2026-07-28** — Current specification
- Introduces Streamable HTTP transport
- Deprecates sampling and roots
- Removes ping and change notifications

## Key Components

### Tools
```json
{
  "name": "buffer",
  "description": "Create a buffer around vector features",
  "inputSchema": {
    "type": "object",
    "properties": {
      "input_layer": {"type": "string"},
      "distance": {"type": "number"}
    }
  }
}
```

### Resources (not used in GeoMCP)
- URI-based data access
- GeoMCP uses tools instead for consistency

### Prompts (not used in GeoMCP)
- Predefined prompt templates
- GeoMCP uses server instructions instead

### Server Instructions (2025-11-03)
- Cross-tool workflow guidance
- Not repeated in every tool description

### Tool Annotations (2026-03-16)
- `readOnlyHint`
- `destructiveHint`
- `idempotentHint`
- `openWorldHint`
- **NOT security guarantees, only hints**

## Transports

### stdio
- **Best for:** Local agent-tool integration
- **Used by:** All 4 CLI agents (OpenCode, Claude Code, Codex, Goose)
- **GeoAIWorkbench uses this**

### Streamable HTTP
- **Best for:** Remote deployment
- **Introduced:** 2026-07-28

### SSE (deprecated)
- Still supported but not recommended

## Why This Matters

- **Enables the MCP condition in GeoAIWorkbench**
- **Standardizes tool integration** across LLM vendors
- **Ecosystem growth** — 4,000+ MCP servers by mid-2025 (Fan et al. 2025)

## Relevance to GeoAIWorkbench

**Foundational for MCP paradigm.**

### Direct Application

- **All 5 (or 15) GeoMCP tools** follow MCP spec
- **Uses stdio transport** for local agent integration
- **Adopts annotations** (readOnlyHint, destructiveHint)
- **Uses server instructions** for cross-tool guidance

### Key Design Decisions Based on Spec

1. **JSON-RPC 2.0** — determines request/response format
2. **Tool discovery** — agent queries available tools
3. **Schema validation** — Pydantic v2 models per tool
4. **Error handling** — structured error responses

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.1 | **Primary protocol reference** |
| Chapter III | Section 3.2 | Protocol stack (MCP vs ACP vs A2A) |
| Chapter III | Section 3.3 | Tools, resources, prompts |
| Chapter V | Section 5.2 | Tool specification implementation |

## Related References

- FastMCP docs — implementation framework
- Nargund et al. (2025) — Lightweight framework analysis
- Wang et al. (2025) — MCP-Bench uses spec
- Ehtesham et al. (2025) — Protocol comparison

## SDK Versions

- **`mcp` package v2.2.0** (September 2026) — official Python SDK
- **`fastmcp` v4.0.3** (September 2026) — standalone framework (used by GeoAIWorkbench)

## BibTeX Key

`anthropicMCP`

## URL

https://modelcontextprotocol.io
