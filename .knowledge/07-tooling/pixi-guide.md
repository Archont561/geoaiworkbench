---
id: KB-07-pixi-guide
title: "Pixi Usage Guide for GeoAIWorkbench"
category: tooling
subcategory: pixi
tags: [pixi, guide, conda, pypi, environments, tasks]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-15-pixi-docs
  - KB-08-pixi-vs-uv
  - KB-06-pyproject-toml
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Practical Pixi guide for this project"
  key_facts:
    - "Install: curl -fsSL https://pixi.sh/install.sh | bash"
    - "First install: 5-10 min (Conda solver)"
    - "4 environments: default, test, benchmark, dev"
    - "pixi.lock committed to Git"
    - "GEOMCP_TIER passed via task env vars"
  common_questions:
    - "How do I install Pixi?"
    - "How do I run tests?"
    - "How do I switch environments?"
---

# Pixi Usage Guide for GeoAIWorkbench

## Installation

```bash
curl -fsSL https://pixi.sh/install.sh | bash
pixi --version  # Should show 0.80.0
```

## First-Time Setup

```bash
git clone https://github.com/yourname/GeoAIWorkbench.git
cd GeoAIWorkbench
pixi install          # 5-10 min first time, instant after
pixi run test         # Verify all 182+ tests pass
```

## Daily Workflow

```bash
pixi run -e dev lint          # Check code style
pixi run -e dev format        # Auto-format
pixi run -e dev typecheck     # Type checking
pixi run -e test test         # Run tests
pixi run -e test test-parallel  # Fast parallel tests
```

## Benchmark Execution

```bash
pixi run mcp-server-5         # Start MCP-5 server
pixi run mcp-server-15        # Start MCP-15 server
pixi run benchmark-all        # Full 1,800-run experiment
pixi run benchmark-mcp5       # MCP-5 condition only
pixi run benchmark-codegen    # CodeGen condition only
pixi run benchmark-analyse    # Compute metrics from JSONL
pixi run benchmark-status     # Check progress
```

## Adding Dependencies

```bash
pixi add qgis                     # Conda package
pixi add --pypi fastmcp           # PyPI package
pixi add --feature test pytest    # Feature-specific
```

## Environment Switching

```bash
pixi shell -e dev                 # Activate dev environment
pixi shell -e benchmark           # Activate benchmark environment
exit                              # Deactivate
```

## CI/CD

```yaml
- uses: prefix-dev/setup-pixi@v0.10.0
  with:
    locked: true
    environments: test
- run: pixi run -e test test
```

## Troubleshooting

| Problem | Solution |
|---|---|
| First install slow | Normal — Conda solver downloads QGIS + deps |
| Lock file conflict | `pixi install` to re-resolve |
| QGIS not found | Check `pixi list \| grep qgis` |
| PyPI package fails | Prefer Conda: `pixi add shapely` not `--pypi` |

## Related Files

- [KB-15-pixi-docs](../15-external-references/pixi-docs.md)
- [KB-08-pixi-vs-uv](../08-technology-decisions/pixi-vs-uv.md)
- [KB-06-pyproject-toml](../06-implementation/pyproject-toml.md)
