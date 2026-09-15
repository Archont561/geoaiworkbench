---
id: KB-05-tool-buffer
title: "MCP Tool: buffer"
category: mcp-tools
subcategory: tool-spec
tags: [tool, buffer, geoprocessing, native-buffer, tier-2]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8]
related:
  - KB-05-tool-spec-overview
  - KB-06-models-pydantic
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the buffer MCP tool"
  key_facts:
    - "Tier 2 (Core Geoprocessing)"
    - "Creates new layer, never modifies input"
    - "distance must be > 0 (Pydantic gt=0)"
    - "segments >= 1, default 5"
    - "output_layer must differ from input_layer"
  common_questions:
    - "What units is distance in?"
    - "Can I dissolve buffers?"
    - "Does it modify the input?"
---

# MCP Tool: buffer

## Purpose
Create a buffer around every feature in a QGIS vector layer.

## Tool Description
```
Create a buffer around every feature in a QGIS vector layer.

Use this tool when the task requires a geometric buffer around points,
lines, or polygons.

The distance is interpreted in the units of the layer CRS unless the
tool explicitly reports another unit.

The input layer is never modified. The operation creates a new output layer.

Use layer_info first if the input CRS, geometry type, or layer identity
is unknown.
```

## Input Schema
```json
{
  "input_layer": "string (required)",
  "distance": "number > 0 (required)",
  "segments": "integer >= 1 (default: 5)",
  "dissolve": "boolean (default: false)",
  "output_layer": "string (required, must differ from input_layer)"
}
```

## Pydantic Validators
- `distance`: `Field(gt=0)` — must be positive
- `segments`: `Field(ge=1)` — at least 1 segment
- `output_layer`: `@field_validator` — must not equal `input_layer`

## Output Schema
```json
{
  "output_layer": "roads_buffer",
  "input_layer": "roads",
  "feature_count": 1250,
  "crs": "EPSG:32633",
  "geometry_type": "Polygon",
  "distance": 500.0,
  "dissolved": false
}
```

## Behavioral Contract
- Creates new layer. Never modifies input.
- Must report output layer name, CRS, feature count.
- Negative distance is invalid (Pydantic rejects).
- If output_layer already exists, fail rather than overwrite.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:buffer", {"INPUT": layer, "DISTANCE": distance, "SEGMENTS": segments, "DISSOLVE": dissolve, "OUTPUT": output})`
