---
id: KB-11-latex-setup
title: "LaTeX Setup — wnozigp.sty"
category: thesis
subcategory: latex
tags: [latex, wnozigp, setup, formatting, biblatex]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [6]
related:
  - KB-11-thesis-structure
  - KB-07-phase5-writing
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "LaTeX configuration for WIT PWr thesis format"
  key_facts:
    - "wnozigp.sty style package"
    - "Times New Roman, 1.5 spacing, 3.5cm left margin"
    - "BibLaTeX with biber, authoryear style"
    - "TikZ for diagrams, pgfplots for data"
    - "Custom appendices with tocloft"
  common_questions:
    - "What LaTeX style is required?"
    - "How is bibliography configured?"
    - "How do I create appendices?"
---

# LaTeX Setup — wnozigp.sty

## Style Package

`wnozigp.sty` provided by WIT PWr. Key settings:

| Setting | Value |
|---|---|
| Font | Times New Roman |
| Line spacing | 1.5 |
| Left margin | 3.5cm |
| Headings | titlesec package |
| Bibliography | BibLaTeX + biber |
| Citation style | authoryear |
| Headers/footers | fancyhdr |

## Preamble Template

```latex
\documentclass[12pt,a4paper]{report}
\usepackage{wnozigp}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[polish]{babel}
\usepackage[backend=biber,style=authoryear]{biblatex}
\addbibresource{literature.bib}
\usepackage{tikz}
\usepackage{pgfplots}
\usepackage{tocloft}
\usepackage{lipsum}  % Remove for final version
```

## Custom Appendices

```latex
\newlistof{appendices}{app}{Spis załączników}
\newcommand{\startappendices}{
  \renewcommand{\chapter}[1]{
    \refstepcounter{chapter}
    \addcontentsline{app}{appendices}{Załącznik \thechapter: ##1}
    \chapter*{Załącznik \thechapter: ##1}
  }
}
```

## Compilation

```bash
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex  # 3 passes for cross-references
```

## Related Files

- [KB-11-thesis-structure](thesis-structure.md)
- [KB-07-phase5-writing](../07-tooling/phase5-writing.md)
