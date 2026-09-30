---
id: KB-00-glossary-terms
title: "Detailed Glossary Terms with Context"
category: meta
subcategory: reference
tags: [glossary, terminology, detailed, mcp, acp, a2a, mcp-5, mcp-15]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [1, 2, 3, 8, 15]
related:
  - KB-GLOSSARY
  - KB-04-protocol-stack
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Extended definitions with context, examples, and cross-references"
  key_facts:
    - "Complements the quick-reference GLOSSARY.md"
    - "Includes protocol distinction: MCP vs ACP vs A2A"
    - "Explains metric acronyms with formulas"
    - "MCP-5 vs MCP-15 tier distinctions"
  common_questions:
    - "What is the difference between MCP, ACP, and A2A in detail?"
    - "How is PEA calculated?"
    - "What is a paradigm boundary?"
    - "How does tier control work?"
---

# Detailed Glossary Terms

Extended definitions with context, formulas, examples, and cross-references. Complements the quick-reference [GLOSSARY.md](../GLOSSARY.md).

## Protocol Stack Distinction

### MCP — Model Context Protocol

**Definition:** JSON-RPC 2.0 based open standard from Anthropic for connecting LLM agents to external tools and context resources.

**Scope:** Agent → Tools

**Direction:** Vertical (agent uses tools)

**Transport:** stdio (local), Streamable HTTP (remote), SSE (deprecated)

**Governance:** Anthropic + community (modelcontextprotocol.io)

**Current SDK:** Python `mcp` v2.2.0 or standalone `fastmcp` v4.0.3

**Example use case:** LLM agent calling `buffer` tool exposed by GeoMCP

**In GeoAIWorkbench:** The primary integration mechanism for MCP-5 and MCP-15 conditions

**Reference:** [KB-15-mcp-official-docs](../15-external-references/mcp-official-docs.md)

### ACP — Agent Client Protocol

**Definition:** JSON-RPC over stdio protocol for editor ↔ coding-agent communication.

**Scope:** Editor → Agent

**Direction:** Vertical (editor drives agent)

**Transport:** stdio only

**Governance:** OpenCode, Zed, community

**Current implementation:** `opencode acp` command

**Example use case:** VS Code launching Cline agent to receive tasks and stream responses

**NOT the same as A2A.** This is the most common confusion. See distinction table below.

**In GeoAIWorkbench:** Used to invoke OpenCode as a headless subprocess for benchmark automation

### A2A — Agent-to-Agent Protocol

**Definition:** Horizontal communication protocol between autonomous agents.

**Scope:** Agent ↔ Agent

**Direction:** Horizontal (peer-to-peer)

**Transport:** HTTP-based, evolving

**Governance:** AAIF (Agent-to-Agent Interoperability Foundation) post-August 2025 merger

**Current SDK:** `a2a-sdk` on PyPI (v1.0-compatible)

**Example use case:** Planner agent delegating subtask to specialized executor agent

**In GeoAIWorkbench:** Deferred to future work. Not used in current thesis.

### Distinction Table

| Aspect | MCP | ACP | A2A |
|---|---|---|---|
| Scope | Agent → Tools | Editor → Agent | Agent ↔ Agent |
| Direction | Vertical | Vertical | Horizontal |
| Transport | stdio/HTTP/SSE | stdio | HTTP |
| Governance | Anthropic + community | OpenCode/Zed | AAIF |
| GeoAIWorkbench use | Primary (MCP-5, MCP-15) | Automation only | Not used |

## Tier System Concepts

### Tier 1: Inspection

**Purpose:** Read-only layer metadata queries. Always available in both MCP-5 and MCP-15.

**Tools:** `layer_info`, `layer_statistics`

**Characteristics:**
- All tools have `readOnlyHint=true`
- No layer modifications
- Fast execution (metadata only)
- Should be called first when layer identity unknown

### Tier 2: Core Geoprocessing

**Purpose:** The three most fundamental GIS transformations. Always available in both MCP-5 and MCP-15.

**Tools:** `buffer`, `clip`, `reproject`

**Characteristics:**
- Create new output layers (never modify inputs)
- Cover most basic GeoAnalystBench tasks
- `readOnlyHint=false`, `idempotentHint=true`

### Tier 3: Extended Geoprocessing

**Purpose:** Advanced overlay and spatial join operations. Only available in MCP-15.

**Tools:** `dissolve`, `intersection`, `difference`, `union`, `spatial_join`, `select_by_location`

