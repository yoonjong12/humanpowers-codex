#!/usr/bin/env bash
# find-workspace.sh
# Walk up from cwd to find .humanpowers/state.json.
# Output: WS=<path> PHASE=<phase> TARGET=<target_repo>
# Exit 1 if no workspace found.

DIR="$(pwd)"
WS=""
while [ "$DIR" != "/" ]; do
  if [ -f "$DIR/.humanpowers/state.json" ]; then
    WS="$DIR"
    break
  fi
  DIR="$(dirname "$DIR")"
done

if [ -z "$WS" ]; then
  echo "ERROR: no humanpowers workspace found (no .humanpowers/state.json above cwd)" >&2
  exit 1
fi

PHASE=$(python3 -c "import json; d=json.load(open('$WS/.humanpowers/state.json')); print(d.get('phase',''))" 2>/dev/null || echo "")
TARGET=$(python3 -c "import json; d=json.load(open('$WS/.humanpowers/state.json')); print(d.get('target_repo','null'))" 2>/dev/null || echo "null")
TASKS_TOTAL=$(python3 -c "import json; d=json.load(open('$WS/.humanpowers/state.json')); print(d.get('tasks_total',0))" 2>/dev/null || echo "0")
TASKS_BUILT=$(python3 -c "import json; d=json.load(open('$WS/.humanpowers/state.json')); print(d.get('tasks_built',0))" 2>/dev/null || echo "0")
TASKS_VERIFIED=$(python3 -c "import json; d=json.load(open('$WS/.humanpowers/state.json')); print(d.get('tasks_verified',0))" 2>/dev/null || echo "0")
TASKS_QUIZ_DONE=$(python3 -c "import json; d=json.load(open('$WS/.humanpowers/state.json')); print(d.get('tasks_quiz_done',0))" 2>/dev/null || echo "0")

echo "WS=$WS"
echo "PHASE=$PHASE"
echo "TARGET=$TARGET"
echo "TASKS_TOTAL=$TASKS_TOTAL"
echo "TASKS_BUILT=$TASKS_BUILT"
echo "TASKS_VERIFIED=$TASKS_VERIFIED"
echo "TASKS_QUIZ_DONE=$TASKS_QUIZ_DONE"
