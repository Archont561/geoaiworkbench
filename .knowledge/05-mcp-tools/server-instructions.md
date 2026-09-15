---
id: KB-05-server-instructions
title: "MCP Server Instructions"
category: mcp-tools
subcategory: instructions
tags: [mcp, server-instructions, workflow, guidance, cross-tool]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8]
related:
  - KB-05-tool-spec-overview
  - KB-15-mcp-official-docs
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Cross-tool workflow guidance provided to agents via MCP server instructions"
  key_facts:
    - "Server instructions separate from tool descriptions"
    - "MCP-5 and MCP-15 have different instruction variants"
    - "Keeps tool descriptions short"
    - "Based on MCP blog post 2025-11-03"
  common_questions:
    - "What are server instructions?"
    - "How do they differ from tool descriptions?"
    - "What do they tell the agent?"
---

# MCP Server Instructions

## Purpose

Server instructions provide **cross-tool workflow guidance** to the LLM agent. They are distinct from per-tool descriptions:

- **Tool description:** What THIS tool does (short, specific)
- **Server instructions:** How to combine tools effectively (global, strategic)

Based on MCP best practice: https://blog.modelcontextprotocol.io/posts/2025-11-03-using-server-instructions/

## MCP-5 Server Instructions

```
GeoAIWorkbench provides five constrained GIS tools for operating on layers
in the connected QGIS project.

TOOLS AVAILABLE:
- layer_info: Inspect layer metadata (CRS, geometry, fields)
- layer_statistics: Calculate numeric field statistics
- buffer: Create buffer zones around features
- clip: Clip features using an overlay layer
- reproject: Transform layer to a different CRS

WORKFLOW GUIDANCE:
1. Use the smallest number of tools necessary.
2. Always call layer_info first when a layer's CRS, geometry type,
   or fields are unknown.
3. Tools that create outputs produce NEW layers. Input layers are
   never modified. Use the returned output_layer name in subsequent steps.
4. Buffer distance is in the units of the input layer's CRS.
5. Target CRS must be an EPSG code (e.g., EPSG:4326).
6. If a tool reports an error, use the error information to correct
   your arguments rather than guessing.

RESTRICTIONS:
- Do not attempt to execute arbitrary Python or shell commands.
- Do not attempt to call tools not listed above.
- Do not attempt to modify input layers directly.
```

## MCP-15 Server Instructions

```
GeoAIWorkbench provides fifteen constrained GIS tools for operating on
layers in the connected QGIS project.

TOOLS AVAILABLE:
Inspection: layer_info, layer_statistics
Core Geoprocessing: buffer, clip, reproject
Extended Geoprocessing: dissolve, intersection, difference, union,
  spatial_join, select_by_location
Geometry Operations: centroid, simplify
Data Management: merge_layers, calculate_field

WORKFLOW GUIDANCE:
1. Use the smallest number of tools necessary.
2. Always call layer_info first when a layer's CRS, geometry type,
   or fields are unknown.
3. Tools that create outputs produce NEW layers. Input layers are
   never modified. Use the returned output_layer name in subsequent steps.
4. For overlay operations (intersection, difference, union, clip),
   ensure both layers share the same CRS. Use reproject first if needed.
5. spatial_join supports predicates: intersects, contains, within,
   touches, crosses, overlaps.
6. calculate_field uses QGIS expression syntax (e.g., $area,
   length($geometry)). Expressions are validated for safety.
7. merge_layers requires at least 2 input layers of the same geometry type.
8. If a tool reports an error, use the error information to correct
   your arguments rather than guessing.

RESTRICTIONS:
- Do not attempt to execute arbitrary Python or shell commands.
- Do not attempt to call tools not listed above.
- Do not attempt to modify input layers directly.
```

## Implementation

```python
# geoaiworkbench/geo_mcp.py
import os

TIER = os.environ.get("GEOMCP_TIER", "5")

if TIER == "5":
    SERVER_INSTRUCTIONS = MCP5_INSTRUCTIONS  # Short version
else:
    SERVER_INSTRUCTIONS = MCP15_INSTRUCTIONS  # Full version

mcp = FastMCP("GeoAIWorkbench", instructions=SERVER_INSTRUCTIONS)
```

## Token Budget

| Variant | Approximate Tokens | % of 128K Context |
|---|---|---|
| MCP-5 instructions | ~150 | 0.12% |
| MCP-15 instructions | ~250 | 0.20% |
| MCP-5 tool schemas | ~400 | 0.31% |
| MCP-15 tool schemas | ~1200 | 0.94% |
| **MCP-5 total** | **~550** | **0.43%** |
| **MCP-15 total** | **~1450** | **1.13%** |

Context overhead is minimal for both tiers.

## Related Files

- [KB-05-tool-spec-overview](tool-spec-overview.md) — Tool list
- [KB-05-tool-selection-decision-tree](tool-selection-decision-tree.md) — Decision flow
- [KB-15-mcp-official-docs](../15-external-references/mcp-official-docs.md) — MCP blog posts
