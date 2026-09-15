---
id: KB-01-ning-et-al-2025
title: "Ning et al. (2025) — Data Retrieval Agent"
category: literature
subcategory: paper-summary
tags: [data-retrieval, osm, census, opentopography, ning-et-al]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 12]
related:
  - KB-01-original-13-references
  - KB-01-li-et-al-2025
authoritative: false
implementation_status: specified
references:
  - ning2025autonomous
llm_hints:
  primary_purpose: "Autonomous GIS agent for geospatial data retrieval from multiple sources"
  key_facts:
    - "Retrieves from OpenStreetMap, US Census, OpenTopography"
    - "Autonomous data discovery capability"
    - "Complements analysis-focused agents"
  common_questions:
    - "What data sources are supported?"
    - "How does data retrieval differ from analysis?"
    - "Is data retrieval in GeoAIWorkbench scope?"
---

# Ning et al. (2025) — Autonomous GIS Data Retrieval Agent

## Full Citation

Ning, H., et al. (2025). Autonomous GIS agent for geospatial data retrieval.

## What This Paper Says

Presents a framework for autonomous geospatial data retrieval. Complements analysis-focused agents by addressing the "where do I get the data?" question.

### Data Sources Supported

- **OpenStreetMap (OSM)** — Global vector data
- **US Census Bureau** — Demographic data
- **OpenTopography** — Elevation data
- Extensible to other sources

### Architecture

- Query interpretation (natural language → API call)
- Source selection (which data source has what)
- Data fetching and format conversion
- Metadata extraction
- Integration with downstream analysis

## Key Findings

- Autonomous data discovery is feasible for well-known sources
- Format conversion (GeoJSON, Shapefile, GeoTIFF) automatable
- Metadata critical for downstream analysis
- Source selection remains challenging for novel queries

## Why This Paper Matters

- **Addresses Core Function 1** from Li et al. (2025)
- **Complementary capability** to analysis-focused agents
- **Enables end-to-end autonomy** — from query to result

## Relevance to GeoAIWorkbench

**Low direct relevance** — GeoAIWorkbench provides data (pre-loaded in workspace).

### Why Not in Scope

- GeoAIWorkbench focuses on analysis paradigms, not data acquisition
- Tasks include pre-loaded input layers
- Data retrieval would add uncontrolled variance
- Different research problem

### Future Extension

- Could combine GeoAIWorkbench MCP tools with data retrieval tools
- Would enable end-to-end automation studies

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter I | Section 1.4 | Core functions overview |
| Chapter II | Section 2.3 | GIS agent capabilities |
| Chapter VII | Section 7.4 | Future work (end-to-end automation) |

## Related Papers

- Li et al. (2025) — Function 1 in research agenda
- GeoAnalystBench tasks — Assume data is provided

## Key Quote

*"Autonomous data retrieval represents a critical capability for realizing the vision of end-to-end autonomous GIS."* — Ning et al. (2025)

## Critique / Limitations

- Limited to well-known data sources
- No evaluation of retrieval quality
- Format conversion loss unmeasured
- Metadata extraction accuracy not reported

## BibTeX Key

`ning2025autonomous`
