---
id: KB-15-qgis-pyqgis-docs
title: "QGIS and PyQGIS Documentation Links"
category: external-references
subcategory: gis-docs
tags: [qgis, pyqgis, processing, plugin-development, urls]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [4, 7]
related:
  - KB-08-qgis-version-3.44
  - KB-15-github-repositories
authoritative: false
implementation_status: specified
llm_hints:
  primary_purpose: "Curated list of QGIS and PyQGIS documentation URLs"
  key_facts:
    - "QGIS 3.44.x is target version"
    - "PyQGIS Cookbook is the practical reference"
    - "Processing framework docs are separate from PyQGIS"
    - "qgis-plugin-ci v2.10.0 is current"
    - "checkParameterValues() enables MCP-15 semantic validation"
  common_questions:
    - "Where is the PyQGIS API reference?"
    - "How do I write a QGIS plugin?"
    - "Where is the Processing algorithm list?"
    - "How do I run QGIS headless?"
    - "How do I validate Processing algorithm parameters?"
---

# QGIS and PyQGIS Documentation

Curated links to QGIS documentation. All URLs verified September 2026. Target version: QGIS 3.44.x.

## Main Documentation

### QGIS Documentation Portal
- **Main:** https://docs.qgis.org/
- **Latest LTR:** 3.40 (Long-Term Release)
- **Current stable:** 3.44

### QGIS User Manual
- **URL:** https://docs.qgis.org/latest/en/docs/user_manual/
- **Relevant sections:** Processing framework, working with vector data, working with raster data

