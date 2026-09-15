---
id: KB-05-mcp-annotations
title: "MCP Tool Annotations"
category: mcp-tools
subcategory: annotations
tags: [mcp, annotations, readOnlyHint, destructiveHint, idempotentHint]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8]
related:
  - KB-05-tool-spec-overview
  - KB-15-mcp-official-docs
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "MCP behavioral annotations for all 15 GeoMCP tools"
  key_facts:
    - "4 annotation types: readOnlyHint, destructiveHint, idempotentHint, openWorldHint"
    - "Annotations are HINTS, not security guarantees"
    - "Tier 1 tools: readOnly=true; Tier 2-5: readOnly=false"
    - "All tools: idempotent=true, destructive=false, openWorld=false"
  common_questions:
    - "What are MCP annotations?"
    - "Are they security guarantees?"
    - "What annotations does each tool have?"
---

# MCP Tool Annotations

## Annotation Types

Based on MCP blog post 2026-03-16: https://blog.modelcontextprotocol.io/posts/2026-03-16-tool-annotations/

| Annotation | Type | Meaning |
|---|---|---|
| `readOnlyHint` | bool | Tool does not modify state |
| `destructiveHint` | bool | Tool may delete or overwrite data |
| `idempotentHint` | bool | Calling twice produces same result |
| `openWorldHint` | bool | Tool interacts with external systems |

⚠️ **Important:** Annotations are **hints for the LLM**, not security guarantees. Clients should not blindly trust them from untrusted servers.

## Annotation Table

| Tool | readOnly | destructive | idempotent | openWorld |
|---|---|---|---|---|
| `layer_info` | ✅ true | ❌ false | ✅ true | ❌ false |
| `layer_statistics` | ✅ true | ❌ false | ✅ true | ❌ false |
| `buffer` | ❌ false | ❌ false | ✅ true | ❌ false |
| `clip` | ❌ false | ❌ false | ✅ true | ❌ false |
| `reproject` | ❌ false | ❌ false | ✅ true | ❌ false |
| `dissolve` | ❌ false | ❌ false | ✅ true | ❌ false |
| `intersection` | ❌ false | ❌ false | ✅ true | ❌ false |
| `difference` | ❌ false | ❌ false | ✅ true | ❌ false |
| `union` | ❌ false | ❌ false | ✅ true | ❌ false |
| `spatial_join` | ❌ false | ❌ false | ✅ true | ❌ false |
| `select_by_location` | ❌ false | ❌ false | ✅ true | ❌ false |
| `centroid` | ❌ false | ❌ false | ✅ true | ❌ false |
| `simplify` | ❌ false | ❌ false | ✅ true | ❌ false |
| `merge_layers` | ❌ false | ❌ false | ✅ true | ❌ false |
| `calculate_field` | ❌ false | ❌ false | ✅ true | ❌ false |

## Rationale

- **readOnly=true** only for Tier 1 (inspection tools that don't create layers)
- **destructive=false** for all tools (no tool deletes or overwrites input)
- **idempotent=true** for all tools (same input → same output, no side effects)
- **openWorld=false** for all tools (no network access, no external APIs)

## Implementation

```python
@mcp.tool(annotations={
    "readOnlyHint": True,
    "destructiveHint": False,
    "idempotentHint": True,
    "openWorldHint": False,
})
def layer_info(request: LayerInfoInput) -> LayerInfoOutput:
    ...
```

## Related Files

- [KB-05-tool-spec-overview](tool-spec-overview.md) — Tool list
- [KB-15-mcp-official-docs](../15-external-references/mcp-official-docs.md) — Annotation spec
