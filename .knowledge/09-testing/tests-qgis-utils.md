---
id: KB-09-tests-qgis-utils
title: "Tests: qgis_utils (26 tests)"
category: testing
subcategory: package-tests
tags: [testing, qgis-utils, headless, pytest-qgis]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5]
related:
  - KB-09-test-inventory
  - KB-04-package-qgis-utils
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Test details for qgis_utils package"
  key_facts:
    - "26 tests: lifecycle, headless, paths, processing, plugin"
    - "Uses pytest-qgis fixtures"
    - "Tests real QgsApplication initialization"
  common_questions:
    - "How is headless mode tested?"
    - "What fixtures are used?"
---

# Tests: qgis_utils (26 tests)

## Key Fixtures

```python
# conftest.py
@pytest.fixture
def qgis_app(qgis_processing):
    """pytest-qgis provides QgsApplication + Processing init."""
    return qgis_processing
```

## Test Categories

### Lifecycle (5 tests)
- `test_qgis_app_init` — QgsApplication initializes
- `test_qgis_app_cleanup` — exitQgis called on exit
- `test_qgis_app_exception` — Cleanup on exception
- `test_qgis_app_context` — Context manager protocol
- `test_qgis_app_reentrant` — Multiple context entries

### HeadlessIface (5 tests)
- `test_iface_main_window` — Returns None
- `test_iface_map_canvas` — Returns None
- `test_iface_add_toolbar` — No-op, no exception
- `test_iface_all_methods` — All QgisInterface methods callable
- `test_iface_type_check` — Passes isinstance checks

### Paths (5 tests)
- `test_resolve_conda` — Finds conda-forge QGIS
- `test_resolve_docker` — Finds Docker QGIS
- `test_resolve_system` — Finds system QGIS
- `test_resolve_fallback` — Graceful failure
- `test_resolve_prefix` — Correct prefix path

### Processing (5 tests)
- `test_init_processing` — Processing.initialize() succeeds
- `test_algorithms_available` — native:buffer, native:clip exist
- `test_algorithm_count` — >200 algorithms registered
- `test_processing_run` — Simple algorithm execution
- `test_processing_error` — Invalid algorithm raises

### Plugin (6 tests)
- `test_plugin_load` — Plugin initializes
- `test_plugin_unload` — Plugin cleans up
- `test_plugin_context` — Context manager works
- `test_plugin_iface` — Receives HeadlessIface
- `test_plugin_init_gui` — initGui callable
- `test_plugin_metadata` — metadata.txt valid

## Related Files

- [KB-04-package-qgis-utils](../04-architecture/package-qgis-utils.md)
- [KB-15-qgis-pyqgis-docs](../15-external-references/qgis-pyqgis-docs.md)
