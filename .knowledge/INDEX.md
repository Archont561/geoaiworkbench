---
id: KB-INDEX
title: "Knowledge Base Master Index — COMPLETE"
category: meta
subcategory: navigation
tags: [index, cross-reference, navigation, complete]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-README
  - KB-GLOSSARY
authoritative: true
implementation_status: complete
llm_hints:
  primary_purpose: "Complete master index of all 216 knowledge base files"
  key_facts:
    - "All 12 batches complete"
    - "216 files across 16 directories"
    - "Fully cross-referenced"
  common_questions:
    - "Where is the file about topic X?"
    - "What files exist?"
---

# Knowledge Base Master Index — COMPLETE

**Status:** All 12 batches complete. 216 files total.

## Batch Completion

| Batch | Name | Status | Files |
|---|---|---|---|
| 1 | Foundation | ✅ | 15 |
| 2 | Literature Round 0 | ✅ | 17 |
| 3 | Literature Rounds 1+2 | ✅ | 22 |
| 4 | Research Design + Metrics | ✅ | 17 |
| 5 | Architecture | ✅ | 12 |
| 6 | MCP Tools | ✅ | 21 |
| 7 | Implementation | ✅ | 18 |
| 8 | Tooling + Decisions | ✅ | 25 |
| 9 | Testing + Security | ✅ | 20 |
| 10 | Thesis + Tasks | ✅ | 23 |
| 11 | Roadmap | ✅ | 10 |
| 12 | Decision Log + Index | ✅ | 12 |
| **Total** | | **✅** | **212** |

## By Directory

### Top-Level (4)
- [README.md](README.md) — Entry point
- [INDEX.md](INDEX.md) — This file
- [GLOSSARY.md](GLOSSARY.md) — Acronyms and terms
- [CHANGELOG.md](CHANGELOG.md) — Decision evolution

### 00-meta/ (5)
- [project-overview.md](00-meta/project-overview.md) — 3-condition experiment
- [research-questions.md](00-meta/research-questions.md) — PB1-PB7
- [contribution-summary.md](00-meta/contribution-summary.md) — 4 contribution types
- [scope-and-limitations.md](00-meta/scope-and-limitations.md) — 6 limitations
- [glossary-terms.md](00-meta/glossary-terms.md) — Detailed definitions

### 01-literature/ (39)
- [bibliography-overview.md](01-literature/bibliography-overview.md) — 33+ refs
- [original-13-references.md](01-literature/original-13-references.md)
- [round1-additions.md](01-literature/round1-additions.md) — +11 refs
- [round2-additions.md](01-literature/round2-additions.md) — +9 refs
- [research-gaps.md](01-literature/research-gaps.md) — 13 gaps
- [related-work-map.md](01-literature/related-work-map.md)
- [citation-placement-guide.md](01-literature/citation-placement-guide.md)
- papers/ (32 individual paper summaries)

### 02-research-design/ (7)
- [design-evolution.md](02-research-design/design-evolution.md)
- [final-research-design.md](02-research-design/final-research-design.md) — 3×4×50×3
- [evaluation-dimensions.md](02-research-design/evaluation-dimensions.md) — 5 dims
- [black-box-constraint.md](02-research-design/black-box-constraint.md)
- [methodology-dsrm.md](02-research-design/methodology-dsrm.md)
- [hypotheses.md](02-research-design/hypotheses.md) — 16 hypotheses
- [task-stratification.md](02-research-design/task-stratification.md)

### 03-metrics/ (10)
- [metrics-overview.md](03-metrics/metrics-overview.md) — 7 layers, ~35 metrics
- [layer1-task-success.md](03-metrics/layer1-task-success.md)
- [layer2-workflow.md](03-metrics/layer2-workflow.md)
- [layer3-output-quality.md](03-metrics/layer3-output-quality.md)
- [layer4-execution.md](03-metrics/layer4-execution.md)
- [layer5-complex-tasks.md](03-metrics/layer5-complex-tasks.md)
- [layer6-composite.md](03-metrics/layer6-composite.md)
- [layer7-security.md](03-metrics/layer7-security.md)
- [error-taxonomy.md](03-metrics/error-taxonomy.md)
- [statistical-tests.md](03-metrics/statistical-tests.md)

### 04-architecture/ (12)
- [system-architecture.md](04-architecture/system-architecture.md)
- [package-qgis-utils.md](04-architecture/package-qgis-utils.md)
- [package-geoaiworkbench.md](04-architecture/package-geoaiworkbench.md)
- [package-geoaibenchmark.md](04-architecture/package-geoaibenchmark.md)
- [separate-process-architecture.md](04-architecture/separate-process-architecture.md)
- [bridge-tcp-protocol.md](04-architecture/bridge-tcp-protocol.md)
- [hook-injection-pattern.md](04-architecture/hook-injection-pattern.md)
- [qt-worker-pattern.md](04-architecture/qt-worker-pattern.md)
- [asyncio-in-qt.md](04-architecture/asyncio-in-qt.md)
- [crash-safe-persistence.md](04-architecture/crash-safe-persistence.md)
- [paradigm-boundary.md](04-architecture/paradigm-boundary.md)
- [data-flow-diagram.md](04-architecture/data-flow-diagram.md)

