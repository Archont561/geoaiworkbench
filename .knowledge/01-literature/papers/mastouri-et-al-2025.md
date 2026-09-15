---
id: KB-01-mastouri-et-al-2025
title: "Mastouri et al. (2025) — AutoMCP OpenAPI Compiler"
category: literature
subcategory: paper-summary
tags: [automcp, openapi, mcp-generation, schema-driven, mastouri]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
  - KB-01-nargund-et-al-2025
authoritative: false
implementation_status: specified
references:
  - mastouri2025automcp
llm_hints:
  primary_purpose: "Compiles OpenAPI specs into MCP servers automatically"
  key_facts:
    - "76.5% out-of-box success from OpenAPI"
    - "99.9% after minor spec fixes"
    - "Validates schema-driven approach"
    - "MCP server development largely manual otherwise"
  common_questions:
    - "What is AutoMCP?"
    - "Can I auto-generate my MCP server?"
    - "What percentage of OpenAPI specs work?"
---

# Mastouri et al. (2025) — AutoMCP

## Full Citation

Mastouri, M., Ksontini, E., & Kessentini, W. (2025). Making REST APIs Agent-Ready: From OpenAPI to Model Context Protocol Servers for Tool-Augmented LLMs. *ArXiv, abs/2507.16044*.

## What This Paper Says

Presents AutoMCP, a tool that compiles OpenAPI specifications into MCP servers automatically. Demonstrates that schema-driven MCP generation is feasible.

### AutoMCP Approach

- Input: OpenAPI 3.0 specification
- Processing: Convert endpoints to MCP tools
- Output: Ready-to-run MCP server
- Preserves: Parameter schemas, descriptions, response types

### Key Results

- **76.5% success rate out-of-box** (unmodified OpenAPI)
- **99.9% success after minor spec fixes** (e.g., better descriptions)

### Design Insights

- Schema quality dominates over automation quality
- Description clarity critical for LLM understanding
- Parameter constraints must be explicit
- Error handling should be standardized

## Key Findings

- **Schema-driven MCP generation is highly feasible**
- **Manual MCP development still dominant** despite tools like AutoMCP
- **Schema quality matters more than tool count**
- OpenAPI → MCP path is viable for API-heavy domains

## Why This Paper Matters

- **Validates schema-driven approach** used by GeoMCP (Pydantic → MCP schemas)
- **Suggests future automation** for GIS tool generation
- **Confirms importance of tool descriptions** — informs GeoMCP design

## Relevance to GeoAIWorkbench

**Moderate relevance — validates design principles.**

### Design Validation

GeoMCP uses Pydantic v2 models that could be seen as schema-driven:

```python
class BufferInput(BaseModel):
    input_layer: str = Field(description="Exact QGIS layer name")
    distance: Annotated[float, Field(gt=0)] = Field(
        description="Buffer distance in CRS units"
    )
```

AutoMCP evidence supports:
- Pydantic → MCP schema pattern
- Explicit constraints (`gt=0`)
- Clear descriptions
- Structured output types

### Future Work

Could theoretically apply AutoMCP-like tool to auto-generate MCP tools from QGIS Processing algorithm metadata. Not in current scope.

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.3 | MCP server development approaches |
| Chapter V | Section 5.2 | Schema-driven design validation |
| Chapter VII | Section 7.4 | Future work (auto-generate from QGIS) |

## Related Papers

- Nargund et al. (2025) — MCP lightweight modular framework
- MCP Spec — Schema requirements

## Key Quote

*"AutoMCP achieves 76.5% out-of-box success and 99.9% after minor spec fixes when compiling OpenAPI specs into MCP servers, demonstrating the feasibility of schema-driven MCP generation."* — Mastouri et al. (2025)

## BibTeX Key

`mastouri2025automcp`
