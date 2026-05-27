#!/usr/bin/env bash
# quiz-skeleton.sh <workspace> <task-id>
# Create tasks/{id}/round1.md with activation log skeleton.
# Exits 0; prints path of created file.

WS="${1:?Usage: quiz-skeleton.sh <workspace> <task-id>}"
TASK_ID="${2:?Usage: quiz-skeleton.sh <workspace> <task-id>}"
OUT="$WS/.humanpowers/tasks/$TASK_ID/round1.md"

mkdir -p "$(dirname "$OUT")"

if [ -f "$OUT" ]; then
  echo "EXISTS: $OUT (not overwritten)"
  exit 0
fi

cat > "$OUT" <<EOF
# task-$TASK_ID round1.md

## Activation Log

| Dimension | Active? | Reason | Fork | Qs |
|-----------|---------|--------|------|----|
| Intent      | [FILL] | [FILL] | — | 0 |
| Observable  | [FILL] | [FILL] | — | 0 |
| Acceptance  | [FILL] | [FILL] | — | 0 |
| Constraint  | [FILL] | [FILL] | — | 0 |
| Assumption  | [FILL] | [FILL] | — | 0 |
| Dependency  | [FILL] | [FILL] | — | 0 |
| Edge        | [FILL] | [FILL] | — | 0 |
| Failure     | [FILL] | [FILL] | — | 0 |
| Decision    | [FILL] | [FILL] | — | 0 |

## Q bodies

<!-- Agent fills one Q body per active dimension cell below -->
EOF

echo "CREATED: $OUT"
