---
id: KB-15-fastmcp-docs
title: "FastMCP Documentation Links"
category: external-references
subcategory: mcp-framework
tags: [fastmcp, mcp, python-sdk, framework, urls]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [4, 7]
related:
  - KB-15-mcp-official-docs
  - backlog-decision-8
  - KB-06-geo-mcp-server
authoritative: false
implementation_status: specified
llm_hints:
  primary_purpose: "FastMCP standalone package documentation"
  key_facts:
    - "FastMCP v4.0.3 is standalone package (not mcp.server.fastmcp)"
    - "Uses @mcp.tool decorator without parentheses"
    - "Apache-2.0 license"
    - "Maintained by Prefect (Jeremiah Lowin)"
    - "Supports dynamic tool registration for tier control"
  common_questions:
    - "Where is FastMCP documented?"
    - "What is the current version?"
    - "How is it different from mcp SDK?"
    - "How do I dynamically register/unregister tools for tier control?"
---

# FastMCP Documentation

FastMCP is the framework used to build the GeoMCP server. As of 2026, it is a **standalone package** separate from the official MCP Python SDK.

## Current Version

- **Package name:** `fastmcp`
- **PyPI:** https://pypi.org/project/fastmcp/
- **Current version:** 4.0.3 (September 5, 2026)
- **License:** Apache-2.0
- **Maintainer:** Prefect (Jeremiah Lowin)
- **Python:** ≥3.10

⚠️ **Important distinction:** FastMCP 1.0 was incorporated into the official MCP Python SDK in 2024. Since then, the standalone `fastmcp` package has continued to evolve independently and is now at v4.x. Do NOT confuse:

- `from mcp.server.fastmcp import FastMCP` — v1 pattern, REMOVED in MCP SDK v2
- `from mcp.server import MCPServer` — official MCP SDK v2 pattern
- `from fastmcp import FastMCP` — standalone `fastmcp` v4.x pattern **(used by GeoAIWorkbench)**

## Documentation

### Main Docs
- **Site:** https://gofastmcp.com/
- **GitHub:** https://github.com/jlowin/fastmcp

### Getting Started
- **Quickstart:** https://gofastmcp.com/getting-started/quickstart
- **Installation:** `pip install fastmcp` or `pixi add --pypi fastmcp`

### API Reference
- **Full API:** https://gofastmcp.com/api-reference/
- **FastMCP class:** https://gofastmcp.com/api-reference/fastmcp
- **Tools:** https://gofastmcp.com/api-reference/tools
- **Resources:** https://gofastmcp.com/api-reference/resources
- **Prompts:** https://gofastmcp.com/api-reference/prompts

## Key Concepts

### The FastMCP Class

```python
from fastmcp import FastMCP

mcp = FastMCP("GeoAIWorkbench", instructions="Server-level instructions here")
```

### Tool Decoration

**Current pattern (v4.x):**
```python
@mcp.tool  # NO parentheses
def buffer(request: BufferInput) -> BufferOutput:
    """Tool docstring becomes the description."""
    ...
```

**Old pattern (v1, do NOT use):**
```python
@mcp.tool()  # With parentheses - v1 style
def buffer_layer(...):
    ...
```

### Tool Annotations

```python
@mcp.tool(
    annotations={
        "readOnlyHint": True,
        "destructiveHint": False,
        "idempotentHint": True,
        "openWorldHint": False,
    }
)
def layer_info(request: LayerInfoInput) -> LayerInfoOutput:
    """Inspect a QGIS layer and return its metadata."""
    ...
```

### Server Instructions

```python
SERVER_INSTRUCTIONS = """
Use the smallest number of tools necessary to complete the user's GIS task.
...
"""

mcp = FastMCP("GeoAIWorkbench", instructions=SERVER_INSTRUCTIONS)
```

### Running the Server

```python
if __name__ == "__main__":
    mcp.run()  # Default: stdio transport
    # Or: mcp.run(transport="streamable-http", port=8000)
```

## Dynamic Tool Registration (for Tier Control)

FastMCP 4.x supports tool removal at runtime, which is essential for MCP-5 vs MCP-15 tier control:

