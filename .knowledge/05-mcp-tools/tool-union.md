---
id: KB-05-tool-union
title: "MCP Tool: union"
category: mcp-tools
subcategory: tool-spec
tags: [tool, union, geoprocessing, native-union, tier-3, mcp-15-only]
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
  primary_purpose: "Full specification for the union MCP tool (MCP-15 only)"
  key_facts:
    - "Tier 3 (Extended Geoprocessing), MCP-15 only"
    - "QGIS algorithm: native:union"
    - "Creates new layer, inputs never modified"
  common_questions:
    - "What does union do?"
    - "Is this available in MCP-5?"
---

# MCP Tool: union

## Purpose
Combine all features from two layers, splitting at overlaps.

## Tool Description
```
Combine all features from two layers while preserving all boundaries and attributes from both. Overlapping areas are split into separate features.

The input layer(s) are never modified. A new output layer is created.

Use layer_info first if CRS or geometry type is unknown.
```

## Input Parameters
- input_layer: string (required)
- overlay_layer: string (required)
- output_layer: string (required)
- output_layer: string (required, must differ from input layers)

## Output Fields
output_layer, feature_count, crs

## Behavioral Contract
- Creates new layer. Inputs never modified.
- output_layer must not equal any input layer name.
- CRS incompatibility reported as error.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:union", {...})`

## Tier
**MCP-15 only** (Tier 3). Not available in MCP-5.
