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

## Two environments, and the one rule about them

There are two Pixi environments. `default` carries QGIS, the Python toolchain and the git
instruments; `bun` carries bun and nothing else. This is a solve constraint, not tidiness:
QGIS and bun pin incompatible `icu` (75.1 versus 78.3), so one environment carrying both
only solved because the QGIS floor was pinned down to 3.44.7. The floor is free to move
now. That constraint is recorded in
`.knowledge/08-technology-decisions/qgis-version-3.44.md`.

**A nested `pixi run TASK` runs in the environment it was called from.** The task's own
`default-environment` is honoured on the outermost invocation only. Measured on pixi
0.81.0, not assumed:

| invocation | environment |
| --- | --- |
| `pixi run TASK`, from a bare shell | `TASK`'s `default-environment` |
| `pixi run -e ENV TASK`, from anywhere | `ENV`, always |
| `pixi run TASK`, from inside `ENV` | `ENV`, whatever `TASK` declares |
| `depends-on = [{ task = …, environment = … }]` | the named environment, always |

So: **every task declares the environment it needs** (`default-environment = "bun"` for
anything that reaches bun), **every nested call names `-e`**, and **every `depends-on`
entry is the structured `{ task, environment }` form**, which is the only form immune to
the caller's shell. Together those make the whole graph environment-determined: `-e`
selects the entry task and nothing else, so `pixi run -e default gates` still runs
turbo in `bun`. `scripts/ci.sh` and every hook in `lefthook.yml` are nested calls — git
runs hooks in whatever environment the contributor is in — so they all name `-e`.
Without it the failure names a missing binary (`turbo: command not found`) rather than
a wrong environment, which is a bad hour to spend.

The Python packages cross the boundary themselves: `python/*/package.json` scripts are
`pixi run -e default -- python -m pytest …`, because turbo exists only in `bun` and the
interpreter only in `default`.

Bun is the only JavaScript runtime. Invoke JS tools with `bun run` / `bun x`, never
`node_modules/.bin/…` — every `.bin` entry has a `node` shebang this repository does not
provide. This matters beyond tidiness: a restored sandbox environment has no Node.js at
all, so a `node_modules/.bin` call is a broken gate on exactly the machines the sandbox
exists for.

## Where each rationale lives

JSON config files in this repository cannot carry the reasons for their own contents.
Both `turbo.json` and `biome.json` reject unknown top-level keys — `//`-prefixed
"comment" keys are not a thing in either — so the reasoning is here instead.

**`turbo.json` has no `globalPassThroughEnv`, and that is the point.** Turbo runs in the
`bun` environment, where QGIS's activation variables (`PYTHONPATH`, `QGIS_PREFIX_PATH`,
`QT_QPA_PLATFORM`, `GDAL_DATA`, …) are not set in the first place — they are produced by
activating `default`. Each Python package re-enters `default` through its own
`pixi run -e default -- …`, so activation happens on its own terms. The long
`globalPassThroughEnv` list this repository used to carry existed because turbo and pytest
shared one environment; restoring it would reintroduce a list of variables that are unset
where it is declared.

**`biome.json` `vcs.clientKind`.** The key is `clientKind`, not `client`, and the value
must be given at all or Biome disables VCS integration with a diagnostic rather than
failing. `useIgnoreFile` is what keeps `bun x biome check .` out of the 2.9 GB
`.pixi/envs` tree, which means **`.gitignore` is load-bearing for the linter**: a rule
deleted there does not merely untrack a directory, it hands that directory to Biome.
Biome's own `useBiomeIgnoreFolder` lint is what removed the redundant `!.pixi/**`
negations from `files.includes`; do not add them back.

**`biome.json` `overrides`.** One override, and it is narrow: `noUnusedVariables` is
off for `**/*.astro`. Biome parses an Astro component's frontmatter as JavaScript but
does not parse the template below it, so every `const` a component defines for its own
markup reads as unused. The rule stays on everywhere else; turning it off globally to
silence two components would be trading a real check for a formatting convenience.

