---
id: KB-03-layer3-output-quality
title: "Layer 3 — Output Quality Metrics"
category: metrics
subcategory: layer3
tags: [metrics, output-quality, OQS, geometry, CRS, IoU]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3]
related:
  - KB-03-metrics-overview
  - KB-06-verifier-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Layer 3 metrics: OQS and its 5 sub-metrics for spatial output verification"
  key_facts:
    - "OQS = composite of 5 sub-metrics"
    - "Identical verification for all 3 conditions"
    - "Uses Shapely, GeoPandas, rasterio, pyproj"
    - "OutputVerifier runs as independent process"
  common_questions:
    - "What is OQS?"
    - "How is geometry validity checked?"
    - "Is verification the same for MCP and CodeGen?"
---

# Layer 3 — Output Quality Metrics

## Overview

Layer 3 measures the quality of spatial output artifacts. This layer is **identical across all 3 conditions** — the OutputVerifier doesn't know or care how the output was produced.

## Output Quality Score (OQS)

**Formula:**
```
OQS = (geometry_valid + feature_count_match + crs_match + extent_iou + attribute_preserved) / 5
```

**Range:** [0, 1]

**Primary metric for:** PB1

## Sub-Metrics

### 1. Geometry Validity

**Formula:**
```
geometry_valid = |{valid features}| / |{total features}|
```

**Implementation:** `shapely.is_valid()` on every feature geometry.

**Pass threshold:** ≥ 0.95 (allow minor topology issues)

### 2. Feature Count Match

**Formula:**
```
feature_count_match = 1 if |actual - reference| / reference ≤ 0.05 else 0
```

**Implementation:** `len(gdf)` comparison with ±5% tolerance.

**Rationale:** Small count differences acceptable due to boundary effects.

### 3. CRS Match

**Formula:**
```
crs_match = 1 if actual_crs == reference_crs else 0
```

**Implementation:** `pyproj.CRS(actual).equals(pyproj.CRS(reference))`

**Strict:** Must match exactly. CRS errors are critical.

### 4. Extent IoU

**Formula:**
```
extent_iou = area(intersection) / area(union)
```

**Implementation:** Bounding box intersection over union via Shapely.

**Range:** [0, 1]

**Pass threshold:** ≥ 0.90

### 5. Attribute Preservation

**Formula:**
```
attribute_preserved = |{required fields present in output}| / |{required fields}|
```

**Implementation:** Compare output GeoDataFrame columns against reference.

**Range:** [0, 1]

**Pass threshold:** 1.0 (all required fields must be present)

## Raster Output Metrics (when applicable)

For tasks producing raster outputs:

| Metric | Implementation |
|---|---|
| CRS Match | `rasterio.open().crs` comparison |
| Resolution Match | Pixel size comparison ±1% |
| RMSE | Root mean square error vs reference raster |
| No-Data Handling | Correct no-data value and mask |

## Map Output Metrics (when applicable)

For tasks producing cartographic outputs:

| Metric | Implementation |
|---|---|
| SSIM | `skimage.metrics.structural_similarity` vs reference image |
| VLM Assessment | GPT-4o Vision qualitative scoring (optional) |

## OutputVerifier Architecture

```
Agent completes task
       │
       ▼
Agent process terminates
       │
       ▼
Harness collects workspace/output/
       │
       ▼
OutputVerifier (SEPARATE PROCESS)
       │
       ├── Load reference output
       ├── Load agent output
       ├── Compute 5 sub-metrics
       ├── Compute OQS
       └── Return pass/fail + OQS
```

**Critical:** OutputVerifier runs as independent process AFTER agent terminates. This prevents benchmark contamination (agent cannot tamper with verifier). See SWE-bench contamination warnings.

## Libraries Used

| Library | Purpose |
|---|---|
| Shapely | Geometry validity, IoU |
| GeoPandas | Feature count, attributes, CRS |
| rasterio | Raster CRS, resolution, RMSE |
| pyproj | CRS validation and comparison |
| scikit-image | SSIM for map outputs |

## Related Files

- [KB-06-verifier-implementation](../06-implementation/verifier-implementation.md) — Code details
- [KB-03-layer1-task-success](layer1-task-success.md) — TSR uses OQS pass/fail
