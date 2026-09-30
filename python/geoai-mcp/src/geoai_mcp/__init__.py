"""GeoMCP server exposing the geospatial tool tiers for MCP-5 and MCP-15.

The server behind conditions A and B of the experiment: constrained Model Context
Protocol tool calling with exactly 5 exposed tools, and the expanded 15-tool
surface organised in 5 tiers. Condition C — direct PyQGIS code generation — does
not go through this package at all, which is what makes the three conditions
comparable: A and B differ only in tool count, and neither shares a code path with
C.

The layer boundary is strict. Tool *definitions* belong here; a rule about what a
tool is allowed to do belongs in :mod:`geoai_core`, because a rule written in the
server is a rule the code-generation condition's evaluator has to write again.

This module is a scaffold. It declares the package identity the environment and the
test suite need and nothing else; the tool tiers are specified in
``.knowledge/05-mcp-tools/`` and are not implemented yet.
"""

__version__ = "0.1.0"

__all__ = ["__version__"]
