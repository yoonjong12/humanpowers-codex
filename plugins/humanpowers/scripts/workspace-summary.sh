#!/usr/bin/env bash
# workspace-summary.sh <workspace>
# Aggregate state.json + tasks.md into a compact summary for review/routing.
# Replaces multi-file reads in review and finishing skills.

WS="${1:?Usage: workspace-summary.sh <workspace>}"
STATE="$WS/.humanpowers/state.json"
TASKS="$WS/.humanpowers/tasks.md"

[ -f "$STATE" ] || { echo "ERROR: $STATE not found" >&2; exit 1; }

python3 - "$STATE" "$TASKS" <<'EOF'
import json, re, sys, os

state_path, tasks_path = sys.argv[1], sys.argv[2]
with open(state_path) as f:
    s = json.load(f)

print(f"Workspace: {os.path.dirname(state_path)}")
print(f"Phase:     {s.get('phase', '?')}")
print(f"Target:    {s.get('target_repo', 'null')}")
print(f"Tasks:     {s.get('tasks_total', 0)} total")

if os.path.exists(tasks_path):
    with open(tasks_path) as f:
        content = f.read()
    statuses = re.findall(r'\*\*STATUS\*\*:\s*(\S+)', content)
    from collections import Counter
    counts = Counter(statuses)
    for status in ['brainstorm-done', 'quiz-done', 'designed', 'built', 'verified']:
        if status in counts:
            print(f"  {status}: {counts[status]}")

    pending = []
    for section in re.split(r'(?=^### Task)', content, flags=re.MULTILINE):
        m_id = re.search(r'\*\*id\*\*:\s*(\S+)', section)
        m_status = re.search(r'\*\*STATUS\*\*:\s*(\S+)', section)
        if m_id and m_status and m_status.group(1) not in ('verified', 'finished'):
            pending.append(m_id.group(1))
    if pending:
        print(f"Pending:   {', '.join(pending)}")
    else:
        print("Pending:   none")
EOF
