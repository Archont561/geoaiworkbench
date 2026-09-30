<!-- BEGIN:turborepo-agent-rules -->

# This is NOT the Turborepo you know

Turborepo configuration, task behavior, and CLI commands can vary between installed versions and may differ from your training data. Resolve the `turbo` package from this file's directory or relevant workspace; in monorepos, it may not be visible from the repository root. For example, run `node -p "require.resolve('turbo/package.json')"` from a workspace that depends on `turbo`.

Read `docs/README.md` inside that installed package first, then read the relevant pages from its `docs/` directory before changing Turborepo configuration or commands. Heed deprecation notices. These bundled docs match the installed package version and are available without network access.

This block is written and re-added by `turbo` before repository-scoped commands when an AI agent is detected. In the Turborepo source repository, its template is defined in `crates/turborepo-cli/src/cli/agent_guidance.rs`. Removing the managed block while updates are enabled means a later qualifying invocation will add it again. Set `"agentGuidance": false` in the root `turbo.json` or `turbo.jsonc` to opt out; this does not remove an existing block. Keep the block committed with your work to avoid an uncommitted change on the next agent invocation.
<!-- END:turborepo-agent-rules -->

# geoaiworkbench — agent notes

Configuration and orchestration only. The three Python packages under `python/` are
scaffolds: they carry manifests, imports and one version test each, and no benchmark
logic. If you are about to add a feature, that is the wrong repository.

## The one environment

There is exactly one Pixi environment, `default`, and it contains QGIS *and* bun. This
is not tidiness — it is a solve constraint. QGIS pins `icu`, bun pins `icu75`, and the
current QGIS build wants `icu75.1` while any newer one wants `icu78.3`. Splitting the
environments is the right long-term move and is not done here; until it is, **do not
raise the QGIS floor**. That constraint is recorded in
`.knowledge/08-technology-decisions/qgis-version-3.44.md`.

Because there is one environment, no Pixi task uses `-e`/`--environment`. If you split
the environments, every task in `pixi.toml` and every hook in `lefthook.yml` needs
reviewing at the same time.

Bun is the only JavaScript runtime. Invoke JS tools with `bun run` / `bun x`, never
`node_modules/.bin/…` — every `.bin` entry has a `node` shebang this repository does not
provide. This matters beyond tidiness: a restored sandbox environment has no Node.js at
all, so a `node_modules/.bin` call is a broken gate on exactly the machines the sandbox
exists for.

## Where each rationale lives

JSON config files in this repository cannot carry the reasons for their own contents.
Both `turbo.json` and `biome.json` reject unknown top-level keys — `//`-prefixed
"comment" keys are not a thing in either — so the reasoning is here instead.

**`turbo.json` `globalPassThroughEnv`.** Turbo runs tasks in Strict Environment Mode,
which filters the ambient environment down to the variables declared in `env` and
`passThroughEnv`. That is the right default, and it silently breaks a Pixi workspace,
because the variables QGIS needs are produced by *activation* rather than declared
anywhere in this repository. Without that list, `pixi run test` fails with
`ModuleNotFoundError: No module named 'qgis'` from inside turbo while the identical
command run directly succeeds — and the error names the symptom rather than the cause.
**Adding a variable to `[feature.qgis.activation.env]` in `pixi.toml` means adding it to
`globalPassThroughEnv` too.**

**`biome.json` `vcs.clientKind`.** The key is `clientKind`, not `client`, and the value
must be given at all or Biome disables VCS integration with a diagnostic rather than
failing. `useIgnoreFile` is what keeps `bun x biome check .` out of the 2.9 GB
`.pixi/envs` tree, which means **`.gitignore` is load-bearing for the linter**: a rule
deleted there does not merely untrack a directory, it hands that directory to Biome.
Biome's own `useBiomeIgnoreFolder` lint is what removed the redundant `!.pixi/**`
negations from `files.includes`; do not add them back.

**`package.json` `workspaces`.** `python` is listed explicitly *and* globbed.
`python/*` matches `python/geoai-core` and its siblings but **not**
`python/package.json`, and the container package is the one whose `turbo.json` turns
caching off for all three. Without the explicit entry the nested config is silently
dead — and because nothing errors, it stays dead.

## Why Python task caching is off

`python/turbo.json` sets `cache: false` on every task. A Python result here depends on
the *environment*, not only on the source: QGIS's version, the ICU solve, and the
active `PYTHONPATH` all change what a test observes without changing a line of Python.
Turbo's hash covers neither. A cache hit would replay a result from a different solve.
`build` is also uncached: it runs `pixi run verify-packages`, which is a statement about
the environment rather than a build product.