**Characteristics:**
- Enable complex multi-step workflows
- Required for ~40% of GeoAnalystBench advanced tasks
- Introduce workflow ordering considerations

### Tier 4: Geometry Operations

**Purpose:** Geometry transformations that preserve or modify shape. Only available in MCP-15.

**Tools:** `centroid`, `simplify`

**Characteristics:**
- Both output vector layers
- `simplify` requires validation (tolerance > 0)

### Tier 5: Data Management

**Purpose:** Multi-layer and attribute manipulation. Only available in MCP-15.

**Tools:** `merge_layers`, `calculate_field`

**Characteristics:**
- `merge_layers` requires min 2 input layers
- `calculate_field` introduces **expression injection risk** — requires special validation
- Higher security surface than other tiers

### GEOMCP_TIER Environment Variable

**Values:**
- `GEOMCP_TIER=5` — Exposes Tier 1-2 only (5 tools total). MCP-5 condition.
- `GEOMCP_TIER=15` — Exposes Tier 1-5 (15 tools total). MCP-15 condition.

**Implementation:** Read at server startup. Tools not in target tier are removed from FastMCP tool manager during `_enforce_tier()` call.

**Enforcement:** `assert` statement runs after registration to verify:
1. No forbidden tools (`execute_code`, `shell`, etc.) are exposed
2. Tier boundary is respected

**Recording:** Every JSONL trajectory event includes `tier` field.

## Metric Definitions with Formulas

### TSR — Task Success Rate

```
TSR = (passed_tasks) / (total_tasks)
```

Range: [0, 1]

For single-attempt evaluation, TSR = Pass@1.

For repeated-attempt evaluation:
```
TSR_binary = 1 if any attempt passes else 0
```

### Pass@1 / Pass@3

```
Pass@1 = fraction of tasks passed on first attempt
Pass@3 = fraction of tasks passed in at least one of three attempts
```

Reveals both raw capability (Pass@1) and self-healing (gap between Pass@1 and Pass@3).

### PEA — Parameter Execution Accuracy

Adapted from Yu et al. (2026):

```
PEA = (correctly_inferred_params) / (total_required_params)
```

Per tool call. Aggregated per task as mean across all tool calls.

**Example (MCP-5):**
```
Task: "Buffer roads by 500m"
Required params for buffer tool: input_layer, distance, output_layer

Agent provides: {input_layer: "roads", distance: 500, output_layer: "roads_buf"}
PEA = 3/3 = 1.0

Agent provides: {input_layer: "roads", distance: -500, output_layer: "roads_buf"}
PEA = 2/3 = 0.67 (distance invalid — Pydantic rejects gt=0)
```

**Example (MCP-15 with spatial_join):**
```
Task: "Join population data from districts to cities"
Required params: input_layer, join_layer, predicate, output_layer

Agent provides: {input_layer: "cities", join_layer: "districts", predicate: "within", output_layer: "cities_pop"}
PEA = 4/4 = 1.0
```

### SHR — Self-Healing Ratio

Adapted from Mansourian & Oucheikh (2026):

```
SHR = |{tasks failed on attempt 1 AND passed on attempt 2 or 3}| / |{tasks failed on attempt 1}|
```

Measures ability to recover from initial failure.

### ITS — Iterations to Success

```
ITS = min({attempt_number : task passed on attempt_number}) or ∞
```

Report as median and IQR per paradigm × difficulty cell.

### RR — Rejection Rate

From Krechetova & Kochedykov (2025):

```
RR = |{tasks where agent refused or declared unsolvable}| / |total_tasks|
```

Detected via pattern matching in agent output: "I cannot", "not possible", "unsolvable", etc.

### PCS — Partial Credit Score

Weighted step completion:

```
PCS = Σ(step_completed × step_weight) / Σ(step_weight)
```

Where step weights are:
- data_loading = 1.0
- data_preparation = 1.5
- spatial_analysis = 3.0
- spatial_reasoning = 4.0
- output = 2.0

### OQS — Output Quality Score

Composite of 5 sub-metrics:

```
OQS = (geometry_valid + feature_count_match + crs_match + extent_iou + attribute_preserved) / 5
```

Each sub-metric ∈ [0, 1].

For vector outputs:
- geometry_valid: Shapely `is_valid` on all features
- feature_count_match: 1 if reference count matches ±5%, else 0
- crs_match: 1 if CRS EPSG matches, else 0
- extent_iou: Intersection over Union of bounding boxes
- attribute_preserved: 1 if all required fields present, else 0

