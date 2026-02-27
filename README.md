# Shellshock

Shared scripting framework for [kernelle-soft](https://github.com/kernelle-soft) projects.

## Usage

Mount as a git submodule at `.shell/` in your project root:

```bash
git submodule add git@github.com:kernelle-soft/shellshock.git .shell
```

Then invoke CLI commands via the `shock` dispatcher:

```bash
.shell/shock workspace --check
.shell/shock git-bump --dry-run
.shell/shock git-commit -a
.shell/shock git-config
```

## Structure

```
shock               # CLI dispatcher
cli/                # Subcommands (standalone executables)
  workspace         # Declarative tool installer
  git-bump          # Semver tag bumping
  git-commit        # Automated CI commits
  git-config        # Git user config for CI bots
lib/                # Sourceable libraries (.api.sh, .func.sh)
actions/            # Composite GitHub Actions
schema/             # JSON schemas for manifest.json
```

## Environment

- `PROJ` -- project root (set by consumer's `.envrc` or CI)
- `SHELLSHOCK_ENVRC` -- bootstrap hook that sources the project `.envrc`; set automatically by `actions/envrc` in CI, or by `direnv` locally
