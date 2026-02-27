# Shellshock

Shared scripting framework for [kernelle-soft](https://github.com/kernelle-soft) projects.

## Usage

Add as a git submodule and bootstrap:

```bash
git submodule add git@github.com:kernelle-soft/shellshock.git shell/.shock
shell/.shock/workspace_init.sh
```

On subsequent clones, initialize and install tools in one shot:

```bash
git submodule update --init shell/.shock && shell/.shock/workspace_init.sh
```

`workspace_init.sh` copies the `shock` dispatcher to `shell/shock` and runs
`shock workspace` to install tools declared in `shock.lock`.

```bash
shell/shock workspace --check
shell/shock git-bump --dry-run
shell/shock git-commit -a
shell/shock git-config
```

## Structure

```
shock               # CLI dispatcher (copied to shell/ by consumer)
workspace_init.sh   # Bootstrap script (submodule init → copy dispatcher → install tools)
cli/                # Subcommands (standalone executables)
  workspace         # Declarative tool installer
  git-bump          # Semver tag bumping
  git-commit        # Automated CI commits
  git-config        # Git user config for CI bots
lib/                # Sourceable libraries (.api.sh, .func.sh)
actions/            # Composite GitHub Actions
schema/             # JSON schemas for manifest.json and shock.lock
```

Consumer project layout:

```
project/
  shock.lock                    # declarative tool definitions
  shell/
    shock                       # dispatcher (copied from .shock/)
    .shock/                     # submodule
    scripts/                    # project-specific scripts
      lib/                      # sourceable libraries
      chores/                   # build, sync, lint, etc.
      ci/                       # CI-specific scripts
      install/                  # installer scripts
```

## Tool Installation

`shock workspace` reads tool definitions from `shock.lock` at the project root.
Strategies are top-level keys; each tool is an object with at least a `version`:

```json
{
  "cargo-binstall": {
    "tokei": { "version": "14.0.0", "args": "--locked --force" }
  },
  "go-install": {
    "govulncheck": { "version": "1.1.4", "pkg": "golang.org/x/vuln/cmd/govulncheck" }
  },
  "local": {
    "gh": { "version": "latest" }
  }
}
```

The `local` strategy delegates to `<tool>.installer.sh` / `<tool>.uninstaller.sh`
scripts found under `$TOOLS_SCRIPTS_DIR` (defaults to `$PROJ/shell/scripts`).

## Environment

- `PROJ` -- project root (set by consumer's `.envrc` or CI)
- `SHELLSHOCK_ENVRC` -- bootstrap hook that sources the project `.envrc`; set automatically by `actions/envrc` in CI, or by `direnv` locally
- `TOOLS_SCRIPTS_DIR` -- override search path for local installer scripts (defaults to `$PROJ/shell/scripts`)
