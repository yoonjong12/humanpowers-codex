#!/usr/bin/env bash
# init-workspace.sh
# Create .humanpowers/ skeleton at git root (in-repo) or cwd (external).
# Output: WS_DIR=<path> KIND=<in-repo|external> TARGET=<repo_root|null>
# Exits 0 if created or already exists.

if git rev-parse --show-toplevel >/dev/null 2>&1; then
  REPO_ROOT="$(git rev-parse --show-toplevel)"
  WS_DIR="$REPO_ROOT/.humanpowers"
  KIND="in-repo"
  TARGET="$REPO_ROOT"
  TARGET_JSON="\"$TARGET\""
else
  WS_DIR="$(pwd)/.humanpowers"
  KIND="external"
  TARGET="null"
  TARGET_JSON="null"
fi

mkdir -p "$WS_DIR/tasks"

if [ ! -f "$WS_DIR/state.json" ]; then
  cat > "$WS_DIR/state.json" <<EOF
{
  "phase": "",
  "target_repo": $TARGET_JSON,
  "workspace_kind": "$KIND",
  "tasks_total": 0,
  "tasks_quiz_done": 0,
  "tasks_built": 0,
  "tasks_verified": 0
}
EOF
fi

echo "WS_DIR=$WS_DIR"
echo "KIND=$KIND"
echo "TARGET=$TARGET"
