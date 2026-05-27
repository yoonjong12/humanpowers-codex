#!/usr/bin/env bash
# update-task-status.sh <workspace> <task-id> <new-status>
# Update **STATUS**: line for the given task ID in tasks.md.
# Exits 0 on success.

WS="${1:?Usage: update-task-status.sh <workspace> <task-id> <new-status>}"
TASK_ID="${2:?}"
NEW_STATUS="${3:?}"
TASKS="$WS/.humanpowers/tasks.md"

[ -f "$TASKS" ] || { echo "ERROR: $TASKS not found" >&2; exit 1; }

python3 - "$TASKS" "$TASK_ID" "$NEW_STATUS" <<'EOF'
import re, sys

path, tid, status = sys.argv[1], sys.argv[2], sys.argv[3]
with open(path) as f:
    content = f.read()

# Find the task section header and replace its first **STATUS**: line
pattern = rf'(### Task {re.escape(tid)}.*?)(\*\*STATUS\*\*: )\S+'
result = re.sub(pattern, rf'\1\g<2>{status}', content, count=1, flags=re.DOTALL)

if result == content:
    print(f"WARN: task-{tid} STATUS line not found", file=sys.stderr)
    sys.exit(1)

with open(path, 'w') as f:
    f.write(result)

print(f"task-{tid} STATUS -> {status}")
EOF
