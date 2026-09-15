---
id: KB-15-pixi-docs
title: "Pixi Package Manager Documentation"
category: external-references
subcategory: package-manager
tags: [pixi, conda, package-manager, environment, urls]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [7]
related:
  - KB-08-pixi-vs-uv
  - KB-07-pixi-guide
  - KB-06-pyproject-toml
authoritative: false
implementation_status: specified
llm_hints:
  primary_purpose: "Pixi documentation URLs and key concepts"
  key_facts:
    - "Pixi 0.80.0 is current stable"
    - "Rust-based, uses rattler solver + uv internally"
    - "Handles Conda + PyPI in one lockfile"
    - "GitHub Actions: setup-pixi@v0.10.0"
    - "Task feature enables tier-based server invocation"
  common_questions:
    - "Where is Pixi documented?"
    - "How do I install Pixi?"
    - "What is the current version?"
    - "How do I use Pixi in CI?"
    - "How do I define MCP-5 vs MCP-15 tasks?"
---

# Pixi Documentation

Pixi is the package manager and task runner for GeoAIWorkbench, chosen because it handles both Conda packages (QGIS, GDAL, GEOS, PROJ) and PyPI packages in a single lockfile.

## Current Version

- **Version:** 0.80.0 (September 7, 2026)
- **conda-forge:** `conda install -c conda-forge pixi`
- **Language:** Rust
- **License:** BSD-3-Clause

## Main Documentation

### Official Site
- **Docs:** https://pixi.sh/
- **GitHub:** https://github.com/prefix-dev/pixi

### Installation
- **Guide:** https://pixi.sh/latest/installation/
- **Install script (Linux/macOS):** `curl -fsSL https://pixi.sh/install.sh | bash`
- **Windows:** PowerShell script from docs

## Key Concepts

### Project Structure

```
project/
├── pixi.toml        # Or [tool.pixi.*] in pyproject.toml
├── pixi.lock        # Committed to Git
└── .pixi/           # Local environment (gitignored)
```

### Manifest File

Pixi configuration can live in:

- **`pixi.toml`** — Dedicated Pixi manifest
- **`pyproject.toml`** — Under `[tool.pixi.*]` sections (used by GeoAIWorkbench)

### Basic Manifest

```toml
[tool.pixi.project]
name = "geoaiworkbench"
channels = ["conda-forge"]
platforms = ["linux-64"]

[tool.pixi.dependencies]
python = "3.12.*"
qgis = ">=3.40"

[tool.pixi.pypi-dependencies]
fastmcp = ">=4,<5"
```

### Two-Stage Resolution

1. Pixi solves Conda dependencies via `rattler`
2. Pixi solves PyPI dependencies via internal `uv` given the Conda-solved Python

**Best practice:** Prefer Conda packages when available (e.g., `shapely`, `rasterio`, `geopandas` are all on conda-forge). See [KB-08-pixi-vs-uv](../08-technology-decisions/pixi-vs-uv.md).

## Commands

### Environment Management

```bash
pixi install                # Install/update environment from manifest
pixi install --locked       # Install exactly from pixi.lock
pixi install --frozen       # Fail if lock is out of date
```

### Adding Packages

```bash
pixi add python=3.12         # Add Conda package
pixi add --pypi fastmcp      # Add PyPI package
pixi add --feature test pytest  # Add to specific feature
```

### Running Commands

```bash
pixi run test                # Run task defined in [tool.pixi.tasks]
pixi run -e benchmark test   # Run in specific environment
pixi run python script.py    # Run arbitrary command in environment
```

### Shell

```bash
pixi shell                   # Activate environment shell
pixi shell -e dev            # Specific environment
```

### Info

```bash
pixi info                    # Show project info
pixi list                    # List installed packages
pixi tree                    # Dependency tree
```

## Features and Environments

**Features** are named sets of dependencies. **Environments** are compositions of features.

```toml
[tool.pixi.feature.test.dependencies]
pytest = ">=8.0"

[tool.pixi.feature.benchmark.pypi-dependencies]
mlflow = ">=2.16"

[tool.pixi.environments]
default = { features = [] }
test = { features = ["test"] }
benchmark = { features = ["test", "benchmark"] }
dev = { features = ["test", "benchmark", "dev"] }
```

Then:
```bash
pixi run -e benchmark benchmark-run
pixi run -e test pytest
pixi run -e dev ruff check
```

## Tasks (Including Tier Control)

