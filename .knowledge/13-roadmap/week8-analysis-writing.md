---
id: KB-13-week8-analysis-writing
title: "Week 8: Analysis + Thesis"
category: roadmap
subcategory: weekly
tags: [roadmap, week8,analysis,writing, tdd]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-13-two-month-roadmap
  - KB-13-critical-path
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Week 8: Analysis + Thesis — daily TDD breakdown"
  key_facts:
    - "Focus: Statistical analysis, figures, thesis draft, defense prep"
    - "Deliverable: Day 6-7: Buffer: defense slides (Beamer), supervisor review, final corrections"
  common_questions:
    - "What do I do this week?"
    - "What are the daily tasks?"
---

# Week 8: Analysis + Thesis

## Focus

Statistical analysis, figures, thesis draft, defense prep

## Daily Breakdown

### Monday
Day 1: Run full analysis pipeline (pixi run benchmark-analyse); compute all 7-layer metrics; generate summary tables

### Tuesday
Day 2: Run statistical tests (ANOVA, McNemar, chi-square, paired t-test, bootstrap CIs); generate results figures (heatmaps, box plots, interaction plots)

### Wednesday
Day 3: Write Chapter VI (Results) with all PB1-PB7 findings; create LaTeX tables and TikZ figures

### Thursday
Day 4: Write Chapter VII (Evaluation) with decision table, design principles P1-P8, limitations; write Wnioski (Conclusions)

### Friday
Day 5: Polish thesis: abstract, introduction, bibliography; compile final PDF; verify formatting with wnozigp.sty

## Week Deliverable

Day 6-7: Buffer: defense slides (Beamer), supervisor review, final corrections

## Success Criteria

0 (analysis scripts)|Thesis PDF complete; defense slides ready; all results analyzed

## TDD Cycle

Each day follows RED → GREEN → REFACTOR:
1. **RED:** Write failing test for the day's feature
2. **GREEN:** Implement minimum code to pass
3. **REFACTOR:** Clean up, run full test suite

## Risks This Week

- Delays cascade to subsequent weeks
- QGIS/PyQGIS compatibility issues may require debugging
- Agent API rate limits may slow pilot runs

## Related Files

- KB-13-two-month-roadmap
- KB-13-critical-path
