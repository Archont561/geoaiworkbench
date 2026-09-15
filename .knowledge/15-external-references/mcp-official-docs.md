---
id: KB-15-mcp-official-docs
title: "MCP Official Documentation Links"
category: external-references
subcategory: protocol-docs
tags: [mcp, official-docs, anthropic, protocol, urls]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [4, 7]
related:
  - KB-15-fastmcp-docs
  - KB-08-mcp-sdk-v2-migration
  - KB-00-glossary-terms
authoritative: false
implementation_status: specified
llm_hints:
  primary_purpose: "Curated list of MCP official documentation URLs"
  key_facts:
    - "MCP spec revised 2026-07-28"
    - "SDK v2.2.0 current stable"
    - "modelcontextprotocol.io is authoritative"
    - "blog.modelcontextprotocol.io for tool annotations and server instructions"
  common_questions:
    - "Where is the MCP specification?"
    - "Where is the Python SDK?"
    - "Where are the security guidelines?"
---

# MCP Official Documentation

Curated links to authoritative MCP documentation. All URLs verified September 2026.

## Primary Documentation

### Specification
- **Main:** https://modelcontextprotocol.io
- **Latest revision:** 2026-07-28
- **Concepts:** https://modelcontextprotocol.io/docs/concepts/
- **Architecture:** https://modelcontextprotocol.io/docs/concepts/architecture

### Python SDK
- **PyPI:** https://pypi.org/project/mcp/
- **GitHub:** https://github.com/modelcontextprotocol/python-sdk
- **Current version:** 2.2.0 (September 7, 2026)
- **License:** MIT

⚠️ **Breaking change:** SDK v2 (July 2026) is not backward compatible with v1. See [KB-08-mcp-sdk-v2-migration](../08-technology-decisions/mcp-sdk-v2-migration.md).

For GeoAIWorkbench: use standalone `fastmcp` v4.0.3 instead. See [KB-15-fastmcp-docs](fastmcp-docs.md).

## Concepts

### Tools
- **Docs:** https://modelcontextprotocol.io/docs/concepts/tools
- **Key facts:**
  - LLM receives tool `name`, `description`, and `inputSchema` directly
  - Tools have optional `annotations` field for behavioral hints
  - Tool results can be text, image, or structured content

### Resources
- **Docs:** https://modelcontextprotocol.io/docs/concepts/resources
- **Note:** Not used in GeoMCP (all data access via tools for consistency)

### Prompts
- **Docs:** https://modelcontextprotocol.io/docs/concepts/prompts
- **Note:** Not used in GeoMCP (server instructions used instead)

### Sampling
- **Docs:** https://modelcontextprotocol.io/docs/concepts/sampling
- **Note:** Deprecated in 2026-07-28 spec revision

## Security

### Security Guidelines
- **Docs:** https://modelcontextprotocol.io/docs/concepts/security
- **Applied in:** [KB-10-security-overview](../10-security/security-overview.md)

### Authentication
- **OAuth 2.1:** Optional for HTTP transports, not needed for local stdio
- **Passthrough auth:** Not recommended (security anti-pattern)

## Blog Posts (Design Rationale)

### Tool Annotations
- **URL:** https://blog.modelcontextprotocol.io/posts/2026-03-16-tool-annotations/
- **Date:** March 16, 2026
- **Key content:** Behavioral hints as "risk vocabulary": readOnlyHint, destructiveHint, idempotentHint, openWorldHint
- **Warning:** Annotations are hints, not security guarantees
- **Applied in:** [KB-05-mcp-annotations](../05-mcp-tools/mcp-annotations.md)

### Server Instructions
- **URL:** https://blog.modelcontextprotocol.io/posts/2025-11-03-using-server-instructions/
- **Date:** November 3, 2025
- **Key content:** Cross-tool workflow guidance without repeating in every tool description
- **Best practice:** Keep tool descriptions short; put workflow rules in server instructions
- **Applied in:** [KB-05-server-instructions](../05-mcp-tools/server-instructions.md)

## Transports

### stdio
- **Best for:** Local agent-tool integration
- **Used by:** All 4 CLI agents (OpenCode, Claude Code, Codex, Goose)
- **GeoAIWorkbench uses this**

### Streamable HTTP
- **Best for:** Remote deployment, multi-client
- **Introduced:** 2026-07-28 spec (replaces SSE)
- **Not used by GeoAIWorkbench** (local-only)

### SSE (deprecated)
- Still supported but not recommended for new servers

## MCP Ecosystem Registries

Not part of official docs but relevant:

- **Smithery:** https://smithery.ai
- **Glama:** https://glama.ai/mcp/servers
- **Composio:** https://composio.dev
- **mcp.run:** https://mcp.run

⚠️ **Warning:** Community MCP servers have uneven safety/reliability. See Fan et al. (2025) MCPToolBench++.

## Reference Implementations

Official reference servers on GitHub:

- **File system:** https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem
- **PostgreSQL:** https://github.com/modelcontextprotocol/servers/tree/main/src/postgres
- **Git:** https://github.com/modelcontextprotocol/servers/tree/main/src/git
- **All:** https://github.com/modelcontextprotocol/servers

Used as design patterns for GeoMCP tool structure.

## Debugging Tools

### MCP Inspector
- **GitHub:** https://github.com/modelcontextprotocol/inspector
- **Usage:** `npx @modelcontextprotocol/inspector <server-command>`
- **Used in:** [KB-06-geo-mcp-server](../06-implementation/geo-mcp-server.md) development

## Community

- **Discord:** https://discord.gg/modelcontextprotocol
- **GitHub Discussions:** https://github.com/modelcontextprotocol/specification/discussions

## Related Papers Analyzing MCP

- Hou et al. (2025) — ACM TOSEM security threats paper
- Wang et al. (2025) — MCP-Bench
- Yin et al. (2025) — LiveMCP-101
- Fan et al. (2025) — MCPToolBench++
- Fan et al. (2026) — AAMAS information fidelity
- Ehtesham et al. (2025) — Protocol survey (MCP vs ACP vs A2A vs ANP)
- Song et al. (2025) — "Help or Hurdle" critical analysis (SUPPORTS PB7)
- Mo et al. (2025) — LiveMCPBench tool count degradation (SUPPORTS PB7)
- Nargund et al. (2025) — MCP lightweight framework
- Mastouri et al. (2025) — AutoMCP OpenAPI compiler
- Maloyan & Namiot (2026) — Breaking the Protocol
- Zhang et al. (2025) — MCP Security Bench

All summarized in [KB-01-round1-additions](../01-literature/round1-additions.md) and [KB-01-round2-additions](../01-literature/round2-additions.md).
