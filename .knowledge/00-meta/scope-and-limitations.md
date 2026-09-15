---
id: KB-00-scope-and-limitations
title: "Scope and Limitations"
category: meta
subcategory: scope
tags: [scope, limitations, threats-to-validity, constraints]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [2, 3, 10, 15]
related:
  - KB-00-project-overview
  - KB-00-research-questions
  - KB-11-chapter-7-evaluation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Explicit boundaries of what the thesis does and does not claim"
  key_facts:
    - "5 explicit limitations documented"
    - "QGIS-only, no ArcGIS or other GIS platforms"
    - "Vector operations focus, limited raster"
    - "Static task suite, no user studies"
    - "MCP tool count ceiling at 15 (not 30 or 50)"
    - "1,800 runs total"
  common_questions:
    - "What is out of scope?"
    - "Why not test on ArcGIS?"
    - "Why not include user studies?"
    - "What are threats to validity?"
    - "Why only MCP-15 and not MCP-30?"
---

# Scope and Limitations

Explicit boundaries of the GeoAIWorkbench thesis. These are documented as threats to validity in Chapter VII (Evaluation).

## In Scope

### Environments
- QGIS 3.44.x (via conda-forge Pixi environment)
- Linux (Ubuntu 24.04 LTS) as primary platform
- Optional: macOS testing for cross-platform validation

### Agents
- 4 primary CLI agents: OpenCode, Claude Code, Codex CLI, Goose
- 2 backup agents: Gemini CLI, Cline CLI
- All treated as black boxes (no internal instrumentation)

### Paradigms
- **MCP-5** — 5 tools (Tier 1-2): `layer_info`, `layer_statistics`, `buffer`, `clip`, `reproject`
- **MCP-15** — 15 tools (Tier 1-5): adds `dissolve`, `intersection`, `difference`, `union`, `spatial_join`, `select_by_location`, `centroid`, `simplify`, `merge_layers`, `calculate_field`
- **CodeGen** — Direct PyQGIS code generation via subprocess execution

### Tasks
- 50 GeoAnalystBench tasks (Zhang et al., 2025) **adapted from ArcPy to QGIS**
- 5 adversarial tasks (ADV-01 to ADV-05) for security evaluation
- Total: 55 tasks stratified by difficulty (basic/intermediate/advanced/adversarial)

### Metrics
- 7 layers, ~28 metrics total (including tool count metrics)
- Statistical tests: McNemar, Mann-Whitney U, chi-square, one-way ANOVA, two-way ANOVA, paired t-test, Wilcoxon, bootstrap CIs

## Out of Scope

### Other GIS Platforms
- **ArcGIS** — proprietary, not reproducible
- **GRASS GIS** — different Processing framework
- **PostGIS** — no interactive layer concept
- **GeoServer** — server-side, different use case

Focus on QGIS ensures reproducibility and community accessibility.

### Non-CLI Agents
- **Web-based agents** (ChatGPT, Claude.ai) — not scriptable for 1,800 runs
- **IDE-embedded agents** (Cursor, Windsurf) — require IDE automation
- **Custom-built agents** — would defeat the "production agents as black boxes" design

### Advanced GIS Operations
- **Complex network analysis** (routing beyond basic buffer)
- **3D operations** (elevation modeling, volume calculations)
- **Time-series analysis** (space-time cubes)
- **Machine learning integration** (classification, regression)

The MCP-15 toolkit covers the most common geoprocessing patterns but does not exhaust GIS capabilities.

### Raster Operations
- Limited raster support in current tool suite (`layer_info` and `layer_statistics` accept rasters, but no raster-specific transformation tools in either MCP-5 or MCP-15)
- Full raster paradigm comparison deferred to future work

### Larger MCP Tiers
- **MCP-30 or MCP-50** — Would test degradation more strongly (Mo et al. 2025 suggests degradation kicks in around 50 tools)
- **Deferred because:** Timeline constraints and diminishing returns on tool selection
- **Future work:** If MCP-15 doesn't show expected degradation, extend to MCP-30

### User Studies
- **No human evaluators** in the loop
- **No usability studies** with GIS analysts
- **No qualitative interviews** with practitioners

The thesis focuses on machine-measurable outcomes. Human studies are future work.

### Multi-Agent Coordination
- **No A2A protocol evaluation** (deferred despite AAIF governance)
- **No planner-worker patterns** (though prior work uses them)
- **Single-agent-single-task** design only

Multi-agent extensions are natural future work but out of scope for the master's thesis timeline.

### Production Deployment
- **No security audit** of GeoMCP for production use
- **No performance optimization** for high-throughput scenarios
- **No multi-tenant support** in the plugin
- **No cloud deployment** (all local execution)

GeoMCP is a research artifact, not a production system. Design principles for production are noted but not implemented.

## Five Explicit Limitations (Chapter VII)

### Limitation 1: Snapshot in Time
The MCP ecosystem is evolving rapidly. Findings reflect the state of MCP SDK v2.2.0, FastMCP 4.0.3, and CLI agents as of September 2026. Breaking changes are documented (see [KB-CHANGELOG](../CHANGELOG.md)). Reproducibility is preserved via `pixi.lock`, but generalization to future MCP versions requires re-evaluation.

