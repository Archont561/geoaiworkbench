---
id: KB-01-mansourian-oucheikh-2026
title: "Mansourian & Oucheikh (2026) — Multi-agent QGIS Framework"
category: literature
subcategory: paper-summary
tags: [multi-agent, qgis, cot, rag, self-healing, mansourian]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [12]
related:
  - KB-01-round1-additions
  - KB-01-akinboyewa-et-al-2025
authoritative: false
implementation_status: specified
references:
  - mansourian2026multiagent
llm_hints:
  primary_purpose: "Multi-agent framework combining CoT + RAG + QGIS Processing algorithms as tools"
  key_facts:
    - "QGIS Processing algorithms as tools"
    - "Combines CoT + RAG + execution feedback"
    - "Introduces Self-Healing Ratio (SHR) and Iterations to Success (ITS)"
    - "Uses 3 seeds per experiment"
  common_questions:
    - "What is this framework?"
    - "What are SHR and ITS?"
    - "How does it use QGIS Processing?"
---

# Mansourian & Oucheikh (2026) — Multi-agent QGIS Framework

## Full Citation

Mansourian, A., & Oucheikh, R. (2026). Bridging natural language and GIS: a multi-agent framework for LLM-driven autonomous geospatial analysis. *International Journal of Digital Earth, 19*.

## What This Paper Says

Multi-agent framework combining Chain-of-Thought (CoT), Retrieval-Augmented Generation (RAG), and QGIS Processing algorithms as tools. Introduces self-healing and iteration-to-success metrics.

### Architecture

- Multi-agent coordination
- CoT for reasoning
- RAG for domain knowledge
- **QGIS Processing algorithms as agent tools** — direct precedent for GeoMCP

### Metrics Introduced

- Execution success
- Semantic correctness
- Tool selection accuracy
- **Self-healing after failed first attempts** ⭐ **SHR**
- **Iteration count to success** ⭐ **ITS**

## Key Findings

- QGIS Processing algorithms work well as agent tools
- CoT + RAG improve reasoning
- **Self-healing (retries) improve success rates significantly**
- **Iteration count varies widely across models**
- 3-seed evaluation reveals variance

## Why This Paper Matters

- **Direct precedent for QGIS Processing as agent tools** — informs GeoMCP design
- **Introduces SHR and ITS metrics** — adopted by GeoAIWorkbench
- **Validates 3-seed evaluation approach**

## Relevance to GeoAIWorkbench

**Very high relevance.**

### Direct Metric Adoption

**Self-Healing Ratio (SHR):**
```
SHR = |{tasks failed on attempt 1 AND passed on attempt 2 or 3}| / |{tasks failed on attempt 1}|
```

**Iterations to Success (ITS):**
```
ITS = min({attempt_number : task passed on attempt_number}) or ∞
```

Both added to GeoAIWorkbench Layer 4/5 metrics.

### Design Validation

GeoMCP uses QGIS Processing algorithms:
- `native:buffer`
- `native:clip`
- `native:reprojectlayer`
- etc.

Mansourian & Oucheikh (2026) validates this approach.

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter I | Section 1.3 | QGIS Processing in agents |
| Chapter II | Section 2.2 | Multi-agent QGIS systems |
| Chapter IV | Section 4.4 | **SHR and ITS metric adoption** |
| Chapter IV | Section 4.5 | 3 seeds precedent |
| Chapter VI | Section 6.4 | SHR/ITS analysis |

## Related Papers

- Akinboyewa et al. (2025) — Single-agent QGIS
- Wu et al. (2025) — Multi-agent (not QGIS-specific)
- Díaz-Ireland et al. (2026) — 3-seed methodology

## Key Quote

*"Multi-agent frameworks combining CoT, RAG, and QGIS Processing algorithms as tools improve execution success, and self-healing after failed first attempts significantly improves overall task completion rates."* — Mansourian & Oucheikh (2026)

## BibTeX Key

`mansourian2026multiagent`
