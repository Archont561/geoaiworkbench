---
id: TASK-10
title: Pin the four CLI agents and their versions
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
updated_date: '2026-09-30 21:45'
labels:
  - orchestration
  - reproducibility
milestone: m-2
dependencies: []
documentation:
  - .knowledge/08-technology-decisions/cli-agent-selection.md
  - .knowledge/14-decisions-log/decision-agent-pool.md
  - .knowledge/15-external-references/cli-agent-docs.md
priority: high
ordinal: 10000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
decision-6 fixes the agent pool at OpenCode, Claude Code, Codex CLI and Goose, and the black-box constraint (decision-5) makes the agent version part of the experimental apparatus: an agent that silently updates between two runs turns a repetition into a different condition. Only opencode-ai is pinned today (1.18.33, installed globally through bun); the other three have no installation path in this repository at all.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Every primary agent has a pinned version and an installation task, in the same style as opencode-install
- [ ] #2 An agent-versions check reports the installed version of each agent and fails when it differs from the pin
- [ ] #3 The pins are recorded where a run can read them, so a result file can state which agent build produced it
- [ ] #4 Agents that need credentials degrade to a clear skip with a message, not a stack trace, on a machine without them
<!-- AC:END -->