### LCP — Longest Correct Prefix

```
LCP = max{n : first n steps of workflow are all correct}
```

Measures how far the agent got before making the first error.

### ED — Execution Determinism

```
ED = 1 if all 3 repetitions produced identical output else 0
```

Or, more granular:
```
ED = mean(pairwise_output_similarity across 3 runs)
```

### Tool Selection Accuracy (NEW)

Measures if agent chose the correct tool for the operation:

```
TSA = (correct_tool_selections) / (total_tool_selections)
```

Ground truth from reference workflow. Only applies to MCP conditions.

### Tool Selection Degradation Rate (NEW)

Measures how much accuracy drops from MCP-5 to MCP-15:

```
TSDR = (TSA_MCP5 - TSA_MCP15) / TSA_MCP5
```

Higher values indicate stronger degradation effect (as predicted by Mo et al. 2025).

### Context Window Utilization (NEW)

Approximate tokens consumed by MCP tool schemas:

```
CWU = tokens(all_tool_schemas + server_instructions) / model_context_window
```

MCP-15 has ~3× higher CWU than MCP-5.

## System Concepts

### Paradigm Boundary

**Definition:** Hard invariant that MCP conditions expose only Tier 1-5 tools and forbid code execution at any tier.

**Enforcement mechanism (two layers):**

1. **Assertion at import time:**
```python
FORBIDDEN_TOOLS = {"execute_code", "run_python", "shell", ...}
registered = {t.name for t in mcp._tool_manager._tools.values()}
assert not (registered & FORBIDDEN_TOOLS)
```

2. **Dedicated test in test suite:**
```python
def test_no_execute_code_tool_exposed():
    """Most critical test in the suite."""
    from geoaiworkbench.geo_mcp import mcp
    tools = {t.name for t in mcp._tool_manager._tools.values()}
    forbidden = tools & FORBIDDEN_TOOLS
    assert not forbidden

def test_mcp5_has_exactly_5_tools():
    """GEOMCP_TIER=5 must expose exactly Tier 1-2."""
    import os
    os.environ["GEOMCP_TIER"] = "5"
    # Reimport and check
    assert len(registered_tools) == 5

def test_mcp15_has_exactly_15_tools():
    """GEOMCP_TIER=15 must expose Tier 1-5."""
    import os
    os.environ["GEOMCP_TIER"] = "15"
    # Reimport and check
    assert len(registered_tools) == 15
```

Runs on every commit via GitHub Actions.

### Black Box Constraint

**Definition:** Agents are treated as opaque units. Only two observation points exist:

1. **MCP server logs** (MCP-5 and MCP-15 conditions) — captures every tool call
2. **GIS output files** (all three conditions) — captures final spatial artifacts

For CodeGen additionally:
3. **Generated code files** — captures scripts written by agent
4. **Runtime traces** — via `processing.run()` monkeypatching

**No observation of:**
- Agent internal reasoning
- LLM prompts sent by agent
- LLM responses received by agent
- Agent decision-making steps

**Rationale:**
- Fair comparison across agents with different architectures
- Reproducible (any agent can be swapped in)
- No vendor lock-in to specific agent internals
- Matches real-world deployment where users don't see internals

### Hook Injection Pattern

**Definition:** Pattern for injecting benchmark monitors into MCP server and ACP client without hard coupling.

**Implementation:**
```python
# geoaiworkbench defines Protocol
class MonitorHook(Protocol):
    def wrap(self, tool_name: str, params: dict, result: dict, duration_ms: float): ...

# geoaiworkbench exposes hook injection
class GeoMCP:
    def set_hook(self, hook: MonitorHook): ...
    def clear_hook(self): ...

# geoaibenchmark provides concrete implementation
class MCPMonitor:  # Satisfies MonitorHook structurally
    def wrap(self, tool_name, params, result, duration_ms):
        # Log event...
```

Benefits:
- `geoaiworkbench` has no compile-time dependency on `geoaibenchmark`
- Fresh monitor per task run (no state leakage)
- Easy to swap monitor implementations
- Testable in isolation

### TCP Bridge

**Definition:** Localhost socket connection between the standalone MCP server process and the QGIS plugin.

**Why not embed MCP server in QGIS?**
- asyncio event loop (needed by FastMCP) conflicts with Qt event loop (owned by QGIS)
- QThread workarounds are fragile
- Existing qgis-mcp uses same separate-process pattern