**`bunfig.toml` `linker = "hoisted"`.** Bun 1.3 defaults a workspace to the isolated
layout — `node_modules/.bun/<pkg>` plus symlinks — which keeps a package's optional
native bindings inside *its* nested `node_modules`. Astro bundles its prerender step
into `docs/dist/.prerender/`, and the bundled chunks `require` those bindings from
there; the ancestors of that directory are `docs/` and the repository root, neither of
which sees the nested copy. The failure is `Cannot find module
'@bruits/satteri-linux-x64-gnu'` followed by advice about an npm bug that is not the
problem. A hoisted tree puts the binding where the bundle looks for it.

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
`build` is also uncached: it runs `pixi run -e default verify-packages`, which is a
statement about the environment rather than a build product.

## The documentation site

`docs/` is an Astro + Starlight app and a member of the same Bun workspace, so it is
installed by the same `bun install` and built by the same `turbo run build`. It is the
**only** package whose `build` produces an artefact turbo may cache: Astro's output is
a pure function of `docs/` plus the lockfile, both of which turbo hashes, which is the
opposite of the Python situation described above. That override lives in
`docs/turbo.json`.

Three rules for changing it:

- **Never hardcode the `/geoaiworkbench` prefix.** The site is a GitHub Pages *project*
  site, so `astro.config.mjs` sets `base`. Sidebar entries use `slug`, prose uses
  relative links, and both are `base`-aware and validated by `astro check`. A
  root-absolute link 404s in production; a prefixed one breaks when the site moves.
- **No page states a release number.** `pixi run docs-build` exports `GEOAI_VERSION`
  from `scripts/version.ts` — the same authority `version-check` gates on — and
  `astro.config.mjs` exposes it as `import.meta.env.GEOAI_VERSION`. It is declared in
  `docs/turbo.json`'s `env`, so a version change invalidates the cached build.
- **`docs-preview` depends on `docs-build`.** `astro preview` against an empty `dist/`
  reports a missing directory, which reads as a broken task rather than a missing step.

`.github/workflows/docs.yml` publishes it. Pull requests build and stop; only `main`
deploys. It installs `-e bun` alone — the docs need no QGIS, and installing `default`
there would turn a two-minute job into a twenty-minute one for no output. Note that
GitHub Actions does not support YAML anchors, which is why its two `paths` lists are
duplicated rather than shared.

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
added, it becomes `true` in the same commit that adds the crate. The plan packs **both**
environments, `["default", "bun"]`: a transport that restored only `default` would produce
a machine that cannot run turbo, which is not a working environment.

`.pixi-sandbox.toml`, `.github/workflows/publish-sandbox.yml`, `scripts/restore.sh` and
`scripts/restore.ps1` are generated by `pixi-sandbox init github`. Regenerating means
deleting all four and re-running the installer, then **reapplying the local edits marked
`LOCAL` in each file's header**. Those edits are policy, not drift; do not lose them.

The transport has exactly one CI workflow, `publish-sandbox.yml`, and it publishes rather
than proves. Verification is pixi-sandbox's own: `pixi run sandbox-doctor` runs
`doctor --verify` against a packed transport, which compares every declared byte. There is
no second workflow that packs, restores and re-gates a throwaway copy, and there is no
`scripts/airlock-gate.sh`; both were deleted because pixi-sandbox owns that surface and a
duplicate of it is a second thing to keep in step with the plan. What is *not* reproduced
anywhere now is the egress-denied run (`unshare -n`): `pixi install --offline` is a
*request*, not an enforcement, so over a live network a damaged prefix is quietly
re-fetched and the command reports success. If that proof is wanted back, it belongs as a
`pixi run` task a human triggers, not as a workflow that quietly skips its authoritative
tier on the triggers where `inputs` is null.

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
