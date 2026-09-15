---
id: KB-05-tool-spatial_join
title: "MCP Tool: spatial_join"
category: mcp-tools
subcategory: tool-spec
tags: [tool, spatial_join, geoprocessing, native-joinattributesbylocation, tier-3, mcp-15-only]
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
  primary_purpose: "Full specification for the spatial_join MCP tool (MCP-15 only)"
  key_facts:
    - "Tier 3 (Extended Geoprocessing), MCP-15 only"
    - "QGIS algorithm: native:joinattributesbylocation"
    - "Creates new layer, inputs never modified"
  common_questions:
    - "What does spatial_join do?"
    - "Is this available in MCP-5?"
---

# MCP Tool: spatial_join

## Purpose
Join attributes from one layer to another by spatial relationship.

## Tool Description
```
Join attributes from a join layer to an input layer based on spatial relationship. Supported predicates: intersects, contains, within, touches, crosses, overlaps.

The input layer(s) are never modified. A new output layer is created.

Use layer_info first if CRS or geometry type is unknown.
```

## Input Parameters
- input_layer: string (required)
- join_layer: string (required)
- predicate: Literal[intersects,contains,within,touches,crosses,overlaps] (default: intersects)
- output_layer: string (required, must differ from input layers)

## Output Fields
output_layer: string (required)|output_layer, input_layer, join_layer, feature_count, joined_fields, crs

## Behavioral Contract
- Creates new layer. Inputs never modified.
- output_layer must not equal any input layer name.
- CRS incompatibility reported as error.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:joinattributesbylocation", {...})`

## Tier
**MCP-15 only** (Tier 3). Not available in MCP-5.