### 05-mcp-tools/ (21)
- [tool-spec-overview.md](05-mcp-tools/tool-spec-overview.md) — 15 tools, 5 tiers
- [server-instructions.md](05-mcp-tools/server-instructions.md)
- [mcp-annotations.md](05-mcp-tools/mcp-annotations.md)
- [forbidden-tools.md](05-mcp-tools/forbidden-tools.md)
- [tool-selection-decision-tree.md](05-mcp-tools/tool-selection-decision-tree.md)
- [three-condition-experiment.md](05-mcp-tools/three-condition-experiment.md)
- Tier 1: [tool-layer-info.md](05-mcp-tools/tool-layer-info.md), [tool-layer-statistics.md](05-mcp-tools/tool-layer-statistics.md)
- Tier 2: [tool-buffer.md](05-mcp-tools/tool-buffer.md), [tool-clip.md](05-mcp-tools/tool-clip.md), [tool-reproject.md](05-mcp-tools/tool-reproject.md)
- Tier 3: [tool-dissolve.md](05-mcp-tools/tool-dissolve.md), [tool-intersection.md](05-mcp-tools/tool-intersection.md), [tool-difference.md](05-mcp-tools/tool-difference.md), [tool-union.md](05-mcp-tools/tool-union.md), [tool-spatial-join.md](05-mcp-tools/tool-spatial-join.md), [tool-select-by-location.md](05-mcp-tools/tool-select-by-location.md)
- Tier 4: [tool-centroid.md](05-mcp-tools/tool-centroid.md), [tool-simplify.md](05-mcp-tools/tool-simplify.md)
- Tier 5: [tool-merge-layers.md](05-mcp-tools/tool-merge-layers.md), [tool-calculate-field.md](05-mcp-tools/tool-calculate-field.md)

### 06-implementation/ (18)
- [file-structure.md](06-implementation/file-structure.md)
- [pyproject-toml.md](06-implementation/pyproject-toml.md)
- [models-pydantic.md](06-implementation/models-pydantic.md)
- [geo-mcp-server.md](06-implementation/geo-mcp-server.md)
- [bridge-implementation.md](06-implementation/bridge-implementation.md)
- [plugin-implementation.md](06-implementation/plugin-implementation.md)
- [monitor-implementation.md](06-implementation/monitor-implementation.md)
- [verifier-implementation.md](06-implementation/verifier-implementation.md)
- [harness-implementation.md](06-implementation/harness-implementation.md)
- [orchestrator-implementation.md](06-implementation/orchestrator-implementation.md)
- [metrics-implementation.md](06-implementation/metrics-implementation.md)
- [statistics-implementation.md](06-implementation/statistics-implementation.md)
- [cli-benchmark-py.md](06-implementation/cli-benchmark-py.md)
- [security-hardening.md](06-implementation/security-hardening.md)
- [caching-strategy.md](06-implementation/caching-strategy.md)
- [logging-strategy.md](06-implementation/logging-strategy.md)
- [retry-strategy.md](06-implementation/retry-strategy.md)
- [locking-strategy.md](06-implementation/locking-strategy.md)

### 07-tooling/ (13)
- [toolchain-overview.md](07-tooling/toolchain-overview.md)
- [phase0-environment.md](07-tooling/phase0-environment.md) through [phase7-archival.md](07-tooling/phase7-archival.md) (8 files)
- [pixi-guide.md](07-tooling/pixi-guide.md)
- [dependencies-rationale.md](07-tooling/dependencies-rationale.md)
- [infrastructure-libraries.md](07-tooling/infrastructure-libraries.md)
- [tools-to-avoid.md](07-tooling/tools-to-avoid.md)

### 08-technology-decisions/ (12)
- [mcp-sdk-v2-migration.md](08-technology-decisions/mcp-sdk-v2-migration.md)
- [fastmcp-standalone.md](08-technology-decisions/fastmcp-standalone.md)
- [pixi-vs-uv.md](08-technology-decisions/pixi-vs-uv.md)
- [qgis-version-3.44.md](08-technology-decisions/qgis-version-3.44.md)
- [protocol-stack-clarification.md](08-technology-decisions/protocol-stack-clarification.md)
- [cli-agent-selection.md](08-technology-decisions/cli-agent-selection.md)
- [black-box-vs-instrumented.md](08-technology-decisions/black-box-vs-instrumented.md)
- [separate-process-decision.md](08-technology-decisions/separate-process-decision.md)
- [pydantic-v2-choice.md](08-technology-decisions/pydantic-v2-choice.md)
- [polars-vs-pandas.md](08-technology-decisions/polars-vs-pandas.md)
- [duckdb-vs-sqlite.md](08-technology-decisions/duckdb-vs-sqlite.md)
- [decision-tool-count.md](08-technology-decisions/decision-tool-count.md)

