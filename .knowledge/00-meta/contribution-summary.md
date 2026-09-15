---
id: KB-00-contribution-summary
title: "Project Contributions Summary"
category: meta
subcategory: contributions
tags: [contributions, empirical, artifact, methodological, practical]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [2, 8, 10, 15]
related:
  - KB-00-project-overview
  - KB-00-research-questions
  - KB-11-thesis-structure
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Four types of contributions this project makes to the field"
  key_facts:
    - "Empirical: first GIS-specific MCP-5 vs MCP-15 vs CodeGen comparison"
    - "Artifact: GeoMCP plugin with tiered tool exposure"
    - "Methodological: 7-layer metrics + security + tool count dimensions"
    - "Practical: 3×4 decision framework for practitioners"
  common_questions:
    - "What is the main contribution?"
    - "How is this different from GIS Copilot?"
    - "Why does GeoMCP matter beyond the thesis?"
    - "Why is the tool count experiment novel?"
---

# Project Contributions

GeoAIWorkbench makes four distinct types of contributions to the field of LLM-driven GIS automation.

## 1. Empirical Contribution

**First controlled comparison of MCP tool calling vs. code generation in a real GIS environment, WITH tool count as an experimental variable.**

- 1,800 experimental runs across 3 paradigms (MCP-5, MCP-15, CodeGen), 4 agents, 50 tasks, 3 repetitions
- Multi-dimensional evaluation: success rate, output quality, execution behavior, security, cost-performance, tool count effect
- Statistical rigor: bootstrap CIs, Cliff's delta effect sizes, Bonferroni correction
- Difficulty-stratified analysis reveals *when* each paradigm is superior
- **Tool count analysis:** First empirical GIS test of the inverted-U hypothesis from Mo et al. (2025)

**What this proves:**
- Whether MCP's schema-driven approach actually improves parameter correctness vs. free-form code
- How task difficulty moderates paradigm effectiveness
- Which agent-paradigm combinations are cost-effective in practice
- What error profiles distinguish the paradigms
- **Whether adding more MCP tools helps or hurts GIS task performance** (novel)

**Prior work that could NOT answer these questions:**
- Luo et al. (2026) — used only GeoJSON data, only GPT-4o, only one custom framework, no tool count variation
- GIS Copilot (Akinboyewa et al., 2025) — code generation only
- GISclaw (Han et al., 2026) — code generation only
- MCP-Bench (Wang et al., 2025) — no GIS domain
- LiveMCP-101 (Yin et al., 2025) — no GIS domain
- Mo et al. (2025) LiveMCPBench — general purpose, no domain-specific tool count study
- Song et al. (2025) — theoretical analysis, no GIS empirical validation

## 2. Artifact Contribution

**GeoMCP plugin — an open-source, paradigm-clean, tiered MCP server for QGIS.**

### What makes it different from existing MCP servers for QGIS

| Aspect | Existing (qgis-mcp v0.3.1) | GeoMCP (this thesis) |
|---|---|---|
| Tool count | 118 (flat) | 5 (Tier 1-2) or 15 (Tier 1-5) — tiered |
| `execute_code` | ✅ Exposed | ❌ Forbidden (asserted at import) |
| Purpose | General-purpose automation | Controlled paradigm evaluation |
| Architecture | FastMCP + TCP socket | FastMCP 4.0.3 + TCP bridge |
| Input validation | Minimal | Pydantic v2 with validators (distance>0, EPSG regex, expression sanitization) |
| Output sanitization | Raw results | Structured JSON, truncated attributes |
| Documentation | README | Full behavioral contracts per tool |
| MCP annotations | Some | Complete (readOnlyHint, destructiveHint, idempotentHint) |
| Server instructions | None | Cross-tool workflow guidance |
| Adversarial testing | No | ADV-01 to ADV-05 |
| Tier control | N/A | `GEOMCP_TIER=5` or `GEOMCP_TIER=15` env var |

### Reusability

GeoMCP is designed as a template for other domain-specific MCP servers:

- **Tiered tool exposure pattern** — enables capability/determinism tradeoff without code duplication
- Paradigm boundary pattern (assertion at decoration time + dedicated test)
- Pydantic validator patterns for spatial parameters and expression injection
- TCP bridge pattern for embedding in existing applications
- Structured error taxonomy for evaluation

### Release plan

- MIT license
- Published to QGIS Plugin Repository (with tier documentation)
- Published to PyPI as `geoaiworkbench`
- Zenodo archive with DOI for citation
- GitHub repository with CI/CD via GitHub Actions + setup-pixi

## 3. Methodological Contribution

**Extended metrics framework with security AND tool count as first-class dimensions.**

### 7-Layer Metrics Framework

Extends prior geospatial benchmarks:

