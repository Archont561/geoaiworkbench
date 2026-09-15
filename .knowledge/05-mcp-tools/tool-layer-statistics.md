---
id: KB-05-tool-layer-statistics
title: "MCP Tool: layer_statistics"
category: mcp-tools
subcategory: tool-spec
tags: [tool, layer-statistics, inspection, read-only, tier-1]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8]
related:
  - KB-05-tool-spec-overview
  - KB-05-tool-layer-info
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the layer_statistics MCP tool"
  key_facts:
    - "Tier 1 (Inspection), read-only"
    - "Returns count, min, max, mean, sum, stddev"
    - "Field must exist and be numeric"
    - "Uses qgis:basicstatisticsforfields"
  common_questions:
    - "What statistics are returned?"
    - "What if the field is not numeric?"
---

# MCP Tool: layer_statistics

## Purpose
Calculate descriptive statistics for a numeric attribute field.

## Tool Description
```
Calculate descriptive statistics for a numeric attribute field in a QGIS
vector layer.

Use this tool when you need to understand the values in a field before or
after a GIS operation.

Returns count, minimum, maximum, mean, sum, and standard deviation.

This tool does not modify the layer.

The field must exist and contain numeric values.
```

## Input Schema
```json
{
  "type": "object",
  "properties": {
    "layer": {"type": "string", "description": "QGIS layer name or ID."},
    "field": {"type": "string", "description": "Numeric attribute field name."}
  },
  "required": ["layer", "field"]
}
```

## Output Schema
```json
{
  "layer": "string", "field": "string",
  "count": 1250, "minimum": 1.0, "maximum": 9842.0,
  "mean": 527.42, "sum": 659275.0, "standard_deviation": 812.31
}
```

## Behavioral Contract
- Read-only. Does not modify or create layers.
- If field does not exist, return available field names.
- If field is not numeric, return explicit type error.

## Annotations
`readOnlyHint=true, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("qgis:basicstatisticsforfields", {...})`

## Pydantic Models
`LayerStatisticsInput(layer, field)` → `LayerStatisticsOutput(layer, field, count, minimum, maximum, mean, sum, standard_deviation)`
