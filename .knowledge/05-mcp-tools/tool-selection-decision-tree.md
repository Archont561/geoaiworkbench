---
id: KB-05-tool-selection-decision-tree
title: "Tool Selection Decision Tree"
category: mcp-tools
subcategory: guidance
tags: [tool-selection, decision-tree, workflow, guidance]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8]
related:
  - KB-05-tool-spec-overview
  - KB-05-server-instructions
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision tree for agents to select the correct GeoMCP tool"
  key_facts:
    - "Hierarchical decision flow"
    - "Starts with layer_info when unknown"
    - "Covers all 15 tools"
    - "Included in server instructions for MCP-15"
  common_questions:
    - "Which tool should the agent use?"
    - "How does the agent decide?"
---

# Tool Selection Decision Tree

## Primary Decision Flow

```
Need to understand a layer?
    └──> layer_info

Need numeric field statistics?
    └──> layer_statistics

Need a geometric buffer?
    └──> buffer

Need to keep geometry inside another layer?
    └──> clip

Need to change coordinate system?
    └──> reproject

Need to merge features by attribute?
    └──> dissolve

Need geometric overlap between two layers?
    └──> intersection

Need to subtract one layer from another?
    └──> difference

Need to combine all features from two layers?
    └──> union

Need to transfer attributes by spatial relationship?
    └──> spatial_join

Need to select features by location?
    └──> select_by_location

Need feature center points?
    └──> centroid

Need to reduce geometry complexity?
    └──> simplify

Need to combine multiple layers into one?
    └──> merge_layers

Need to compute new attribute values?
    └──> calculate_field
```

## General Workflow Pattern

```
1. layer_info (inspect inputs)
       ↓
2. reproject (if CRS mismatch)
       ↓
3. Core operation (buffer/clip/intersection/etc.)
       ↓
4. layer_info (verify output)
       ↓
5. layer_statistics (if needed)
```

## Common Task Patterns

### Buffer + Clip
```
layer_info("roads") → buffer("roads", 500) → clip("roads_buffer", "study_area")
```

### Overlay Analysis
```
layer_info("land_use") → layer_info("protected") →
    intersection("land_use", "protected") → layer_statistics(result, "area")
```

### Spatial Join + Statistics
```
layer_info("cities") → layer_info("districts") →
    spatial_join("cities", "districts", "within") →
    layer_statistics(result, "population")
```

## Related Files

- [KB-05-server-instructions](server-instructions.md) — Cross-tool guidance
- [KB-05-tool-spec-overview](tool-spec-overview.md) — Tool list
