---
name: backlog
description: Managing project work as Markdown tasks with Backlog.md. Use when creating, breaking down, tracking, or updating tasks; when the user mentions the backlog, a kanban board, a task ID (task-N), acceptance criteria (AC), or a Definition of Done (DoD).
---

Backlog.md keeps every task as a plain Markdown file under `backlog/`, versioned with the
code, so task state is a git commit. Drive it through the CLI: prefer `backlog` commands over
hand-editing task files, so IDs, filenames, and metadata stay consistent.

## Running it in this repo

`backlog.md` is a root Bun-workspace devDependency, exposed as a Pixi task:

```
pixi run backlog -- <args>        # = bun x backlog
```

Three things about that invocation, each of which is a real failure otherwise:

- **The `--` is required.** Without it, Pixi parses the trailing words as its own options.
- **Go through `bun x`, never `node_modules/.bin/backlog`.** The `backlog` binary carries a
  `#!/usr/bin/env node` shebang and this repository has no Node.js runtime at all — not on a
  contributor's machine, and emphatically not on a restored sandbox. That is also why
  `opencode-ai` is not a dependency: it is installed globally by `pixi run opencode-install`.
- **If `backlog/` does not exist**, run `pixi run backlog -- init geoaiworkbench --defaults
  --backlog-dir backlog --agent-instructions agents --integration-mode cli` once. Every flag
  is load-bearing: `--defaults` keeps it out of the interactive location prompt, and
  `--agent-instructions agents` is what writes the managed block at the end of `AGENTS.md`.

## Agent mode

Read commands default to an **interactive TUI** that never returns in a non-interactive shell:

- Add `--plain` to every read (`task list`, `task <id>`, `search`) for stable text.
- Add `--json` when you will parse the output; it is versioned and machine-readable.
- Never launch `backlog board`, `backlog browser`, or `backlog task <id>` bare — they block.

## The loop

1. **Find work** — `pixi run backlog -- task list -s "To Do" --plain`, or `search "<query>" --plain`.
2. **Read before coding** — `task <id> --plain`. Read the acceptance criteria and any plan first.
3. **Claim and plan** — `task edit <id> -s "In Progress" -a @me --plan "approach"`.
4. **Record progress in notes** (the execution log), not comments —
   `task edit <id> --notes "..."`, then `--append-notes` for more lines.
5. **Verify against AC** — mark each criterion with `--check-ac <n>`; write a PR-ready
   `--final-summary "..."` when the work is done.
6. **Close** — `task edit <id> -s Done`, or `task complete <id>` during cleanup. Use
   `task archive <id>` for cancelled, duplicate, or invalid work.

## Creating tasks

```
pixi run backlog -- task create "Title" -d "description" --ac "First,Second" -l area --priority high --dep task-1
```

Sub-task: `-p <parent-id>`. Draft: `--draft`, or `backlog draft create "..."` then `draft promote <id>`.
Trust `pixi run backlog -- <command> --help` as the live source of truth over any cached list.

## Input gotchas

- **Multi-line** description/plan/notes: repeat the `--append-*` variant once per line (works in
  every shell, including agent sandboxes), or put real newlines inside double quotes. Do **not**
  use `$'line1\nline2'` — tree-sitter agent sandboxes reject it.
- **Literal backticks**: single-quote the argument, or the shell runs command substitution
  before Backlog.md sees the text.
- **Notes vs comments**: implementation notes and the final summary carry execution progress;
  comments are append-only review discussion (`--comment "..." --comment-author @you`). A
  standalone `---` line is reserved as a comment delimiter.

## Scope

This repository is **configuration and orchestration only**. The three Python packages under
`python/` are scaffolds with no benchmark logic. A task that says "implement X" belongs to
another repository; a task that says "wire up X" or "gate X" belongs here. See `AGENTS.md`.