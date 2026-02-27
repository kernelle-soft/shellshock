# Shellshock

Shared scripting framework for [kernelle-soft](https://github.com/kernelle-soft) projects.

## Usage

Mount as a git submodule at `.shsh/` in your project root:

```bash
git submodule add git@github.com:kernelle-soft/shellshock.git .shsh
```

## Layout

```
lib/       Core scripting library (import, log, semver, manifest, etc.)
ci/        CI utility scripts (git config, commit, version bumping)
actions/   Composite GitHub Actions (envrc, setup, git-config)
schema/    Manifest schema definition
```