### 09-testing/ (11)
- [testing-strategy.md](09-testing/testing-strategy.md) — TDD, 202+ tests
- [test-inventory.md](09-testing/test-inventory.md)
- [tests-qgis-utils.md](09-testing/tests-qgis-utils.md)
- [tests-geoaiworkbench-unit.md](09-testing/tests-geoaiworkbench-unit.md)
- [tests-geoaiworkbench-integration.md](09-testing/tests-geoaiworkbench-integration.md)
- [tests-geoaibenchmark-unit.md](09-testing/tests-geoaibenchmark-unit.md)
- [tests-geoaibenchmark-integration.md](09-testing/tests-geoaibenchmark-integration.md)
- [critical-tests.md](09-testing/critical-tests.md) — 5 must-pass
- [contract-tests.md](09-testing/contract-tests.md)
- [adversarial-tests.md](09-testing/adversarial-tests.md)
- [benchmark-security-warning.md](09-testing/benchmark-security-warning.md)

### 10-security/ (9)
- [security-overview.md](10-security/security-overview.md)
- [threat-taxonomy-hou.md](10-security/threat-taxonomy-hou.md)
- [attack-surface-analysis.md](10-security/attack-surface-analysis.md)
- [prompt-injection-mitigation.md](10-security/prompt-injection-mitigation.md)
- [input-validation.md](10-security/input-validation.md)
- [output-sanitization.md](10-security/output-sanitization.md)
- [workspace-scoping.md](10-security/workspace-scoping.md)
- [auth-strategy.md](10-security/auth-strategy.md)
- [adversarial-task-design.md](10-security/adversarial-task-design.md)

### 11-thesis/ (16)
- [thesis-structure.md](11-thesis/thesis-structure.md)
- [narrative-arc.md](11-thesis/narrative-arc.md)
- [chapter-1-gis-automation.md](11-thesis/chapter-1-gis-automation.md) through [chapter-7-evaluation.md](11-thesis/chapter-7-evaluation.md) (7 chapters)
- [title-variants.md](11-thesis/title-variants.md)
- [latex-setup.md](11-thesis/latex-setup.md)
- [appendices-plan.md](11-thesis/appendices-plan.md)
- [article-draft-prompt.md](11-thesis/article-draft-prompt.md)
- [supervisor-email.md](11-thesis/supervisor-email.md)
- [visualization-prompts.md](11-thesis/visualization-prompts.md)

### 12-tasks-benchmark/ (7)
- [geoanalystbench-overview.md](12-tasks-benchmark/geoanalystbench-overview.md)
- [task-schema.md](12-tasks-benchmark/task-schema.md)
- [difficulty-stratification.md](12-tasks-benchmark/difficulty-stratification.md)
- [task-adaptation-qgis.md](12-tasks-benchmark/task-adaptation-qgis.md)
- [reference-outputs.md](12-tasks-benchmark/reference-outputs.md)
- [adversarial-tasks.md](12-tasks-benchmark/adversarial-tasks.md)
- [task-execution-flow.md](12-tasks-benchmark/task-execution-flow.md)

### 13-roadmap/ (10)
- [two-month-roadmap.md](13-roadmap/two-month-roadmap.md)
- [week1-foundation.md](13-roadmap/week1-foundation.md) through [week8-analysis-writing.md](13-roadmap/week8-analysis-writing.md) (8 weeks)
- [critical-path.md](13-roadmap/critical-path.md)

### 14-decisions-log/ (12)
- [all-decisions-summary.md](14-decisions-log/all-decisions-summary.md) — 20 decisions
- 11 individual decision files

### 15-external-references/ (6)
- [mcp-official-docs.md](15-external-references/mcp-official-docs.md)
- [qgis-pyqgis-docs.md](15-external-references/qgis-pyqgis-docs.md)
- [fastmcp-docs.md](15-external-references/fastmcp-docs.md)
- [cli-agent-docs.md](15-external-references/cli-agent-docs.md)
- [pixi-docs.md](15-external-references/pixi-docs.md)
- [github-repositories.md](15-external-references/github-repositories.md)

## Quick Lookup by Topic

| Topic | Start Here |
|---|---|
| What is this project? | [project-overview.md](00-meta/project-overview.md) |
| Research questions | [research-questions.md](00-meta/research-questions.md) |
| Experimental design | [final-research-design.md](02-research-design/final-research-design.md) |
| Metrics | [metrics-overview.md](03-metrics/metrics-overview.md) |
| Architecture | [system-architecture.md](04-architecture/system-architecture.md) |
| MCP tools | [tool-spec-overview.md](05-mcp-tools/tool-spec-overview.md) |
| Implementation | [file-structure.md](06-implementation/file-structure.md) |
| Tooling | [toolchain-overview.md](07-tooling/toolchain-overview.md) |
| Testing | [testing-strategy.md](09-testing/testing-strategy.md) |
| Security | [security-overview.md](10-security/security-overview.md) |
| Thesis writing | [thesis-structure.md](11-thesis/thesis-structure.md) |
| Timeline | [two-month-roadmap.md](13-roadmap/two-month-roadmap.md) |
| Decisions | [all-decisions-summary.md](14-decisions-log/all-decisions-summary.md) |
| Bibliography | [bibliography-overview.md](01-literature/bibliography-overview.md) |
