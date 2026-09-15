---
id: KB-01-round2-additions
title: "Round 2: 9 References from Focused Consensus Search"
category: literature
subcategory: round-two
tags: [round2, consensus-search, protocol-focus, security, mcp-analysis]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14]
related:
  - KB-01-bibliography-overview
  - KB-01-round1-additions
  - KB-01-original-13-references
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "9 additional references from focused Consensus search on MCP protocol evaluation"
  key_facts:
    - "Round 2 focused on MCP-specific evidence (security, tool count, protocols)"
    - "Includes papers from top venues: ACM TOSEM, AAMAS, KDD"
    - "Foundational for PB5 (security) and PB7 (tool count)"
    - "9 new references added"
  common_questions:
    - "What was discovered in Round 2?"
    - "Which papers changed the thesis most?"
    - "Why is Hou et al. important?"
---

# Round 2: Focused Consensus Search on MCP Protocol

After Round 1 revealed gaps in MCP-specific analysis, a focused Consensus search targeted:

- MCP security
- MCP tool count effects
- MCP information fidelity
- Protocol comparison surveys

Result: 9 additional references, including papers from **top venues** (ACM TOSEM, AAMAS, KDD).

## Discovery Method

- **Tool:** Consensus AI (consensus.app)
- **Query strategy:** "MCP as protocol for GIS tools" — protocol-level evaluation focus
- **Date:** September 2026
- **Filter:** Top-venue papers 2025-2026 on MCP evaluation

## The 9 Additions

### Security (3)
1. **Hou et al. (2025)** — MCP Landscape, Security Threats [ACM TOSEM] ⭐ **FOUNDATIONAL**
2. **Maloyan & Namiot (2026)** — Breaking the Protocol
3. **Zhang, D. et al. (2025)** — MCP Security Bench (MSB)

### Information Fidelity Theory (1)
4. **Fan et al. (2026)** — Information Fidelity Martingale [AAMAS] ⭐ **FOUNDATIONAL**

### Tool Count / Selection (2)
5. **Mo et al. (2025)** — LiveMCPBench [KDD] ⭐ **SUPPORTS PB7**
6. **Song et al. (2025)** — "Help or Hurdle?" ⭐ **SUPPORTS PB7**

### Benchmarks (2)
7. **Bandi et al. (2026)** — MCP-Atlas
8. **Luo, Z. et al. (2025)** — MCP-Universe

### Protocol Survey (1)
9. **Ehtesham et al. (2025)** — Protocol Survey (MCP/ACP/A2A/ANP)

## Impact on Thesis

Round 2 caused **three major thesis changes**:

### Change 1: Added PB5 (Security)

Hou et al. (2025) in ACM TOSEM (top SE journal) made security **mandatory**:

- Established MCP threat taxonomy
- Elevated security from "nice to have" to first-class evaluation dimension
- Introduced 5 adversarial tasks (ADV-01 to ADV-05)
- Added Layer 7 (Security) to metrics framework

### Change 2: Added PB7 (Tool Count Effect)

Mo et al. (2025) + Song et al. (2025) provided evidence base:

- Mo et al.: Tool selection degrades beyond ~50 tools
- Song et al.: MCP can HURT performance when misapplied
- Combined: Tool count is an experimental variable, not fixed
- Result: 3-condition experiment (MCP-5, MCP-15, CodeGen)

### Change 3: Optional PB6 (Information Fidelity)

Fan et al. (2026) in AAMAS provided formal model:

- Martingale analysis of MCP tool chains
- Predicts information degradation with chain length
- Optional research question if time permits

## Statistical Rigor Enhanced

Round 2 evidence, particularly GISclaw (Han et al., 2026) with 1,800 experiments, prompted:

- α_adjusted = 0.05 / 6 = 0.0083 for primary RQs
- Bootstrap CIs standardized
- Cliff's delta as effect size norm
- Paired Wilcoxon for within-condition comparisons

## Framing Shift

Round 2 shifted thesis framing:

**Before:** "Is MCP better than code generation?"
**After:** "How does MCP as a tool-integration protocol affect interoperability, planning, parameterization, output validity, and security?"

This protocol-level framing is:
- More defensible academically
- Aligned with ACM TOSEM / AAMAS venue standards
- Novel in GIS context

## File List

Each paper has its own file in `papers/`:

- [KB-01-hou-et-al-2025](papers/hou-et-al-2025.md) ⭐
- [KB-01-fan-et-al-2026](papers/fan-et-al-2026.md) ⭐
- [KB-01-bandi-et-al-2026](papers/bandi-et-al-2026.md)
- [KB-01-ehtesham-et-al-2025](papers/ehtesham-et-al-2025.md)
- [KB-01-mo-et-al-2025](papers/mo-et-al-2025.md) ⭐
- [KB-01-song-et-al-2025](papers/song-et-al-2025.md) ⭐
- [KB-01-maloyan-namiot-2026](papers/maloyan-namiot-2026.md)
- [KB-01-luo-mcp-universe-2025](papers/luo-mcp-universe-2025.md)
- [KB-01-zhang-msb-2025](papers/zhang-msb-2025.md)

## Related

- [KB-01-round1-additions](round1-additions.md) — Previous search
- [KB-01-bibliography-overview](bibliography-overview.md) — Master list
- [KB-00-research-questions](../00-meta/research-questions.md) — PB5, PB6, PB7 questions