**Protocol:**
```
MCP server (Python) → JSON request over TCP → QGIS bridge (Python plugin)
QGIS bridge → PyQGIS execution on main thread → JSON response over TCP → MCP server
```

**Port:** localhost:9876 (configurable)

**Trust boundary:** Both processes are trusted (same user, same machine). No auth needed for stdio; localhost socket has OS-level access control.

## Data Structures

### MonitorEvent

Unified Pydantic schema for benchmark trajectory events:

```python
class MonitorEvent(BaseModel):
    event_type: Literal["mcp_tool_call", "acp_request", "code_execution"]
    timestamp_iso: str
    session_id: str
    task_id: str
    attempt_number: int
    agent_name: str
    paradigm: Literal["mcp5", "mcp15", "codegen"]  # UPDATED for 3 conditions
    tier: int  # NEW: 5 or 15 for MCP conditions, 0 for CodeGen
    tool_or_endpoint: str
    params: dict
    result: dict | None
    success: bool
    error_type: str | None
    error_message: str | None
    duration_ms: float
```

Serialized as JSONL (one event per line) for crash-safe persistence.

### BenchmarkTask

Pydantic schema for task definitions:

```python
class BenchmarkTask(BaseModel):
    task_id: str
    prompt: str
    difficulty: Literal["basic", "intermediate", "advanced", "adversarial"]
    required_layers: list[str]
    expected_operations: list[str]
    required_tools: set[str]  # NEW: which MCP tools needed
    minimum_tier: int  # NEW: 2 for basic (MCP-5 suffices), 3-5 for advanced (needs MCP-15)
    reference_output_path: str
    verification_config: VerificationConfig
    max_attempts: int = 3
    timeout_seconds: int = 300
```

Stored as JSON files in `tasks/{difficulty}/{task_id}.json`.

## Verification Terminology

### Reference Output

**Definition:** Ground-truth spatial artifact produced by executing the human-designed workflow from GeoAnalystBench.

**Format:** Shapefile (vector) or GeoTIFF (raster) stored in `data/reference_outputs/{task_id}/`.

**Generation:** Pre-computed once via `scripts/generate_reference_outputs.py` using PyQGIS.

**Verification:** OutputVerifier compares agent output against reference using geometry equality, CRS match, attribute preservation.

### OutputVerifier

**Definition:** Independent process (not part of agent) that runs after agent completion to compute OQS.

**Independence requirement:** Must run in separate process after agent exits. This prevents "benchmark hijacking" where agent could tamper with verifier if in same process (see SWE-bench contamination warnings).

**Implementation:** Uses Shapely, GeoPandas, rasterio, pyproj, scikit-image.

## Statistical Terms

### Bootstrap 95% CI

Non-parametric confidence interval via resampling:

```python
from scipy.stats import bootstrap
result = bootstrap(data, statistic=np.mean, n_resamples=10000, confidence_level=0.95)
ci_low, ci_high = result.confidence_interval
```

Preferred over normal-theory CIs for small samples and non-Gaussian metrics.

### Cliff's Delta

Non-parametric effect size for two groups:

```
δ = (P(x > y) - P(x < y))
```

Where x is from group 1, y from group 2. Range: [-1, +1].

Interpretation:
- |δ| < 0.147 → negligible
- 0.147 ≤ |δ| < 0.33 → small
- 0.33 ≤ |δ| < 0.474 → medium
- |δ| ≥ 0.474 → large

### Bonferroni Correction

Adjustment for multiple hypothesis testing:

```
α_adjusted = α_original / n_comparisons
```

For GeoAIWorkbench: α_adj = 0.05 / 6 = 0.0083 for primary RQs (PB1-PB5, PB7).

Conservative but safe against Type I error inflation.

### Post-hoc Tukey HSD

For 3-condition comparison (MCP-5 vs MCP-15 vs CodeGen):

```python
from scipy.stats import tukey_hsd
result = tukey_hsd(mcp5_scores, mcp15_scores, codegen_scores)
# Provides pairwise CIs and p-values
```

Applied after one-way ANOVA reveals significant main effect.

### Paired t-test (for PB7)

For MCP-5 vs MCP-15 comparison on same tasks:

```python
from scipy.stats import ttest_rel
result = ttest_rel(mcp5_task_scores, mcp15_task_scores)
```

Paired design increases power since same tasks are compared across conditions.
