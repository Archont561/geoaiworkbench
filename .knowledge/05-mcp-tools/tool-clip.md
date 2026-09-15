---
id: KB-05-tool-clip
title: "MCP Tool: clip"
category: mcp-tools
subcategory: tool-spec
tags: [tool, clip, geoprocessing, native-clip, tier-2]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8]
related:
  - KB-05-tool-spec-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the clip MCP tool"
  key_facts:
    - "Tier 2 (Core Geoprocessing)"
    - "Clips input by overlay geometry"
    - "Neither input modified"
    - "output_layer must differ from both inputs"
  common_questions:
    - "Which layer is clipped?"
    - "Does it handle CRS mismatch?"
---

# MCP Tool: clip

## Purpose
Clip the features of an input vector layer using the geometry of an overlay layer.

## Tool Description
```
Clip the features of an input vector layer using the geometry of an
overlay vector layer.

Use this tool when the task requires keeping only the portions of the
input features that fall inside the overlay geometry.

The input and overlay layers are not modified. A new output layer is created.

Use layer_info first if you do not know the geometry type or CRS of the
input layers.
```

## Input Schema
```json
{
  "input_layer": "string (required, layer to be clipped)",
  "overlay_layer": "string (required, clipping boundary)",
  "output_layer": "string (required, must differ from both inputs)"
}
```

## Pydantic Validators
- `output_layer`: must not equal `input_layer` or `overlay_layer`

## Output Schema
```json
{
  "output_layer": "roads_clipped",
  "input_layer": "roads",
  "overlay_layer": "study_area",
  "feature_count": 843,
  "crs": "EPSG:32633",
  "geometry_type": "LineString"
}
```

## Behavioral Contract
- Creates new layer. Neither input modified.
- CRS incompatibility must be reported as error (no silent reprojection).
- Must report resulting feature count and CRS.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:clip", {"INPUT": input, "OVERLAY": overlay, "OUTPUT": output})`
