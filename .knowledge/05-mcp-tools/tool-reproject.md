---
id: KB-05-tool-reproject
title: "MCP Tool: reproject"
category: mcp-tools
subcategory: tool-spec
tags: [tool, reproject, geoprocessing, crs, tier-2]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8]
related:
  - KB-05-tool-spec-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the reproject MCP tool"
  key_facts:
    - "Tier 2 (Core Geoprocessing)"
    - "target_crs must match EPSG regex"
    - "Creates new layer, never modifies input"
    - "Uses native:reprojectlayer"
  common_questions:
    - "What CRS format is required?"
    - "Does it modify the input?"
---

# MCP Tool: reproject

## Purpose
Create a new QGIS vector layer reprojected into a target CRS.

## Tool Description
```
Create a new QGIS vector layer whose geometries are transformed from the
input layer CRS into the requested target CRS.

Use this tool when the task explicitly requires changing the coordinate
reference system.

The input layer is never modified.

The target CRS must be specified using an EPSG code (e.g., EPSG:4326).

Use layer_info first if the input CRS is unknown.
```

## Input Schema
```json
{
  "input_layer": "string (required)",
  "target_crs": "string (required, EPSG format e.g. EPSG:4326)",
  "output_layer": "string (required, must differ from input)"
}
```

## Pydantic Validators
- `target_crs`: `@field_validator` with regex `^EPSG:\d+$` (case-insensitive, uppercased)
- `output_layer`: must not equal `input_layer`

## Output Schema
```json
{
  "output_layer": "roads_wgs84",
  "input_layer": "roads",
  "source_crs": "EPSG:32633",
  "target_crs": "EPSG:4326",
  "feature_count": 1250,
  "geometry_type": "LineString"
}
```

## Behavioral Contract
- Creates new layer. Input never modified.
- Must validate CRS before execution.
- Must report source and target CRS.
- Must not silently change requested CRS.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:reprojectlayer", {"INPUT": layer, "TARGET_CRS": crs, "OUTPUT": output})`
