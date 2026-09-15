---
id: KB-README
title: "GeoAIWorkbench Knowledge Base"
category: meta
subcategory: navigation
tags: [readme, navigation, entry-point]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-INDEX
  - KB-GLOSSARY
  - KB-CHANGELOG
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Entry point and navigation guide for the knowledge base"
  key_facts:
    - "16 top-level directories organized by concern"
    - "216 files total across all batches (updated for MCP-15)"
    - "Every file has YAML frontmatter with unique ID"
    - "IDs follow KB-NN-slug format"
    - "3-condition experiment: MCP-5, MCP-15, CodeGen"
  common_questions:
    - "Where do I start reading?"
    - "How is the knowledge base organized?"
    - "What is the frontmatter schema?"
    - "What are the three experimental conditions?"
---

# GeoAIWorkbench Knowledge Base

This directory captures the complete design, implementation plan, decisions, and rationale of the **GeoAIWorkbench** master's thesis project. It exists so that any LLM (or human) can reconstruct full context without re-asking questions that have already been answered.

## Purpose

GeoAIWorkbench is a controlled empirical comparison of **three paradigms** for LLM-driven GIS automation:

- **Condition A (MCP-5)** — Constrained Model Context Protocol tool calling via GeoMCP plugin exposing exactly 5 geospatial tools (paradigm-clean baseline)
- **Condition B (MCP-15)** — Expanded Model Context Protocol tool calling via GeoMCP plugin exposing 15 tools organized in 5 tiers (realistic GIS toolkit)
- **Condition C (CodeGen)** — Direct PyQGIS code generation (unlimited flexibility upper bound)

The evaluation runs 4 CLI agents × 3 conditions × 50 GeoAnalystBench tasks × 3 repetitions = **1,800 total runs** inside a headless QGIS environment.

## How to Navigate

Start here:

1. **[INDEX.md](INDEX.md)** — Complete file listing with cross-references
2. **[GLOSSARY.md](GLOSSARY.md)** — All acronyms and technical terms
3. **[CHANGELOG.md](CHANGELOG.md)** — Evolution of decisions over time
4. **[00-meta/project-overview.md](00-meta/project-overview.md)** — High-level project description

Then explore by concern:

| Directory | Concern |
|---|---|
| `00-meta/` | Project overview, research questions, contributions, scope |
| `01-literature/` | 33+ references, gaps, citation guide, per-paper summaries |
| `02-research-design/` | 3-condition factorial design, hypotheses, DSRM methodology |
| `03-metrics/` | 7-layer metrics framework, error taxonomy, statistical tests |
| `04-architecture/` | System architecture, packages, patterns, data flow |
| `05-mcp-tools/` | Full MCP tool specifications (Tier 1-5), annotations, tier control |
| `06-implementation/` | File-by-file implementation guides |
| `07-tooling/` | Complete toolchain by project phase |
| `08-technology-decisions/` | Key technology choice rationales |
| `09-testing/` | TDD roadmap, test inventory, adversarial tests |
| `10-security/` | Threat taxonomy, mitigations, workspace scoping |
| `11-thesis/` | Chapter outlines, LaTeX setup, appendices |
| `12-tasks-benchmark/` | GeoAnalystBench adaptation, task schema, tool tier mapping |
| `13-roadmap/` | 8-week TDD roadmap, milestones, critical path |
| `14-decisions-log/` | Master decision log with rationale |
| `15-external-references/` | Links to external documentation |

## Frontmatter Schema

Every file starts with YAML frontmatter for LLM parsability:

```yaml
---
id: KB-NN-slug                    # Unique identifier
title: "Human-readable title"
category: <top-level-dir-name>
subcategory: <optional-grouping>
tags: [tag1, tag2, tag3]
status: canonical                 # canonical | draft | superseded
created: YYYY-MM-DD
updated: YYYY-MM-DD
source_conversation_parts: [N]    # Chat parts this derives from
related: [KB-XX-slug, ...]        # Cross-references
supersedes: []                    # If replaces older decision
superseded_by: null
references: [bibtex-key, ...]     # Academic citations
authoritative: true               # Source of truth?
implementation_status: specified  # specified | in-progress | implemented | tested
llm_hints:
  primary_purpose: "One-line summary"
  key_facts: ["fact1", "fact2"]
  common_questions: ["Q1?", "Q2?"]
---
```

## File ID Convention

- `KB-NN-slug` where `NN` is the batch/directory number
- Slug is kebab-case, matches filename without extension
- Examples: `KB-05-tool-buffer`, `KB-01-luo-et-al-2026`, `KB-14-decision-pixi`

## Status Levels

- **canonical** — Current source of truth, refer to this
- **draft** — Work in progress, subject to change
- **superseded** — Historical decision, see `superseded_by` field

## Contribution to Thesis

This knowledge base is a companion artifact to the master's thesis. It is **not** part of the thesis itself but supports:

- Reproducibility (all design decisions traceable)
- LLM-assisted writing (context can be loaded selectively)
- Post-defense maintenance (future researchers can extend the work)

## License

Same as parent repository (MIT).
