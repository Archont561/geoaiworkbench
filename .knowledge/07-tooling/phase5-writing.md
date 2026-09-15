---
id: KB-07-phase5-writing
title: "Phase: Thesis Writing"
category: tooling
subcategory: phase
tags: [tooling, phase, phase5,writing]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-toolchain-overview
  - KB-11-latex-setup
  - KB-11-thesis-structure
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tools and workflow for Thesis Writing"
  key_facts:
    - "Tools: LaTeX (TeX Live 2025), pdfLaTeX, BibLaTeX 3.20+, TikZ 3.1, pgfplots, JabRef 5.15+, Zotero 7"
  common_questions:
    - "What tools are used for Thesis Writing?"
---

# Phase: Thesis Writing

## Tools

LaTeX (TeX Live 2025), pdfLaTeX, BibLaTeX 3.20+, TikZ 3.1, pgfplots, JabRef 5.15+, Zotero 7

## Details

LaTeX with wnozigp.sty (Times New Roman, 1.5 spacing, 3.5cm margins); BibLaTeX with authoryear style and biber backend; TikZ for architecture diagrams; pgfplots for data-driven figures; JabRef for BibTeX management; Zotero for PDF annotation during reading

## Key Commands

```bash
pdflatex main.tex; biber main; pdflatex main.tex
```

## Related Files

- KB-07-toolchain-overview
- KB-11-latex-setup
- KB-11-thesis-structure