```python
import os

TIER = os.environ.get("GEOMCP_TIER", "5")

TIER_3_PLUS = {
    "dissolve", "intersection", "difference", "union",
    "spatial_join", "select_by_location",
    "centroid", "simplify",
    "merge_layers", "calculate_field",
}

def _enforce_tier():
    if TIER == "5":
        for tool_name in TIER_3_PLUS:
            mcp._tool_manager._tools.pop(tool_name, None)

    # Paradigm boundary enforcement
    FORBIDDEN = {"execute_code", "shell", "run_python"}
    registered = set(mcp._tool_manager._tools.keys())
    assert not (registered & FORBIDDEN), "Paradigm violation!"

_enforce_tier()
```

## Transports

FastMCP 4.x supports:

- **stdio** (default) — for local agent integration
- **Streamable HTTP** — for remote deployment
- **SSE** — deprecated but supported

For GeoAIWorkbench: use stdio (matches all 4 CLI agents' expectations).

## Pydantic Integration

FastMCP uses Pydantic v2 natively for tool input/output schemas:

```python
from pydantic import BaseModel, Field
from typing import Annotated

class BufferInput(BaseModel):
    input_layer: str = Field(description="Exact QGIS layer name or ID.")
    distance: Annotated[float, Field(gt=0)] = Field(
        description="Buffer distance in input layer CRS units."
    )
    segments: Annotated[int, Field(ge=1)] = Field(default=5)
    dissolve: bool = Field(default=False)
    output_layer: str
```

Validators run before the tool function is called. Validation errors are returned to the LLM as MCP error responses.

## Advanced Features

### Context Injection

```python
from fastmcp import Context

@mcp.tool
def some_tool(request: MyInput, ctx: Context) -> MyOutput:
    ctx.info("Processing started")
    ctx.progress(0.5)
    ...
```

Not used in GeoMCP (kept simple for benchmark).

### Middleware

```python
@mcp.middleware
async def logging_middleware(request, call_next):
    ...
    result = await call_next(request)
    ...
    return result
```

Used in GeoMCP for MCPMonitor integration.

### Multiple Servers / Composition

Supported via mount points. Not used in GeoMCP.

## Comparison with Official MCP SDK v2

| Feature | Standalone FastMCP v4.x | Official MCP SDK v2 |
|---|---|---|
| Package | `fastmcp` | `mcp` |
| Class | `FastMCP` | `MCPServer` |
| Decorator | `@mcp.tool` | `@mcp.tool()` |
| Import | `from fastmcp import FastMCP` | `from mcp.server import MCPServer` |
| Version | 4.0.3 | 2.2.0 |
| License | Apache-2.0 | MIT |
| Stability | Very stable API | v2 released July 2026 |
| Dynamic tool removal | ✅ Well-supported | ⚠️ Less documented |

## Why GeoAIWorkbench Uses Standalone FastMCP

See backlog `decision-8` for full rationale.

Summary:
1. Matches original design intent (before MCP SDK v2 breaking changes)
2. Simpler decorator syntax (`@mcp.tool` without parens)
3. Better dynamic tool registration API (critical for tier control)
4. Actively maintained by Prefect
5. Stable API since v3.x
6. Better documentation site (gofastmcp.com)

## Common Issues

### Async vs Sync Tools

FastMCP supports both. GeoMCP uses **sync** tools because PyQGIS is sync:

```python
@mcp.tool  # Sync
def buffer(request: BufferInput) -> BufferOutput:
    result = processing.run("native:buffer", {...})  # Sync PyQGIS call
    return BufferOutput(...)
```

Sync tools run on worker threads inside FastMCP's event loop.

### Error Handling

```python
from fastmcp.exceptions import ToolError

@mcp.tool
def buffer(request: BufferInput) -> BufferOutput:
    try:
        result = processing.run("native:buffer", {...})
    except Exception as e:
        raise ToolError(f"Buffer failed: {e}") from e
```

`ToolError` translates to MCP error response.

### Testing

```python
from fastmcp.testing import Client

def test_buffer_tool():
    with Client(mcp) as client:
        result = client.call_tool("buffer", {
            "input_layer": "roads",
            "distance": 500,
            "output_layer": "roads_buf",
        })
        assert result.output_layer == "roads_buf"
```

## Community

- **Discord:** Linked from gofastmcp.com
- **GitHub Discussions:** https://github.com/jlowin/fastmcp/discussions
- **Issue tracker:** https://github.com/jlowin/fastmcp/issues

## Related Documentation

- **Official MCP:** [KB-15-mcp-official-docs](mcp-official-docs.md)
- **Pixi (for installation):** [KB-15-pixi-docs](pixi-docs.md)
- **GeoMCP implementation:** [KB-06-geo-mcp-server](../06-implementation/geo-mcp-server.md)
