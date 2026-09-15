---
id: KB-05-tool-centroid
title: "MCP Tool: centroid"
category: mcp-tools
subcategory: tool-spec
tags: [tool, centroid, geometry, native-centroids, tier-4, mcp-15-only]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-05-tool-spec-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the centroid MCP tool (MCP-15 only)"
  key_facts:
    - "Tier 4 (Geometry Operations), MCP-15 only"
    - "Computes geometric center of each feature"
    - "Returns point layer"
    - "Uses native:centroids"
  common_questions:
    - "What does centroid return?"
    - "Does it work on all geometry types?"
---

# MCP Tool: centroid

## Purpose
Compute the centroid (geometric center) of each feature.

## Tool Description
```
Compute the centroid (geometric center) of each feature in a QGIS
vector layer.

Returns a new point layer with one centroid per input feature.
All attributes from the input layer are preserved.

The input layer is never modified.
```

## Input Schema
```json
{
  "input_layer": "string (required)",
  "output_layer": "string (required, must differ from input)"
}
```

## Output Schema
```json
{
  "output_layer": "roads_centroids",
  "feature_count": 1250,
  "crs": "EPSG:32633"
}
```

## Behavioral Contract
- Creates new point layer. Input never modified.
- One centroid per input feature (count preserved).
- Works on all geometry types (point, line, polygon).

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:centroids", {"INPUT": layer, "OUTPUT": output})`

## Tier
**MCP-15 only** (Tier 4). Not available in MCP-5.
