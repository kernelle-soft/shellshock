#!/usr/bin/env bash
set -euo pipefail

# Bootstrap a shellshock-enabled workspace.
#
# Called after submodule init:
#   git submodule update --init shell/.shock && shell/.shock/workspace_init.sh
#
# Arguments are forwarded to `shock workspace`.

PROJ="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
export PROJ

SHOCK_DIR="$PROJ/shell/.shock"

if [[ ! -f "$SHOCK_DIR/cli/workspace" ]]; then
  echo "error: shellshock submodule not initialized (cli/workspace not found)" >&2
  exit 1
fi

cp "$SHOCK_DIR/shock" "$PROJ/shell/shock"
chmod +x "$PROJ/shell/shock"

exec "$PROJ/shell/shock" workspace "$@"
