---
id: KB-11-thesis-structure
title: "Final Thesis Structure"
category: thesis
subcategory: structure
tags: [thesis, structure, chapters, outline, wnozigp]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [6, 15]
related:
  - KB-11-narrative-arc
  - KB-02-methodology-dsrm
  - KB-01-citation-placement-guide
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Complete thesis chapter structure aligned with WIT PWr requirements"
  key_facts:
    - "Polish master's thesis format"
    - "Wstęp + 7 chapters + Wnioski"
    - "Literature: Ch I-III, Research: Ch IV-VII"
    - "Aligned with WIT PWr wnozigp.sty"
    - "33+ references in literature.bib"
  common_questions:
    - "What is the thesis structure?"
    - "How many chapters?"
    - "What goes in each chapter?"
---

# Final Thesis Structure

## Polish Title

**"Ocena protokołu MCP jako metody integracji agentów LLM z narzędziami GIS w porównaniu z generowaniem kodu"**

## English Title

**"Evaluating the Model Context Protocol as a Tool-Integration Standard for LLM-Driven GIS Automation: A Controlled Comparison with Code Generation in QGIS"**

## Complete Structure

```
TYTUŁ
Streszczenie / Abstract

Wstęp
  ├── Problem badawczy
  ├── Cel pracy
  ├── Zakres pracy
  └── Struktura pracy

ROZDZIAŁ I. SYSTEMY INFORMACJI GEOGRAFICZNEJ I ICH AUTOMATYZACJA
  1.1. Ewolucja systemów GIS
  1.2. Automatyzacja analiz geoprzestrzennych
  1.3. QGIS jako platforma automatyzacji
  1.4. Od skryptów do agentów autonomicznych

ROZDZIAŁ II. DUŻE MODELE JĘZYKOWE JAKO SILNIKI AGENTÓW GIS
  2.1. Architektury agentów LLM
  2.2. Systemy agentowe GIS: przegląd
  2.3. Generowanie kodu vs wywoływanie narzędzi
  2.4. Wieloagentowe systemy geoprzestrzenne
  2.5. Benchmarki agentów GIS

ROZDZIAŁ III. MODEL CONTEXT PROTOCOL JAKO STANDARD INTEGRACJI NARZĘDZI
  3.1. Specyfikacja protokołu MCP
  3.2. Stos protokołów: MCP, ACP, A2A
  3.3. Ekosystem MCP: serwery, benchmarki, rejestry
  3.4. Teoria wierności informacyjnej
  3.5. Zagrożenia bezpieczeństwa MCP
  3.6. Paradoks „pomoc czy przeszkoda"

ROZDZIAŁ IV. PROJEKT EKSPERYMENTU PORÓWNAWCZEGO
  4.1. Metodologia DSRM
  4.2. Trzy warunki eksperymentalne (MCP-5, MCP-15, CodeGen)
  4.3. Zestaw zadań i stratyfikacja trudności
  4.4. Siedmiowarstwowy system metryk
  4.5. Hipotezy badawcze (PB1-PB7)
  4.6. Analiza statystyczna

ROZDZIAŁ V. IMPLEMENTACJA WTYCZKI GeoMCP I INFRASTRUKTURY POMIAROWEJ
  5.1. Architektura systemu
  5.2. Specyfikacja narzędzi MCP (Tier 1-5)
  5.3. Wtyczka QGIS i most TCP
  5.4. Infrastruktura benchmarkowa
  5.5. Ewaluacja generowania kodu (4 warstwy)
  5.6. Utwardzanie bezpieczeństwa
  5.7. Odtwarzalność środowiska (Pixi)

ROZDZIAŁ VI. SKUTECZNOŚĆ MCP I GENEROWANIA KODU NA ZADANIACH GEOPRZESTRZENNYCH
  6.1. PB1: Ogólna skuteczność i jakość wyników
  6.2. PB2: Moderacja przez trudność zadań
  6.3. PB3: Interakcje agent-paradygmat
  6.4. PB4: Zachowanie wykonawcze i profile błędów
  6.5. PB5: Postawa bezpieczeństwa
  6.6. PB7: Wpływ liczby narzędzi MCP
  6.7. PB6: Wierność informacyjna (opcjonalnie)

ROZDZIAŁ VII. OCENA PRZYDATNOŚCI PROTOKOŁU MCP W PRAKTYCE GIS
  7.1. Tabela decyzyjna: MCP-5 vs MCP-15 vs CodeGen
  7.2. Zasady projektowania serwerów MCP dla GIS (P1-P8)
  7.3. Ograniczenia i zagrożenia dla walidacji
  7.4. Kierunki przyszłych badań

Wnioski
Bibliografia (33+ pozycji)
Spis rysunków
Spis tabel
Załączniki A-D
```

## WIT PWr Alignment

| Requirement | Implementation |
|---|---|
| Wstęp | ✅ |
| Część literaturowa | Ch I-III |
| Część badawcza | Ch IV-VII |
| Zakończenie/Wnioski | ✅ |
| Literatura | BibLaTeX, authoryear |
| Format | wnozigp.sty |

## Page Estimates

| Chapter | Pages | Content |
|---|---|---|
| Wstęp | 5-8 | Problem, goals, scope |
| Ch I | 12-15 | GIS automation background |
| Ch II | 15-20 | LLM agents for GIS |
| Ch III | 15-20 | MCP protocol + ecosystem |
| Ch IV | 12-15 | Experiment design |
| Ch V | 15-20 | Implementation |
| Ch VI | 20-25 | Results (largest chapter) |
| Ch VII | 10-12 | Evaluation + guidance |
| Wnioski | 3-5 | Summary |
| **Total** | **~110-140** | |

## Related Files

- [KB-11-narrative-arc](narrative-arc.md) — Story structure
- [KB-02-methodology-dsrm](../02-research-design/methodology-dsrm.md) — DSRM mapping
- [KB-01-citation-placement-guide](../01-literature/citation-placement-guide.md) — Where to cite
