"""Protocol-independent core types for the GeoAIWorkbench benchmark.

The shared vocabulary every other package in this repository speaks: the
experiment's three conditions, the benchmark task identity, and the run record a
metric is computed from. Nothing here may import ``qgis``, ``mcp`` or any harness
module, because the whole point of the layer is that a definition of "a task" does
not change when the tool surface under test does.

This module is a scaffold. It declares the package identity the environment and the
test suite need and nothing else; the types it will hold are specified in
``.knowledge/`` and are not implemented yet.
"""

__version__ = "0.1.0"

__all__ = ["__version__"]
