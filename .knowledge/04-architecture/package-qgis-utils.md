---
id: KB-04-package-qgis-utils
title: "Package: qgis_utils"
category: architecture
subcategory: package
tags: [package, qgis-utils, headless, qgsapplication, processing]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 7]
related:
  - KB-04-system-architecture
  - KB-09-tests-qgis-utils
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Headless QGIS lifecycle management package"
  key_facts:
    - "No dependency on geoaiworkbench or geoaibenchmark"
    - "HeadlessIface: no-op QgisInterface stub"
    - "qgis_app: context manager for QgsApplication"
    - "init_processing: initializes Processing framework"
    - "26 tests in test suite"
  common_questions:
    - "What does qgis_utils do?"
    - "Why is it a separate package?"
    - "How does headless mode work?"
---

# Package: qgis_utils

## Purpose

Provides headless QGIS lifecycle management. Enables running PyQGIS operations without the QGIS GUI.

## Design Principle

**Zero coupling** to `geoaiworkbench` or `geoaibenchmark`. This package depends only on PyQGIS (system QGIS Python). It can be used independently by any project needing headless QGIS.

## Components

### HeadlessIface

```python
class HeadlessIface:
    """No-op QgisInterface stub for headless operation.

    Implements the QgisInterface API with empty methods.
    Allows code that expects iface to run without GUI.
    """
    def mainWindow(self): return None
    def mapCanvas(self): return None
    def addToolBarIcon(self, action): pass
    def removeToolBarIcon(self, action): pass
    # ... all other QgisInterface methods as no-ops
```

**Why needed:** Many QGIS plugins and Processing algorithms expect a `QgisInterface` object. In headless mode, there is no GUI, so we provide a stub.

### qgis_app Context Manager

```python
from contextlib import contextmanager

@contextmanager
def qgis_app(gui_enabled: bool = False):
    """Context manager for QgsApplication lifecycle.

    Usage:
        with qgis_app() as app:
            layer = QgsVectorLayer("roads.shp", "roads", "ogr")
            # ... do work ...
        # QgsApplication.exitQgis() called automatically
    """
    app = QgsApplication([], gui_enabled)
    app.initQgis()
    try:
        yield app
    finally:
        app.exitQgis()
```

**Critical:** `app.exitQgis()` MUST be called to clean up C++ resources. Context manager ensures this even on exceptions.

### resolve_qgis_paths

```python
def resolve_qgis_paths() -> dict[str, str]:
    """Find QGIS installation paths.

    Returns dict with keys:
    - prefix: QGIS installation prefix
    - plugin_path: Plugin directory
    - processing_path: Processing algorithms
    """
    # Checks: conda env, system install, Docker image
    ...
```

**Why needed:** QGIS paths vary by installation method (conda-forge, apt, Docker, macOS bundle).

### init_processing

```python
def init_processing():
    """Initialize the QGIS Processing framework.

    Must be called after QgsApplication.initQgis().
    Not needed when using pytest-qgis qgis_processing fixture.
    """
    from processing.core.Processing import Processing
    Processing.initialize()
```

**Note:** When using `pytest-qgis`, the `qgis_processing` fixture handles this automatically.

### loaded_plugin Context Manager

```python
@contextmanager
def loaded_plugin(plugin_class, iface=None):
    """Load and unload a QGIS plugin for testing.

    Usage:
        with loaded_plugin(GeoAIWorkbenchPlugin) as plugin:
            plugin.run_task(...)
    """
    iface = iface or HeadlessIface()
    plugin = plugin_class(iface)
    plugin.initGui()
    try:
        yield plugin
    finally:
        plugin.unload()
```

## Dependencies

```
qgis_utils/
├── __init__.py
├── headless.py      # HeadlessIface, qgis_app
└── paths.py         # resolve_qgis_paths, init_processing
```

**External:** PyQGIS (from system QGIS Python via Pixi conda-forge)

## Testing

26 tests covering:
- `qgis_app` lifecycle (init + cleanup)
- `HeadlessIface` method coverage
- `resolve_qgis_paths` on different platforms
- `init_processing` algorithm availability
- `loaded_plugin` load/unload cycle

## Related Files

- [KB-09-tests-qgis-utils](../09-testing/tests-qgis-utils.md) — Test details
- [KB-15-qgis-pyqgis-docs](../15-external-references/qgis-pyqgis-docs.md) — PyQGIS reference