## The coverage data-file race

Each package's `cov` script sets `COVERAGE_FILE` to its own path. This is not
belt-and-braces. Turbo runs all three `cov` tasks concurrently in one working
directory, and coverage's default data file is the single path `./.coverage` — so the
three runs interleave writes to one SQLite file and each report ends up containing
every package's numbers. Observed exactly: geoai-core's report listing all three
packages, geoai-mcp's listing two. The dangerous part is that the numbers stay
plausible, so nothing looks wrong and only the merged total is wrong.

## One owner for the check list

`pixi.toml`'s `gates` owns *what must pass*. `scripts/ci.sh` owns the *order* and the
*producers* and calls `pixi run gates` — it does not restate the list. The local gate,
the lefthook `pre-push` hook and the CI job all invoke the same `scripts/ci.sh`, so
"passes on my machine" and "passes in Actions" cannot come to mean different things.

There is no `advisories` task. Three ecosystems would each need one and a task naming
only one of them reads as coverage; it also needs the network, which is why it would
stay out of `gates` even once it exists — a gate that fails because the network was
unreachable trains people to ignore gates. See the seam comment in `pixi.toml`.

## taplo is scoped to two files

Only `pixi.toml` and `.pixi-sandbox.toml` are in taplo's canonical form; the rest of the
repository uses the aligned-`=` style deliberately. `scripts/lint-toml.sh` exists because
a bare `taplo format --check` takes no path, walks the whole tree, and reports 107
files — 100 of them PyQt5's and sipbuild's vendored manifests inside
`.pixi/envs/default/lib/python3.12/site-packages/`. A gate that reads conda's manifests
fails the moment conda changes one, and says so in terms nobody reviewing a QGIS bump
can act on.

## Sandbox transport

`.pixi-sandbox.toml` sets `cargo_vendor = false` because there is no Cargo workspace.
That flag and the repository's actual content are one decision: if a Rust crate is ever
added, it becomes `true` in the same commit that adds the crate.

`.pixi-sandbox.toml`, `.github/workflows/publish-sandbox.yml`, `scripts/restore.sh` and
`scripts/restore.ps1` are generated by `pixi-sandbox init github`. Regenerating means
deleting all four and re-running the installer, then **reapplying the local edits marked
`LOCAL` in each file's header**. Those edits are policy, not drift; do not lose them.

The airlock proof (`scripts/airlock-gate.sh`, `.github/workflows/airlock.yml`) has two
tiers and only the second is authoritative. Tier B runs with the network reachable;
Tier A runs the identical gate under `unshare -n`. The reason is that
`pixi install --offline` is a *request*, not an enforcement — over a live network a
damaged prefix is quietly re-fetched and the command reports success. Do not let a
green Tier B be described as proof of offline operation.

## Commit and PR conventions

`convco` checks every commit message; `lefthook.yml`'s `commit-msg` hook enforces it,
so the format is decided for you by what failed. PR titles follow the same spec. No
third-party GitHub Action is referenced by tag — every one is pinned to a 40-character
commit SHA with the version in a trailing comment, and `pixi run lint-actions`
(actionlint) enforces it.

<!-- BACKLOG.MD GUIDELINES START -->
<!-- backlog.md-instructions-version: 1.53.0 -->
<CRITICAL_INSTRUCTION>

## Backlog.md Workflow

This project uses Backlog.md for task and project management.

**At the beginning of each conversation in this project, run `backlog instructions overview` before answering or taking action. Re-read it only if you have not read it yet in the current conversation.**

Use the overview to decide whether to search, read, create, or update Backlog tasks.

Before task lifecycle actions, read the matching detailed guide:
- `backlog instructions task-creation` before creating or splitting tasks
- `backlog instructions task-execution` before planning, changing status or assignee, adding a plan or implementation notes, or implementing task work
- `backlog instructions task-finalization` before checking acceptance criteria, writing final summaries, or moving tasks to terminal statuses

Use `backlog <command> --help` before running unfamiliar commands. Help shows options, fields, and examples.

Do not edit Backlog task, draft, document, decision, or milestone markdown files directly. Use the `backlog` CLI so metadata, relationships, and history stay consistent.

</CRITICAL_INSTRUCTION>
<!-- BACKLOG.MD GUIDELINES END -->
