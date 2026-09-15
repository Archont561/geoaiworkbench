---
id: KB-05-tool-merge-layers
title: "MCP Tool: merge_layers"
category: mcp-tools
subcategory: tool-spec
tags: [tool, merge-layers, data-management, native-mergevectorlayers, tier-5, mcp-15-only]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-05-tool-spec-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the merge_layers MCP tool (MCP-15 only)"
  key_facts:
    - "Tier 5 (Data Management), MCP-15 only"
    - "Combines multiple layers into one"
    - "input_layers must have >= 2 entries (Pydantic min_length=2)"
    - "All inputs must have same geometry type"
  common_questions:
    - "How many layers can I merge?"
    - "Do layers need the same CRS?"
---

# MCP Tool: merge_layers

## Purpose
Combine multiple vector layers into a single layer.

## Tool Description
```
Combine multiple QGIS vector layers into a single output layer.

All input layers must have the same geometry type. Attributes from all
layers are preserved (missing fields filled with null).

A new output layer is created. Input layers are never modified.
```

## Input Schema
```json
{
  "input_layers": ["layer1", "layer2"] (required, min 2 layers),
  "output_layer": "string (required)"
}
```

## Pydantic Validators
- `input_layers`: `Field(min_length=2)` — at least 2 layers required
- `output_layer`: must not equal any input layer name

## Output Schema
```json
{
  "output_layer": "all_roads",
  "feature_count": 5432,
  "crs": "EPSG:32633",
  "geometry_type": "LineString",
  "source_layer_count": 3
}
```

## Behavioral Contract
- Creates new layer. Inputs never modified.
- All inputs must have same geometry type (error if mixed).
- CRS handling: first layer's CRS used; others reprojected if needed.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:mergevectorlayers", {"LAYERS": layers, "OUTPUT": output})`

## Tier
**MCP-15 only** (Tier 5). Not available in MCP-5.