- **Layer 1:** Task Success (Pass@1, Pass@3, TSR, Completion Rate, RR)
- **Layer 2:** Workflow Process (Step Count, PEA, Tool Selection, Workflow Validity, **Tool Selection Degradation**)
- **Layer 3:** Output Quality (vector, raster, map metrics)
- **Layer 4:** Execution Behavior (ED, Error Rate, ITS, tokens, time, **Context Window Utilization**)
- **Layer 5:** Complex Task (PCS, SCR, LCP, SHR, Recovery)
- **Layer 6:** Composite Scores (weighted, difficulty-adjusted, cost-performance)
- **Layer 7:** Security (attack surface, injection resistance, validation coverage)

**New in 2026-09-11:** Layer 2 and Layer 4 now include tool-count-specific metrics.

### New Metrics Introduced

- **PEA** (Parameter Execution Accuracy) — adapted from Yu et al. (2026) for MCP tools
- **SHR** (Self-Healing Ratio) — adapted from Mansourian & Oucheikh (2026)
- **ITS** (Iterations to Success) — for retry behavior analysis
- **RR** (Rejection Rate) — from Krechetova & Kochedykov (2025)
- **Prompt Injection Resistance** — new, based on Hou et al. (TOSEM) taxonomy
- **Tool Selection Degradation Rate** — NEW, measures degradation from MCP-5 to MCP-15
- **Context Window Utilization** — NEW, measures schema loading overhead

### Statistical Rigor Upgrade

Beyond simple p-values:
- Bootstrap 95% CIs on all primary metrics
- Cliff's delta effect sizes (nonparametric)
- Bonferroni correction for multiple RQ testing (α_adj = 0.0083)
- Paired Wilcoxon tests for within-agent comparisons
- Paired t-tests for MCP-5 vs MCP-15 within-task comparisons (PB7)
- Following GISclaw (Han et al., 2026) precedent of 1,800 controlled experiments

## 4. Practical Contribution

**3×4 decision framework for practitioners choosing MCP-5, MCP-15, or CodeGen for GIS automation.**

### Decision Matrix (Output of PB1-PB4, PB7)

Practitioners will get a decision matrix like:

| If your task is... | And your agent is... | Choose... |
|---|---|---|
| Simple, structured, single-operation | Any | MCP-5 |
| Simple with common variations | Any | MCP-15 |
| Complex multi-step spatial analysis | Any | MCP-15 or CodeGen |
| Complex, open-ended, creative spatial reasoning | Claude Code | CodeGen |
| Requires exact reproducibility | Any | MCP-5 |
| High refusal cost | Goose (BYOM) | CodeGen |
| Security-critical | Any | MCP-5 (smallest attack surface) |
| Cost-sensitive | Codex | MCP-5 (lowest token overhead) |

### Design Principles for GIS MCP Servers (P1-P8)

Concrete guidance for building future GIS MCP servers:

- P1: No code execution tools
- P2: Structured Pydantic input/output only
- P3: Read-only by default
- P4: Explicit output layer naming
- P5: Behavioral contracts documented per tool
- P6: MCP annotations for hints
- P7: Server instructions for cross-tool guidance
- P8: **Tiered tool exposure** — provide small (5-10) and expanded (15-25) tiers, allow runtime selection

### Reproducibility Package

- Complete `pixi.lock` for full-stack reproduction
- All 50 GeoAnalystBench task JSON files (adapted for QGIS)
- All 5 adversarial task files
- Reference outputs for verification
- Raw JSONL trajectories from all 1,800 runs
- Analysis scripts (Polars + DuckDB queries)
- Zenodo archive with DOI

## Publication Strategy

- **Primary output:** Master's thesis (Polish, WIT PWr format with wnozigp.sty)
- **Secondary output:** IMRaD article draft (Polish + English) — potential submission to:
  - *International Journal of Digital Earth* (IJDE)
  - *Transactions in GIS* (TGIS)
  - *Big Earth Data*
  - AGILE/FOSS4G conference proceedings
- **Artifact release:** GitHub + Zenodo + QGIS Plugin Repository + PyPI
- **Community outreach:** QGIS user community, MCP community (modelcontextprotocol.io/discord)

## Impact Assessment

**Short term (1-6 months):**
- Thesis defense at WIT PWr
- Open-source release enables community adoption
- Reference implementation for tiered GIS MCP servers

**Medium term (6-18 months):**
- Potential journal publication
- Adoption by GIS practitioners for automated workflows
- Extension by other researchers to raster analysis, remote sensing
- Tool count principles applied to other domain-specific MCP servers

**Long term (18+ months):**
- Contribution to MCP + GIS ecosystem convergence
- Design principles inform other domain-specific MCP servers
- Basis for further research on protocol-level agent evaluation
- Tiered MCP pattern adopted as best practice
