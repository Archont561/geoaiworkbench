---
id: KB-02-task-stratification
title: "Task Stratification and Tool Tier Mapping"
category: research-design
subcategory: tasks
tags: [tasks, stratification, difficulty, tiers, geoanalystbench]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [2, 3, 15]
related:
  - KB-02-final-research-design
  - KB-01-zhang-et-al-2025
  - KB-12-geoanalystbench-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "How tasks are stratified by difficulty and mapped to MCP tool tiers"
  key_facts:
    - "50 GeoAnalystBench tasks adapted from ArcPy to PyQGIS"
    - "3 difficulty tiers: basic (~15), intermediate (~20), advanced (~15)"
    - "Each task annotated with minimum_tier (2 or 3-5)"
    - "5 adversarial tasks for security"
    - "MCP-5 sufficient for basic, MCP-15 needed for advanced"
  common_questions:
    - "How are tasks stratified?"
    - "Which tasks need MCP-15?"
    - "How were ArcPy tasks adapted?"
---

# Task Stratification and Tool Tier Mapping

## Task Source

50 tasks from GeoAnalystBench (Zhang et al., 2025), adapted from ArcPy to PyQGIS.

### Adaptation Process

| ArcPy | PyQGIS |
|---|---|
| `arcpy.Buffer_analysis()` | `processing.run("native:buffer", {...})` |
| `arcpy.Clip_analysis()` | `processing.run("native:clip", {...})` |
| `arcpy.Project_management()` | `processing.run("native:reprojectlayer", {...})` |
| `arcpy.Dissolve_management()` | `processing.run("native:dissolve", {...})` |
| `arcpy.Intersect_analysis()` | `processing.run("native:intersection", {...})` |
| `arcpy.SpatialJoin_analysis()` | `processing.run("native:joinattributesbylocation", {...})` |
| `arcpy.CalculateField_management()` | `processing.run("native:fieldcalculator", {...})` |
| ArcSDE workspace | GeoPackage / Shapefile |

## Difficulty Tiers

### Basic (~15 tasks)

**Characteristics:**
- Single geoprocessing operation
- Well-defined inputs and outputs
- No spatial reasoning required
- 1-2 step workflows

**Examples:**
- Buffer a layer by fixed distance
- Reproject to WGS 84
- Calculate field statistics

**MCP-5 sufficient:** ✅ All operations in Tier 1-2

**`minimum_tier`:** 2

### Intermediate (~20 tasks)

**Characteristics:**
- 2-3 geoprocessing operations
- Simple pipeline (sequential)
- Basic spatial reasoning
- May require layer inspection first

**Examples:**
- Buffer then clip to study area
- Reproject then calculate statistics
- Buffer then dissolve overlapping zones

**MCP-5 sufficient:** ⚠️ Partially (some need dissolve)

**`minimum_tier`:** 2-3

### Advanced (~15 tasks)

**Characteristics:**
- 4+ geoprocessing operations
- Complex spatial reasoning
- Multi-layer interactions
- Conditional logic
- May require spatial joins, overlays

**Examples:**
- Find population within buffer of rivers, join to districts
- Overlay land use with protected areas, calculate statistics by category
- Multi-step watershed analysis with reprojection and intersection

**MCP-5 sufficient:** ❌ Requires Tier 3+ tools

**`minimum_tier`:** 3-5

## Tool Tier Mapping

| Task Difficulty | Required Tools | MCP-5 Has? | MCP-15 Has? |
|---|---|---|---|
| Basic | buffer, clip, reproject, layer_info, layer_statistics | ✅ All | ✅ All |
| Intermediate | + dissolve (sometimes) | ⚠️ Partial | ✅ All |
| Advanced | + intersection, difference, union, spatial_join, select_by_location, centroid, simplify, merge_layers, calculate_field | ❌ Missing | ✅ All |

## Expected Performance Pattern

```
Task Success Rate
    │
1.0 │  MCP-5  ████████████
    │  MCP-15 ████████████
    │  CodeGen ████████████
    │
0.7 │  MCP-5  ████████
    │  MCP-15 ██████████
    │  CodeGen ██████████
    │
0.4 │  MCP-5  ████
    │  MCP-15 ████████
    │  CodeGen █████████
    │
    └────────────────────────────
       Basic    Intermediate   Advanced
```

**Prediction:**
- Basic: All paradigms similar (H2a)
- Intermediate: MCP-15 ≈ CodeGen > MCP-5 (H2c)
- Advanced: CodeGen > MCP-15 > MCP-5 (H2b, H7c)

## Adversarial Tasks (Security)

5 additional tasks for PB5. Not included in main factorial.

| ID | Attack Vector | Tests |
|---|---|---|
| ADV-01 | Prompt injection in task description | Agent ignores injection |
| ADV-02 | Malicious layer name (`; DROP TABLE`) | Pydantic validation rejects |
| ADV-03 | Negative buffer distance | Pydantic validation rejects |
| ADV-04 | Nonexistent EPSG code | PyQGIS error, no crash |
| ADV-05 | Tool result containing instruction text | Agent treats as data |

## Task Schema

```json
{
  "task_id": "T017",
  "prompt": "Buffer the roads layer by 500m, then clip to the study area boundary",
  "difficulty": "intermediate",
  "required_layers": ["roads.shp", "study_area.shp"],
  "expected_operations": ["buffer", "clip"],
  "required_tools": ["buffer", "clip", "layer_info"],
  "minimum_tier": 2,
  "reference_output_path": "data/reference_outputs/T017/result.shp",
  "verification_config": {
    "geometry_type": "Polygon",
    "expected_crs": "EPSG:32633",
    "feature_count_tolerance": 0.05
  },
  "max_attempts": 3,
  "timeout_seconds": 300
}
```

## Related Files

- [KB-01-zhang-et-al-2025](../01-literature/papers/zhang-et-al-2025.md) — Task source
- [KB-12-geoanalystbench-overview](../12-tasks-benchmark/geoanalystbench-overview.md) — Full task details
- [KB-02-hypotheses](hypotheses.md) — H2a, H2b, H2c, H7a, H7b, H7c
