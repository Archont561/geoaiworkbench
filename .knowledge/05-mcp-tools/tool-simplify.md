---
id: KB-05-tool-simplify
title: "MCP Tool: simplify"
category: mcp-tools
subcategory: tool-spec
tags: [tool, simplify, geometry, native-simplifygeometries, tier-4, mcp-15-only]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-05-tool-spec-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the simplify MCP tool (MCP-15 only)"
  key_facts:
    - "Tier 4 (Geometry Operations), MCP-15 only"
    - "Reduces geometry vertex count"
    - "tolerance must be > 0 (Pydantic gt=0)"
    - "Uses native:simplifygeometries"
  common_questions:
    - "What units is tolerance in?"
    - "Does it change feature count?"
---

# MCP Tool: simplify

## Purpose
Reduce geometry complexity by removing vertices.

## Tool Description
```
Reduce geometry complexity by removing vertices from features in a
QGIS vector layer.

Use this tool when the task requires generalizing geometries for
visualization or performance. The tolerance is in layer CRS units.

The input layer is never modified. A new output layer is created.
Feature count is preserved.
```

## Input Schema
```json
{
  "input_layer": "string (required)",
  "tolerance": "number > 0 (required, in layer CRS units)",
  "output_layer": "string (required)"
}
```

## Pydantic Validators
- `tolerance`: `Field(gt=0)` — must be positive

## Output Schema
```json
{
  "output_layer": "roads_simplified",
  "feature_count": 1250,
  "crs": "EPSG:32633",
  "vertex_reduction_pct": 45.2
}
```

## Behavioral Contract
- Creates new layer. Input never modified.
- Feature count preserved (vertices reduced, not features).
- Tolerance in layer CRS units.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:simplifygeometries", {"INPUT": layer, "TOLERANCE": tolerance, "OUTPUT": output})`

## Tier
**MCP-15 only** (Tier 4). Not available in MCP-5.
