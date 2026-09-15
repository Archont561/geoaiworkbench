---
id: KB-12-reference-outputs
title: "Reference Output Generation"
category: tasks-benchmark
subcategory: reference
tags: [reference, outputs, ground-truth, generation]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-12-geoanalystbench-overview
  - KB-06-verifier-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "How reference outputs are generated and validated"
  key_facts:
    - "Generated from human-designed workflows"
    - "PyQGIS scripts in scripts/generate_reference_outputs.py"
    - "Stored in data/reference_outputs/{task_id}/"
    - "Cross-validated by geometry checks"
    - "Read-only during benchmark (chmod 444)"
  common_questions:
    - "Where do reference outputs come from?"
    - "How are they validated?"
---

# Reference Output Generation

## Process

1. Adapt ArcPy workflow to PyQGIS (see [KB-12-task-adaptation-qgis](task-adaptation-qgis.md))
2. Execute adapted workflow manually via PyQGIS
3. Save output to `data/reference_outputs/{task_id}/result.shp`
4. Validate: geometry validity, CRS, feature count
5. Set read-only: `chmod 444`

## Storage

```
data/reference_outputs/
├── T001/result.shp (+ .shx, .dbf, .prj)
├── T002/result.shp
├── ...
└── T050/result.shp
```

## Validation Checks

- `shapely.is_valid()` on all features
- CRS matches expected EPSG
- Feature count within reasonable range
- No empty geometries
- Attributes preserved

## Security

Reference outputs are **read-only** during benchmark execution to prevent agent tampering (see [KB-09-benchmark-security-warning](../09-testing/benchmark-security-warning.md)).

## Related Files

- [KB-06-verifier-implementation](../06-implementation/verifier-implementation.md)
- [KB-09-benchmark-security-warning](../09-testing/benchmark-security-warning.md)
