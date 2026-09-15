---
id: KB-11-article-draft-prompt
title: "IMRaD Article Draft Prompt"
category: thesis
subcategory: article
tags: [article, imrad, draft, prompt, journal]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8]
related:
  - KB-11-thesis-structure
  - KB-11-title-variants
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Prompt for generating IMRaD journal article draft"
  key_facts:
    - "IMRaD format (Introduction, Methods, Results, Discussion)"
    - "Polish + English versions"
    - "5 placeholder tables, 5 placeholder figures"
    - "Target venues: IJDE, TGIS, Big Earth Data"
  common_questions:
    - "How do I generate the article draft?"
    - "What format is the article?"
---

# IMRaD Article Draft Prompt

## Purpose

Comprehensive prompt for generating a full IMRaD article draft from thesis results.

## Target Venues

- *International Journal of Digital Earth* (IJDE)
- *Transactions in GIS* (TGIS)
- *Big Earth Data*
- AGILE/FOSS4G conference proceedings

## Article Structure

```
Title (PL + EN)
Abstract (250 words)
1. Introduction (1500 words)
   - Co jest (problem)
   - Dlaczego tak jest (gap)
   - Jak być powinno (solution)
   - Co zrobić (contribution)
2. Related Work (1000 words)
3. Methodology (1500 words)
   - DSRM framework
   - 3-condition factorial design
   - 7-layer metrics
4. Implementation (1000 words)
   - GeoMCP plugin
   - Benchmark infrastructure
5. Results (2000 words)
   - PB1-PB7 findings
   - 5 tables, 5 figures
6. Discussion (1000 words)
   - Decision framework
   - Design principles
   - Limitations
7. Conclusion (500 words)
References (33+)
```

## Placeholder Convention

All pre-data values use `[PLACEHOLDER: description]` format.

## Related Files

- [KB-11-thesis-structure](thesis-structure.md)
- [KB-11-title-variants](title-variants.md)
