# humanpowers

> Developer's design = load-bearing element. Agent = bounded executor.
> Inspired by [superpowers](https://github.com/obra/superpowers).

## What

Developer articulates intent first. Agent executes within that boundary.

- **superpowers**: AI does more, dev does less.
- **humanpowers**: dev designs actively, agent held to written spec.

Output predictability = f(developer design effort), not agent cleverness.

## When

- Need design phase surfacing ambiguity before code.
- Per-task specs doubling as test specs.
- Explicit gates: design -> build -> verify, dev signs off each.

Well-understood fast tasks -> plain superpowers or no plugin.

## Install

```
codex plugin marketplace add yoonjong12/humanpowers-codex
```

## Prerequisites

**Codex CLI** required.

**Node.js** optional — visual companion only (browser mockups/diagrams).

| OS | Install |
|----|---------|
| macOS | `brew install node` |
| Windows | `winget install OpenJS.NodeJS` |
| Linux | `sudo apt install nodejs` / `dnf` / `pacman` |

## Quick start

```
/humanpowers
```

- No workspace -> creates `.humanpowers/` (gitignored, local only) at repo root or cwd. Starts brainstorming.
- Workspace exists -> resumes current phase.

## Skills

| Skill | Description |
|-------|-------------|
| brainstorming | Problem definition through collaborative dialogue. Produces `problem.md`. |
| dispatching-parallel-agents | Methodology for working on 2+ independent tasks without shared state. |
| finishing-a-development-branch | Exit gate, ADR digest, merge/PR/keep/discard options, worktree cleanup. |
| humanpowers | Dispatcher: workspace creation, phase routing, subcommands. |
| operate | Task lead role: loads spec + plan, executes TDD steps, updates status. |
| quiz | 9-dimension perception-gap matrix per task. Locks as test spec for operate/verify. |
| receiving-code-review | Technical evaluation of review feedback. Verify before implementing. |
| requesting-code-review | Code review dispatch with focused context and git SHA workflow. |
| retrospective | Post-project learning extraction and consolidation into persistent learnings. |
| review | Project-level aggregate state review with cascade decisions. |
| subagent-driven-development | Sequential task execution with two-stage review (spec + quality). |
| systematic-debugging | Four-phase root cause investigation before attempting fixes. |
| test-driven-development | Red-green-refactor cycle. No production code without failing test first. |
| using-git-worktrees | Isolated workspace creation with directory selection and safety verification. |
| using-humanpowers | Session starter: privacy model, workflow overview, skill access. |
| verification-before-completion | Evidence before claims. Debrief pattern with developer-driven signoff. |
| writing-plans | Expands problem.md into tasks.md (item IDs) + per-task plan.md (TDD steps). |
| writing-skills | TDD for skills: pressure test, write, close loopholes. |

## Concepts

| Concept | Meaning |
|---------|---------|
| **Workspace** | `.humanpowers/` dir holding `problem.md`, `tasks.md`, per-task artifacts. Repo root (in-repo) or cwd (external). |
| **Privacy** | `.humanpowers/` gitignored. Only `docs/decisions/<slug>.md` committed. |
| **Task** | Atomic work slice: who, what, why, verify-how, NFRs. Has `action_type` + `depends_on` graph. |
| **Quiz** | Required step between brainstorm and plan. Agent drills dev on vague terms, edges, thresholds. Signed output = test spec. |
| **Dispatcher** | Single `/humanpowers` entry -> auto-routes by workspace state. |

## Workflow

```
brainstorm -> quiz -> plan -> operate -> verify -> review -> finish
```

| Phase | Does |
|-------|------|
| brainstorm | Articulate problem, decompose into tasks |
| quiz | Per-task elicitation -> test spec |
| plan | Task-by-task plan + pre-build gate |
| operate | Implement (TDD); `--batch` for remaining tasks |
| verify | Dev-watched demo per task, signed acceptance |
| review | Aggregate state, cascade decisions |
| finish | Write ADR digest, commit, optionally bump version |

Manual control:

```
/humanpowers-help                 # show command + phase reference
/humanpowers continue            # resume current phase
/humanpowers jump <phase>        # skip ahead (warns if skipping a gate)
/humanpowers operate <task-id>   # work on one specific task
/humanpowers operate --batch     # work on all remaining unbuilt tasks
/humanpowers review              # project-level review
/humanpowers abort               # mark workspace aborted
```

## Docs

- `docs/specs/` — design specs.
- `docs/plans/` — implementation breakdown.
- `docs/decisions/` — ADR digests (finish phase).

## License

MIT
