---
id: KB-02-evaluation-dimensions
title: "Five Evaluation Dimensions"
category: research-design
subcategory: dimensions
tags: [evaluation, dimensions, interoperability, planning, parameters, output, security]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14, 15]
related:
  - KB-02-final-research-design
  - KB-03-metrics-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Five evaluation dimensions for protocol-level MCP assessment"
  key_facts:
    - "1. Interoperability & Standardization"
    - "2. Planning & Dependency Fidelity"
    - "3. Parameterization Correctness"
    - "4. Spatial Output Validity"
    - "5. Security Posture (added after Hou et al. TOSEM)"
  common_questions:
    - "What are the evaluation dimensions?"
    - "Why five dimensions?"
    - "How do they map to metrics?"
---

# Five Evaluation Dimensions

GeoAIWorkbench evaluates MCP as a protocol across five dimensions. This framing shifts from "does MCP work?" to "how does MCP affect specific aspects of GIS automation?"

## Dimension 1: Interoperability & Standardization

**Claim tested:** MCP reduces integration effort vs custom code generation.

**What is measured:**
- Tool schema compliance rate
- Cross-agent portability (same GeoMCP server, 4 agents)
- Configuration complexity per agent

**Metrics:** Tool Selection Accuracy, agent setup time, config lines of code

**Evidence base:** Ehtesham et al. (2025), Nargund et al. (2025)

**GeoAIWorkbench data:** Same GeoMCP plugin works with all 4 agents without modification.

## Dimension 2: Planning & Dependency Fidelity

**Claim tested:** MCP's structured tool descriptions improve multi-step planning.

**What is measured:**
- Step Order Accuracy
- Longest Correct Prefix (LCP)
- Critical Path Success
- Workflow Validity

**Metrics:** Layer 2 and Layer 5 metrics

**Evidence base:** Fan et al. (2026) AAMAS martingale model, Wang et al. (2025) dependency order

**GeoAIWorkbench data:** 50 tasks stratified by step count (1-step → 5+ steps)

## Dimension 3: Parameterization Correctness

**Claim tested:** Schema-driven parameter passing (MCP) reduces parameter errors vs free-form code.

**What is measured:**
- Parameter Execution Accuracy (PEA)
- param_type and param_value error rates
- Parameter Validation Coverage

**Metrics:** PEA (Layer 2), Error Type Distribution (Layer 4)

**Evidence base:** Yu et al. (2026) PEA, Yin et al. (2025), Bandi et al. (2026)

**GeoAIWorkbench data:**
- MCP: MCPMonitor logs capture exact parameters per tool call
- CodeGen: QGIS Workflow IR + `checkParameterValues()` validation

## Dimension 4: Spatial Output Validity

**Claim tested:** Both paradigms produce geometrically valid, CRS-correct outputs.

**What is measured:**
- Geometry validity (Shapely `is_valid`)
- CRS match (pyproj)
- Extent IoU
- Feature count match
- Attribute preservation
- RMSE (raster)

**Metrics:** OQS (Layer 3)

**Evidence base:** Zhang et al. (2025), Han et al. (2026), Liang et al. (2026)

**GeoAIWorkbench data:** OutputVerifier with Shapely, GeoPandas, rasterio, pyproj

## Dimension 5: Security Posture ⭐ NEW

**Claim tested:** MCP introduces protocol-specific attack surfaces absent in code generation.

**What is measured:**
- Attack Surface Size (tools × params × I/O scope)
- Prompt Injection Resistance (ADV-01 to ADV-05)
- Parameter Validation Coverage
- Data Exfiltration Risk

**Metrics:** Layer 7 (Security)

**Evidence base:** Hou et al. (2025) TOSEM, Maloyan & Namiot (2026), Zhang D. et al. (2025) MSB

**GeoAIWorkbench data:** 5 adversarial tasks + qualitative attack surface analysis

**Why added:** Hou et al. (2025) in ACM TOSEM established security as mandatory evaluation dimension for MCP research.

## Dimension Mapping to Research Questions

| Dimension | Primary RQ | Secondary RQs |
|---|---|---|
| 1. Interoperability | PB1, PB3 | PB7 |
| 2. Planning | PB2 | PB6 |
| 3. Parameterization | PB4 | PB7 |
| 4. Output Validity | PB1 | PB2 |
| 5. Security | PB5 | PB7 |

## Dimension Mapping to Metrics Layers

| Dimension | Metrics Layers |
|---|---|
| 1. Interoperability | Layer 1, Layer 2 |
| 2. Planning | Layer 2, Layer 5 |
| 3. Parameterization | Layer 2, Layer 4 |
| 4. Output Validity | Layer 3 |
| 5. Security | Layer 7 |

## Related Files

- [KB-03-metrics-overview](../03-metrics/metrics-overview.md) — Full 7-layer framework
- [KB-00-research-questions](../00-meta/research-questions.md) — PB1-PB7
- [KB-10-security-overview](../10-security/security-overview.md) — Security dimension detail
