# Shellshock

Shared scripting framework for [kernelle-soft](https://github.com/kernelle-soft) projects.

## Usage

Mount as a git submodule at `shell/.shock/` in your project:

```bash
mkdir -p shell
git submodule add git@github.com:kernelle-soft/shellshock.git shell/.shock
cp shell/.shock/shock shell/shock
```

The `shock` dispatcher is copied out of the submodule into `shell/` so it's
visible and directly invocable. A project's `workspace_setup.sh` script
handles this automatically (along with submodule init and tool installation).

```bash
shell/shock workspace --check
shell/shock git-bump --dry-run
shell/shock git-commit -a
shell/shock git-config
```

## Structure

```
shock               # CLI dispatcher (copied to shell/ by consumer)
cli/                # Subcommands (standalone executables)
  workspace         # Declarative tool installer
  git-bump          # Semver tag bumping
  git-commit        # Automated CI commits
  git-config        # Git user config for CI bots
lib/                # Sourceable libraries (.api.sh, .func.sh)
actions/            # Composite GitHub Actions
schema/             # JSON schemas for manifest.json
```

Consumer project layout:

```
project/
  shell/
    shock                       # dispatcher (copied from .shock/)
    .shock/                     # submodule
    workspace_setup.sh          # bootstrap: submodule init + copy shock + install tools
    chores/                     # project-specific scripts
```

## Environment

- `PROJ` -- project root (set by consumer's `.envrc` or CI)
- `SHELLSHOCK_ENVRC` -- bootstrap hook that sources the project `.envrc`; set automatically by `actions/envrc` in CI, or by `direnv` locally
