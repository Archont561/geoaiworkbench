---
id: KB-12-task-adaptation-qgis
title: "ArcPy to QGIS Task Adaptation"
category: tasks-benchmark
subcategory: adaptation
tags: [adaptation, arcpy, pyqgis, translation, mapping]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-12-geoanalystbench-overview
  - KB-05-tool-spec-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "How ArcPy tasks are adapted to PyQGIS"
  key_facts:
    - "GeoAnalystBench uses ArcPy"
    - "All tasks must be translated to PyQGIS Processing"
    - "Data format changes: FileGDB → GeoPackage"
    - "Parameter name differences"
  common_questions:
    - "How do I adapt ArcPy tasks?"
    - "What changes are needed?"
---

# ArcPy to QGIS Task Adaptation

## Translation Table

| ArcPy Function | QGIS Processing | Parameter Differences |
|---|---|---|
| `arcpy.Buffer_analysis(in, out, dist)` | `native:buffer` | INPUT, OUTPUT, DISTANCE |
| `arcpy.Clip_analysis(in, clip, out)` | `native:clip` | INPUT, OVERLAY, OUTPUT |
| `arcpy.Intersect_analysis(in, out)` | `native:intersection` | INPUT, OVERLAY, OUTPUT |
| `arcpy.Dissolve_management(in, out, field)` | `native:dissolve` | INPUT, FIELD, OUTPUT |
| `arcpy.Union_analysis(in, out)` | `native:union` | INPUT, OVERLAY, OUTPUT |
| `arcpy.Project_management(in, out, sr)` | `native:reprojectlayer` | INPUT, TARGET_CRS, OUTPUT |
| `arcpy.SpatialJoin_analysis(tgt, join, out)` | `native:joinattributesbylocation` | INPUT, JOIN, PREDICATE, OUTPUT |
| `arcpy.CalculateField_management(in, fld, expr)` | `native:fieldcalculator` | INPUT, FIELD_NAME, FORMULA, OUTPUT |
| `arcpy.Select_analysis(in, out, where)` | `native:extractbyexpression` | INPUT, EXPRESSION, OUTPUT |
| `arcpy.Merge_management(inputs, out)` | `native:mergevectorlayers` | LAYERS, OUTPUT |

## Data Format Changes

| ArcPy | QGIS |
|---|---|
| File Geodatabase (.gdb) | GeoPackage (.gpkg) |
| Shapefile (.shp) | Shapefile (.shp) or GeoPackage |
| ArcSDE | PostGIS or GeoPackage |
| Raster (.img) | GeoTIFF (.tif) |

## Adaptation Process

1. Read ArcPy task description from GeoAnalystBench
2. Map each arcpy function to QGIS Processing algorithm
3. Translate parameter names
4. Convert data paths to GeoPackage
5. Generate reference output using PyQGIS
6. Verify output matches ArcPy reference (if available)
7. Write BenchmarkTask JSON

## Related Files

- [KB-12-geoanalystbench-overview](geoanalystbench-overview.md)
- [KB-05-tool-spec-overview](../05-mcp-tools/tool-spec-overview.md)
