---
id: KB-12-geoanalystbench-overview
title: "GeoAnalystBench Overview"
category: tasks-benchmark
subcategory: overview
tags: [geoanalystbench, tasks, benchmark, zhang, arcpy]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [6, 15]
related:
  - KB-01-zhang-et-al-2025
  - KB-02-task-stratification
  - KB-12-task-schema
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Overview of GeoAnalystBench as primary task source"
  key_facts:
    - "50 expert-validated Python geoprocessing tasks"
    - "Originally ArcPy — requires QGIS adaptation"
    - "GitHub: GeoDS/GeoAnalystBench"
    - "Reference outputs may need generation"
    - "Metrics: workflow validity, CodeBLEU"
  common_questions:
    - "What is GeoAnalystBench?"
    - "Does it use PyQGIS?"
    - "Where are the tasks?"
---

# GeoAnalystBench Overview

## Source

Zhang, Q., et al. (2025). GeoAnalystBench: A GeoAI Benchmark for Assessing LLMs for Spatial Analysis Workflow and Code Generation. *Transactions in GIS, 29*.

## Key Facts

- **50 tasks** total, expert-validated
- **Python-based** geoprocessing workflows
- **Originally ArcPy** — NOT PyQGIS (critical adaptation needed)
- **Metrics:** Workflow validity, structural alignment, semantic similarity, CodeBLEU
- **Repository:** https://github.com/GeoDS/GeoAnalystBench
- **Data:** Google Drive supplementary materials

## Adaptation Required

| ArcPy | PyQGIS Equivalent |
|---|---|
| `arcpy.Buffer_analysis()` | `processing.run("native:buffer", {...})` |
| `arcpy.Clip_analysis()` | `processing.run("native:clip", {...})` |
| `arcpy.Project_management()` | `processing.run("native:reprojectlayer", {...})` |
| `arcpy.Dissolve_management()` | `processing.run("native:dissolve", {...})` |
| `arcpy.Intersect_analysis()` | `processing.run("native:intersection", {...})` |
| `arcpy.SpatialJoin_analysis()` | `processing.run("native:joinattributesbylocation", {...})` |
| `arcpy.CalculateField_management()` | `processing.run("native:fieldcalculator", {...})` |
| ArcSDE / FileGDB | GeoPackage / Shapefile |

## Task Distribution (Estimated)

| Difficulty | Count | MCP-5 Sufficient? |
|---|---|---|
| Basic | ~15 | ✅ Yes |
| Intermediate | ~20 | ⚠️ Partially |
| Advanced | ~15 | ❌ Needs MCP-15 |

## Reference Output Concern

The repository provides task metadata but **reference output shapefiles may be limited**. GeoAIWorkbench must:
1. Generate reference outputs from human-designed workflows
2. Cross-validate with task descriptions
3. Verify via geometry validity checks

## Related Files

- [KB-01-zhang-et-al-2025](../01-literature/papers/zhang-et-al-2025.md)
- [KB-02-task-stratification](../02-research-design/task-stratification.md)
- [KB-12-task-schema](task-schema.md)
