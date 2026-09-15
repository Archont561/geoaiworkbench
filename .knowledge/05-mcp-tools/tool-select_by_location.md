---
id: KB-05-tool-select_by_location
title: "MCP Tool: select_by_location"
category: mcp-tools
subcategory: tool-spec
tags: [tool, select_by_location, geoprocessing, native-selectbylocation, tier-3, mcp-15-only]
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
  primary_purpose: "Full specification for the select_by_location MCP tool (MCP-15 only)"
  key_facts:
    - "Tier 3 (Extended Geoprocessing), MCP-15 only"
    - "QGIS algorithm: native:selectbylocation"
    - "Creates new layer, inputs never modified"
  common_questions:
    - "What does select_by_location do?"
    - "Is this available in MCP-5?"
---

# MCP Tool: select_by_location

## Purpose
Select features based on spatial relationship to a reference layer.

## Tool Description
```
Select features from an input layer based on their spatial relationship to features in a reference layer. Returns a new layer with only selected features.

The input layer(s) are never modified. A new output layer is created.

Use layer_info first if CRS or geometry type is unknown.
```

## Input Parameters
- input_layer: string (required)
- reference_layer: string (required)
- predicate: Literal[intersects,contains,within,touches,crosses,overlaps] (default: intersects)
- output_layer: string (required, must differ from input layers)

## Output Fields
output_layer: string (required)|output_layer, selected_count, total_count, crs

## Behavioral Contract
- Creates new layer. Inputs never modified.
- output_layer must not equal any input layer name.
- CRS incompatibility reported as error.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:selectbylocation", {...})`

## Tier
**MCP-15 only** (Tier 3). Not available in MCP-5.
