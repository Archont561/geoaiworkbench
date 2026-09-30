---
id: decision-14
title: 'Commodity infrastructure comes from mature libraries, not custom modules'
date: '2026-09-30 21:42'
status: accepted
---
## Context

Whether to hand-write caching, retry, structured logging, file locking and path resolution, as originally planned.

## Decision

Use mature libraries for commodity infrastructure — diskcache, tenacity, structlog, filelock, platformdirs — and keep custom code for the novel GIS, MCP and benchmark logic only.

## Consequences

Ten infrastructure dependencies enter the manifest, each of which must be declared and locked here. The rule that follows: if a package exists and is maintained, a hand-rolled version of it is not a contribution.

Source: `.knowledge/14-decisions-log/decision-infrastructure-libs.md`, `.knowledge/07-tooling/infrastructure-libraries.md`.