```toml
[tool.pixi.tasks]
test = "pytest tests/ -v"
lint = "ruff check src/ tests/"

# Standard MCP server (default tier)
mcp-server = "python scripts/start_mcp_server.py"

# MCP-5 specific
mcp-server-5 = { cmd = "python scripts/start_mcp_server.py", env = { GEOMCP_TIER = "5" } }

# MCP-15 specific
mcp-server-15 = { cmd = "python scripts/start_mcp_server.py", env = { GEOMCP_TIER = "15" } }

# Benchmark tasks
benchmark-mcp5 = { cmd = "python benchmark.py run --condition mcp5", env = { GEOMCP_TIER = "5" } }
benchmark-mcp15 = { cmd = "python benchmark.py run --condition mcp15", env = { GEOMCP_TIER = "15" } }
benchmark-codegen = "python benchmark.py run --condition codegen"
benchmark-all = { cmd = "python benchmark.py run --condition all", depends-on = ["test"] }

# Analysis
benchmark-analyse = "python benchmark.py analyse"
benchmark-status = "python benchmark.py status"
```

Run:
```bash
pixi run mcp-server-5     # Start MCP-5 server
pixi run mcp-server-15    # Start MCP-15 server
pixi run benchmark-all    # Run full 1,800-run experiment
```

## Lockfile

`pixi.lock` captures the exact resolved environment across all platforms:

- Conda package hashes
- PyPI package hashes
- All transitive dependencies
- Platform-specific variations

**Best practice:** Commit `pixi.lock` to Git for reproducibility.

## CI/CD

### GitHub Actions

- **Action:** `prefix-dev/setup-pixi@v0.10.0`
- **Docs:** https://github.com/prefix-dev/setup-pixi

```yaml
- uses: prefix-dev/setup-pixi@v0.10.0
  with:
    pixi-version: v0.80.0
    locked: true
    environments: test

- run: pixi run -e test test
```

### Options
- `locked: true` — Require pixi.lock to be up to date
- `frozen: true` — Never update pixi.lock
- `environments: <name>` — Only install specific environments
- `cache: true` — Cache the .pixi/ directory (default: true)

## Docker Integration

```dockerfile
FROM ghcr.io/prefix-dev/pixi:latest

COPY pyproject.toml pixi.lock ./
RUN pixi install --locked

COPY . .
CMD ["pixi", "run", "-e", "benchmark", "benchmark-all"]
```

## pixi-pack (Portable Environments)

- **GitHub:** https://github.com/Quantco/pixi-pack
- **Purpose:** Package Pixi environment into portable archive

```bash
pixi pack --environment benchmark --platform linux-64
```

Useful for distributing pre-built benchmark environments.

## Comparison with Alternatives

| Feature | Pixi | uv | conda | poetry |
|---|---|---|---|---|
| Conda packages | ✅ | ❌ | ✅ | ❌ |
| PyPI packages | ✅ | ✅ | ⚠️ (via pip) | ✅ |
| Native geospatial (QGIS/GDAL) | ✅ | ❌ | ✅ | ❌ |
| Lockfile | ✅ | ✅ | ⚠️ (via extras) | ✅ |
| Tasks | ✅ | ❌ | ❌ | ⚠️ (via scripts) |
| Speed | ✅ (Rust) | ✅ (Rust) | ❌ (Python) | ⚠️ |
| Multi-environment | ✅ | ⚠️ | ⚠️ | ⚠️ |
| Python-only projects | ⚠️ (overkill) | ✅ | ⚠️ | ✅ |
| Native + Python | ✅ (best fit) | ❌ | ✅ | ❌ |
| Task env vars (for GEOMCP_TIER) | ✅ | ❌ | ❌ | ⚠️ |

For GeoAIWorkbench (native + Python + tier control), Pixi is the clear winner. See [KB-08-pixi-vs-uv](../08-technology-decisions/pixi-vs-uv.md).

## Common Issues

### First Install is Slow

- 5-10 minutes on first `pixi install` due to Conda solver + downloads
- Subsequent runs are instant (cached)

### Lockfile Size

- `pixi.lock` can be 500KB-2MB
- Commit anyway — reproducibility > repo size

### conda-forge Version Lag

- conda-forge may lag behind latest upstream (e.g., QGIS)
- Use flexible constraints: `qgis = ">=3.40"` not `qgis = "3.44.14"`

### PyPI vs Conda Priority

- Pixi resolves Conda first, then PyPI
- If a package exists in both, prefer Conda (`[dependencies]`)
- Only use `[pypi-dependencies]` for packages not on conda-forge

## Related Documentation

- **GeoAIWorkbench pyproject.toml:** [KB-06-pyproject-toml](../06-implementation/pyproject-toml.md)
- **Pixi guide for this project:** [KB-07-pixi-guide](../07-tooling/pixi-guide.md)
- **Rationale (Pixi vs uv):** [KB-08-pixi-vs-uv](../08-technology-decisions/pixi-vs-uv.md)

## Community

- **Discord:** Link on pixi.sh
- **GitHub Discussions:** https://github.com/prefix-dev/pixi/discussions
- **Issue tracker:** https://github.com/prefix-dev/pixi/issues
