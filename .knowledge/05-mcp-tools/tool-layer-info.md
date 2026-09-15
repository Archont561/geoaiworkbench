---
id: KB-05-tool-layer-info
title: "MCP Tool: layer_info"
category: mcp-tools
subcategory: tool-spec
tags: [tool, layer-info, inspection, read-only, tier-1]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8]
related:
  - KB-05-tool-spec-overview
  - KB-05-mcp-annotations
  - KB-06-models-pydantic
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the layer_info MCP tool"
  key_facts:
    - "Tier 1 (Inspection), read-only"
    - "Returns metadata: type, geometry, CRS, features, extent, fields"
    - "No layer modification"
    - "Should be called first when layer is unknown"
  common_questions:
    - "What does layer_info return?"
    - "Does it modify the layer?"
---

# MCP Tool: layer_info

## Purpose
Inspect a QGIS vector or raster layer before performing an operation.

## Tool Description
```
Inspect a QGIS layer and return its metadata.

Use this tool when you need to understand an existing layer before choosing
or executing another GIS operation.

Returns the layer name, type, geometry type when applicable, CRS, feature
count when available, extent, fields, and source information.

This tool does not modify the QGIS project or layer.

Do not use this tool to calculate arbitrary statistics; use layer_statistics
for attribute statistics.
```

## Input Schema
```json
{
  "type": "object",
  "properties": {
    "layer": {
      "type": "string",
      "description": "QGIS layer identifier or exact layer name."
    }
  },
  "required": ["layer"]
}
```

## Output Schema
```json
{
  "layer_id": "string",
  "layer_name": "string",
  "layer_type": "vector | raster",
  "geometry_type": "Point | LineString | Polygon | Multi* | null",
  "crs": "EPSG:32633",
  "feature_count": 1250,
  "extent": {"xmin": 0.0, "ymin": 0.0, "xmax": 1.0, "ymax": 1.0},
  "fields": [{"name": "population", "type": "integer"}],
  "source": "/path/to/layer.shp"
}
```

## Behavioral Contract
- Read-only. Must not modify the layer.
- Must not create a new layer.
- If layer does not exist, return actionable error with available layers.

## Annotations
`readOnlyHint=true, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
Uses `QgsVectorLayer` / `QgsRasterLayer` directly. No Processing algorithm.

## Pydantic Models
`LayerInfoInput(layer: str)` → `LayerInfoOutput(layer_id, layer_name, layer_type, geometry_type, crs, feature_count, extent, fields, source)`