### QGIS Server Documentation
- **URL:** https://docs.qgis.org/latest/en/docs/server_manual/
- **Not directly used** (GeoAIWorkbench doesn't use QGIS Server)

## PyQGIS

### PyQGIS Developer Cookbook
- **URL:** https://docs.qgis.org/latest/en/docs/pyqgis_developer_cookbook/
- **Primary reference for plugin development**
- **Sections used in GeoAIWorkbench:**
  - Loading Projects
  - Using Vector Layers
  - Using Raster Layers
  - Using Coordinate Reference Systems
  - Using the Processing Framework

### PyQGIS API Reference (Python)
- **URL:** https://qgis.org/pyqgis/latest/
- **Structure:**
  - `qgis.core` — Vector/raster layers, geometry, CRS, project
  - `qgis.gui` — Not used in headless mode
  - `qgis.analysis` — Analysis operations (used minimally)
  - `qgis.processing` — Processing framework Python API
  - `qgis.utils` — Plugin loading, iface reference

### PyQGIS Classes Used in GeoAIWorkbench
- `QgsApplication` — Application lifecycle
- `QgsProject` — Loaded project state
- `QgsVectorLayer` — Vector layer access
- `QgsRasterLayer` — Raster layer access
- `QgsCoordinateReferenceSystem` — CRS handling
- `QgsProcessingAlgRunnerTask` — Async algorithm execution (not used; sync `processing.run` preferred)
- `QgsProcessingRegistry` — Algorithm registry (used in MCP-15 semantic validation)

## Processing Framework

### Processing Documentation
- **URL:** https://docs.qgis.org/latest/en/docs/user_manual/processing/
- **Algorithm Reference:** https://docs.qgis.org/latest/en/docs/user_manual/processing_algs/

### Native Algorithms Used by GeoMCP (MCP-15)

**Tier 2 (MCP-5 + MCP-15):**
- `native:buffer` — Buffer creation
- `native:clip` — Vector clipping
- `native:reprojectlayer` — CRS transformation
- `qgis:basicstatisticsforfields` — Field statistics

**Tier 3 (MCP-15 only):**
- `native:dissolve` — Feature dissolution by attribute
- `native:intersection` — Geometric intersection
- `native:difference` — Geometric difference
- `native:union` — Geometric union
- `native:joinattributesbylocation` — Spatial join
- `native:selectbylocation` — Location-based selection

**Tier 4 (MCP-15 only):**
- `native:centroids` — Feature centroids
- `native:simplifygeometries` — Geometry simplification

**Tier 5 (MCP-15 only):**
- `native:mergevectorlayers` — Layer merging
- `native:fieldcalculator` — Field calculation with expressions

### Algorithm Validation API

**CRITICAL for MCP-15 semantic validation:**

- `QgsProcessingAlgorithm.checkParameterValues()` — https://api.qgis.org/api/classQgsProcessingAlgorithm.html
- `QgsProcessingAlgorithm.canExecute()` — Same URL
- `QgsProcessingRegistry.algorithmById()` — https://api.qgis.org/api/classQgsProcessingRegistry.html

Example:
```python
from qgis.core import QgsApplication, QgsProcessingContext

registry = QgsApplication.processingRegistry()
alg = registry.algorithmById("native:buffer")
if alg is None:
    raise ValueError("Algorithm not found")

context = QgsProcessingContext()
ok, msg = alg.checkParameterValues(parameters, context)
```

Used in [KB-06-implementation](../06-implementation/) for MCP-15 tool implementation and CodeGen semantic validation.

### qgis_process CLI
- **Docs:** https://docs.qgis.org/latest/en/docs/user_manual/processing/standalone.html
- **Usage:** Standalone algorithm execution outside QGIS GUI
- **Not primary tool** in GeoAIWorkbench (Python API preferred for control)

## Plugin Development

### Plugin Development Guide
- **URL:** https://docs.qgis.org/latest/en/docs/pyqgis_developer_cookbook/plugins/
- **Sections:**
  - Plugin structure
  - metadata.txt format
  - `__init__.py` and `plugin.py` conventions
  - Plugin loading lifecycle

### QGIS Plugin Repository
- **URL:** https://plugins.qgis.org/
- **Publishing docs:** https://plugins.qgis.org/publish/
- **GeoAIWorkbench publication target:** Yes, after thesis defense

### Plugin Builder 3
- **QGIS Plugin Repository:** https://plugins.qgis.org/plugins/pluginbuilder3/
- **Purpose:** Scaffold new plugin structure
- **Usage in GeoAIWorkbench:** Used once to generate initial skeleton, then heavily customized

### Plugin Reloader
- **QGIS Plugin Repository:** https://plugins.qgis.org/plugins/plugin_reloader/
- **Purpose:** Reload plugin without restarting QGIS
- **Essential for iterative development**

### qgis-plugin-ci
- **GitHub:** https://github.com/opengisch/qgis-plugin-ci
- **Current version:** 2.10.0 (May 18, 2026)
- **Purpose:** CI/CD for QGIS plugins (packaging, releasing, deploying)
- **Used in GeoAIWorkbench:** GitHub Actions workflow for plugin releases

## Headless Operation

### Running QGIS Headlessly
- **Community guide:** https://gis.stackexchange.com/questions/tagged/headless
- **Docker image:** `qgis/qgis:3.44.14-noble` (Docker Hub)
- **Docker Hub:** https://hub.docker.com/r/qgis/qgis
- **conda-forge:** `conda install -c conda-forge qgis`

### QT_QPA_PLATFORM
- **For headless:** `export QT_QPA_PLATFORM=offscreen`
- **Fallback with GUI-dependent code:** `xvfb-run -a python script.py`
- **Applied in:** [KB-04-asyncio-in-qt](../04-architecture/asyncio-in-qt.md)

## Testing

### pytest-qgis
- **PyPI:** https://pypi.org/project/pytest-qgis/
- **GitHub:** https://github.com/GispoCoding/pytest-qgis
- **Maintainer:** OSGeo Suomi / Gispo
- **Key fixtures:**
  - `qgis_app` — Initializes `QgsApplication`
  - `qgis_processing` — Initializes Processing framework
  - `qgis_iface` — Provides interface stub
- **Applied in:** [KB-09-tests-qgis-utils](../09-testing/tests-qgis-utils.md)

## Coordinate Reference Systems

### CRS Reference
- **EPSG Registry:** https://epsg.org/
- **spatialreference.org:** https://spatialreference.org/
- **QGIS CRS docs:** https://docs.qgis.org/latest/en/docs/user_manual/working_with_projections/

### Common CRS in GeoAIWorkbench Tasks
- EPSG:4326 — WGS 84 (geographic)
- EPSG:3857 — Web Mercator
- EPSG:32633 — UTM Zone 33N (common European projected)
- EPSG:2180 — ETRF2000-PL / CS92 (Polish grid, relevant for local context)

## QGIS Expression Language (for `calculate_field` tool)

Used by the MCP-15 `calculate_field` tool. Requires expression sanitization for security.

- **Docs:** https://docs.qgis.org/latest/en/docs/user_manual/expressions/expression.html
- **Common expressions:** `$area`, `length($geometry)`, `field1 + field2`, `substr(field, 1, 3)`
- **Security concern:** Expression can invoke external functions — must be validated. See [KB-10-security](../10-security/) for `calculate_field` expression injection mitigation.

## API Version Compatibility

GeoAIWorkbench targets QGIS ≥3.40 (LTR) with primary testing on 3.44.

Breaking changes to watch:
- 3.30 → 3.40: `QgsMapLayer.temporalProperties()` moved
- 3.36 → 3.40: Some Processing algorithm parameter names normalized
- Future 4.0: PyQt6 migration expected (not yet released)

## Community Resources

### Mailing Lists
- **qgis-user:** https://lists.osgeo.org/mailman/listinfo/qgis-user
- **qgis-developer:** https://lists.osgeo.org/mailman/listinfo/qgis-developer

### Stack Exchange
- **GIS StackExchange QGIS tag:** https://gis.stackexchange.com/questions/tagged/qgis
- **PyQGIS tag:** https://gis.stackexchange.com/questions/tagged/pyqgis

### GitHub
- **QGIS main repo:** https://github.com/qgis/QGIS
- **Issue tracker:** https://github.com/qgis/QGIS/issues

## Related Repositories

Existing QGIS + MCP integration:

- **qgis-mcp (nkarasiak):** https://github.com/nkarasiak/qgis-mcp (v0.3.1, 118 tools, GPL-2.0)
  - ⚠️ Exposes `execute_code` — contaminates paradigm boundary
  - Reference implementation for TCP bridge pattern
- **QGIS2OllamaMCP:** Search GitHub "QGIS2OllamaMCP"
  - Smaller tool set; also exposes `execute_code`

### QGIS Plugin Tooling
All analyzed in [KB-08-cli-agent-selection](../08-technology-decisions/cli-agent-selection.md).
