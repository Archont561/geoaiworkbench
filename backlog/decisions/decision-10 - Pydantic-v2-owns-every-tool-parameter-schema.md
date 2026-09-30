---
id: decision-10
title: Pydantic v2 owns every tool parameter schema
date: '2026-09-30 21:42'
status: accepted
---
## Context

Tool parameters need validation, JSON-schema generation and type coercion. Dataclasses provide none of those, and FastMCP requires Pydantic for tool schemas anyway.

## Decision

Pydantic v2 only. `Annotated` types with `Field` constraints, `@field_validator` for cross-field checks, no dataclasses in the tool surface.

## Consequences

Validators such as `gt=0` on a buffer distance are not cosmetic: parameter validation coverage is a Layer 7 security metric, and it is 100% for MCP against 0% for CodeGen. That gap is a finding, so the validators must be real.

Supersedes `.knowledge/08-technology-decisions/pydantic-v2-choice.md` — deleted from the knowledge base; this decision is that content.