### Limitation 2: Task Suite Bias
GeoAnalystBench tasks (Zhang et al., 2025) reflect the authors' choices of what constitutes GIS work. Tasks are biased toward:
- Vector operations over raster
- English-language prompts
- Western data conventions (EPSG projections, imperial/metric distances)
- Analysis workflows over cartographic design
- **ArcPy conventions** — required adaptation to PyQGIS may introduce translation artifacts

Extension to other task suites (GeoAgentBench, ThinkGeo remote sensing tasks) is future work.

### Limitation 3: Agent Pool Constraints
Only 4 primary agents evaluated. Results may not generalize to:
- Non-CLI agents (web-based, IDE-embedded)
- Local-only agents (Ollama-only Goose configurations)
- Domain-fine-tuned models (GIS-specific LLMs, if they exist)
- Emerging agents released after September 2026

### Limitation 4: Black Box Constraint
By design, no agent internals are observed:
- Cannot analyze *why* an agent chose a particular tool
- Cannot measure agent reasoning steps directly
- Cannot detect prompt manipulation or context poisoning inside the agent

This is a deliberate methodological choice (see [KB-04-black-box-constraint](../04-architecture/black-box-constraint.md)) but limits mechanistic explanation.

### Limitation 5: Tool Count Ceiling
MCP-15 is the upper bound of tool count tested. This may not capture the full degradation curve:
- Mo et al. (2025) reports significant degradation around 50 tools
- MCP-15 may be too small to show strong degradation effects
- Results should be interpreted as "does the effect emerge at 15 tools?" not "what is the optimal tool count?"

### Limitation 6: Statistical Power (Updated)
1,800 runs is powerful for main effects but limited for:
- Three-way interactions (agent × paradigm × difficulty)
- Rare error type analysis (some error types may have n<10)
- Task-level generalization (50 tasks is small vs 500+ in industry benchmarks)
- Small differences between MCP-5 and MCP-15 (may require larger effect to detect)

Effect sizes are reported alongside p-values to mitigate this. Bootstrap CIs provide additional robustness.

## Threats to Validity (Detailed)

### Internal Validity

**Threat:** MCP server bugs could inflate MCP failure rate.
**Mitigation:** 202+ tests including 5 adversarial task tests. Paradigm boundary test runs on every commit. Pilot runs on 5 tasks before full experiment.

**Threat:** Reference outputs may be wrong (garbage in, garbage out).
**Mitigation:** Reference outputs generated by running the human-designed workflow from Zhang et al. (2025). Cross-validated by geometry validity checks.

**Threat:** Agent version drift during 1,800-run experiment.
**Mitigation:** Pin agent versions in `pixi.toml`. Record exact agent version in every JSONL event.

**Threat:** Tier switching bugs could contaminate MCP-5 vs MCP-15 comparison.
**Mitigation:** Dedicated test verifies `GEOMCP_TIER=5` exposes exactly 5 tools. Every JSONL event records the active tier.

### External Validity

**Threat:** Results specific to QGIS 3.44.
**Mitigation:** Pin QGIS version. Document via `pixi.lock`. Note this limitation explicitly.

**Threat:** Results specific to 4 chosen agents.
**Mitigation:** Include diverse agents (OpenAI, Anthropic, Google, open-source). Discuss why generalization to other agents is a research question.

**Threat:** MCP-15 tool selection may not generalize to other GIS toolkits.
**Mitigation:** Tools chosen from most common QGIS Processing algorithms. Document rationale for each tool.

### Construct Validity

**Threat:** Task Success Rate is binary and may miss nuanced quality.
**Mitigation:** PCS provides partial credit. OQS decomposes output quality into 5 sub-metrics.

**Threat:** PEA measurement may depend on how "required parameter" is defined.
**Mitigation:** Reference workflow from Zhang et al. defines required parameters. Documented per task in JSON.

**Threat:** Tool Selection Accuracy metric depends on ground-truth "correct" tool.
**Mitigation:** Reference workflows explicitly enumerate expected operations. Multiple valid solutions accepted.

### Conclusion Validity

**Threat:** Multiple comparison inflation across 7 RQs.
**Mitigation:** Bonferroni correction: α_adj = 0.05 / 6 = 0.0083 for primary RQs.

**Threat:** Effect sizes may be practically insignificant even if statistically significant.
**Mitigation:** Report Cliff's delta with interpretation (negligible/small/medium/large).

## What This Thesis Does NOT Claim

- MCP is universally better than code generation (or vice versa)
- Any specific agent is objectively "best" for GIS work
- Results generalize to all LLMs or all GIS platforms
- GeoMCP is production-ready without further hardening
- The MCP-15 toolkit is optimal or complete
- Security posture applies to all MCP servers (only GeoMCP evaluated)
- MCP-15 represents the optimal tool count for GIS

## What This Thesis DOES Claim

- Under specified experimental conditions, MCP-5, MCP-15, and CodeGen have measurable, reproducible differences
- These differences depend systematically on task difficulty, agent choice, and tool count
- Security considerations are non-trivial for MCP-based GIS servers, and increase with tool count
- The GeoMCP tiered architecture provides a template for future paradigm-clean MCP servers
- Practitioners can use the 3×4 decision framework to make informed paradigm choices
- Tool count is an experimental variable that meaningfully affects GIS agent performance
