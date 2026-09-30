#!/usr/bin/env bun
// The single version authority, and the thing that keeps the five manifests that
// carry it honest.
//
//   pixi run version          # print the workspace version
//   pixi run version-check    # fail if any manifest disagrees (this is the gate)
//   pixi run version-set      # rewrite every manifest that owns a literal
//
// `[workspace] version` in the root pixi.toml is the number. Everything else
// either restates it or inherits it, and this script is what proves which. It runs
// in `gates`, so forgetting to bump a manifest fails before a commit lands rather
// than after a release — which matters more here than in most repositories,
// because a benchmark artefact published under the wrong version silently
// invalidates a comparison against the run that came before it.
//
// Parsing uses Bun.TOML rather than a regular expression. That is not a
// preference: the manifests deliberately use two different spellings of the same
// fact, `version = "0.1.0"` in pixi.toml and `version = { workspace = true }` in
// each python/*/pixi.toml, and a regex wide enough for the first is wrong for the
// second in a way that only shows up once someone actually inherits.

const ROOT = new URL("..", import.meta.url).pathname.replace(/\/$/, "");
const VERSION = "0.1.0";

type Manifest = { path: string; literal: string | null; inherits: boolean };

/** Read a TOML file, or return null when it does not exist. */
async function readToml(relative: string): Promise<unknown | null> {
  const file = Bun.file(`${ROOT}/${relative}`);
  if (!(await file.exists())) return null;
  return Bun.TOML.parse(await file.text());
}

/** Every manifest that either owns the version literal or inherits it. */
async function collect(): Promise<Manifest[]> {
  const manifests: Manifest[] = [];

  const workspace = (await readToml("pixi.toml")) as { workspace?: { version?: string } } | null;
  manifests.push({
    path: "pixi.toml",
    literal: workspace?.workspace?.version ?? null,
    // The root owns the number, so it is the authority rather than a follower.
    inherits: false,
  });

  for (const name of ["geoai-core", "geoai-mcp", "geoai-bench"]) {
    const base = `python/${name}`;

    const project = (await readToml(`${base}/pyproject.toml`)) as {
      project?: { version?: string };
    } | null;
    const literal = project?.project?.version ?? null;
    manifests.push({ path: `${base}/pyproject.toml`, literal, inherits: false });

    // `version = { workspace = true }` is an explicit opt-in, not an omission: the
    // manifest names the authority instead of restating it. A pixi.toml with
    // neither is a bug, and reporting it as "agrees" would hide that.
    const packageToml = (await readToml(`${base}/pixi.toml`)) as {
      package?: { version?: string | { workspace?: boolean } };
    } | null;
    const version = packageToml?.package?.version;
    const inherits = typeof version === "object" && version?.workspace === true;
    manifests.push({ path: `${base}/pixi.toml`, literal: null, inherits });
  }

  return manifests;
}

/** The disagreeing manifests, as human-readable lines. Empty means agreement. */
async function disagreements(): Promise<string[]> {
  const problems: string[] = [];
  for (const { path, literal, inherits } of await collect()) {
    if (inherits) continue; // inherits by construction, cannot disagree
    if (literal === null) {
      problems.push(`${path}: no version found`);
      continue;
    }
    if (literal !== VERSION) {
      problems.push(`${path}: ${literal} (expected ${VERSION})`);
    }
  }
  return problems;
}

const set = Bun.argv.includes("--set");
const check = Bun.argv.includes("--check");

if (set) {
  // Two rewrites, because the two files spell the key differently in practice only
  // in shape — `[workspace] version` and `[project] version` are the same
  // `key = "value"` line, and replacing the value in place preserves whatever
  // surrounding structure and comments the manifest has grown.
  let rewritten = 0;
  for (const relative of [
    "pixi.toml",
    "python/geoai-core/pyproject.toml",
    "python/geoai-mcp/pyproject.toml",
    "python/geoai-bench/pyproject.toml",
  ]) {
    const file = Bun.file(`${ROOT}/${relative}`);
    const before = await file.text();
    const after = before.replace(/^(version\s*=\s*)"[^"]*"/m, `$1"${VERSION}"`);
    if (after === before) {
      console.error(`${relative}: no literal version to rewrite`);
      process.exit(1);
    }
    await Bun.write(`${ROOT}/${relative}`, after);
    rewritten += 1;
  }
  console.log(`set ${VERSION} in ${rewritten} manifests`);
} else if (check) {
  const problems = await disagreements();
  if (problems.length > 0) {
    console.error(`version-check failed; ${VERSION} is the version in pixi.toml:`);
    for (const problem of problems) console.error(`  ${problem}`);
    console.error("run `pixi run version-set` to rewrite the literal manifests");
    process.exit(1);
  }
  console.log(`version-check ok: every manifest agrees on ${VERSION}`);
} else {
  console.log(VERSION);
}
