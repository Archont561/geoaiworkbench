---
id: KB-11-visualization-prompts
title: "Visualization Prompts for Thesis Figures"
category: thesis
subcategory: visualization
tags: [visualization, figures, tikz, diagrams, prompts]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [9]
related:
  - KB-11-thesis-structure
  - KB-07-phase6-visualization
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Prompts for generating thesis figures and diagrams"
  key_facts:
    - "Architecture diagram (TikZ)"
    - "Factorial experiment cube (TikZ)"
    - "Roadmap timeline"
    - "Results plots (pgfplots)"
    - "20+ additional diagram ideas"
  common_questions:
    - "What figures are needed?"
    - "How do I create the architecture diagram?"
---

# Visualization Prompts for Thesis Figures

## Required Figures

### Figure 1: System Architecture
- 3 packages + separate MCP process + TCP bridge
- Show all 3 conditions (MCP-5, MCP-15, CodeGen)
- TikZ, landscape orientation

### Figure 2: Factorial Experiment Design
- 3D cube: 3 paradigms × 4 agents × 50 tasks
- Show 3 repetitions per cell
- TikZ or pgfplots

### Figure 3: Metrics Framework Hierarchy
- 7 layers as stacked boxes
- Key metrics per layer
- TikZ tree diagram

### Figure 4: Tool Tier System
- 5 tiers with tool counts
- MCP-5 vs MCP-15 highlighting
- TikZ layered diagram

### Figure 5: Results Heatmap
- Agent × Paradigm × TSR
- Color-coded cells
- pgfplots or seaborn export

## Additional Diagram Ideas (20+)

1. Experiment factorial matrix 3D cube
2. Hypothesis map (H1-H7e)
3. Black box constraint split diagram
4. Task difficulty pyramid
5. Package dependency graph
6. Hook injection lifecycle sequence
7. Paradigm boundary wall
8. MonitorEvent schema diagram
9. Error taxonomy tree
10. PCS weights bar chart
11. ED concept visualization
12. TDD cycle diagram
13. Test layer stack
14. IMRaD to RQ mapping
15. Literature gap scatter plot
16. Expected result shape curves
17. One task run comic strip
18. Decision tree for practitioners
19. Inverted-U tool count curve
20. Protocol stack (MCP/ACP/A2A)

## Related Files

- [KB-11-thesis-structure](thesis-structure.md)
- [KB-07-phase6-visualization](../07-tooling/phase6-visualization.md)
