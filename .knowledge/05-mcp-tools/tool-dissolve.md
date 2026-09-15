---
id: KB-05-tool-dissolve
title: "MCP Tool: dissolve"
category: mcp-tools
subcategory: tool-spec
tags: [tool, dissolve, geoprocessing, native-dissolve, tier-3, mcp-15-only]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-05-tool-spec-overview
  - KB-05-three-condition-experiment
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the dissolve MCP tool (MCP-15 only)"
  key_facts:
    - "Tier 3 (Extended Geoprocessing), MCP-15 only"
    - "QGIS algorithm: native:dissolve"
    - "Creates new layer, inputs never modified"
  common_questions:
    - "What does dissolve do?"
    - "Is this available in MCP-5?"
---

# MCP Tool: dissolve

## Purpose
Merge features that share a common attribute value.

## Tool Description
```
Merge features in a QGIS vector layer by a shared attribute field. If no field is specified, all features are merged into one.

The input layer(s) are never modified. A new output layer is created.

Use layer_info first if CRS or geometry type is unknown.
```

## Input Parameters
- input_layer: string (required)
- dissolve_field: string 
-  null (optional, attribute to group by)
- output_layer: string (required, must differ from input layers)

## Output Fields
output_layer: string (required)|output_layer, input_layer, feature_count, crs, geometry_type, dissolve_field

## Behavioral Contract
- Creates new layer. Inputs never modified.
- output_layer must not equal any input layer name.
- CRS incompatibility reported as error.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:dissolve", {...})`

## Tier
**MCP-15 only** (Tier 3). Not available in MCP-5.
