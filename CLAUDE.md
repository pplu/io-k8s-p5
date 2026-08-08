# CLAUDE.md — IO::K8s

Perl object model of the Kubernetes API (tracking upstream v1.36). Moo + Type::Tiny; the
~744 API and CRD classes under `lib/IO/K8s/` are checked in and hand-maintained — there is
no build-time codegen step.

Build and test: `dzil build`, `dzil test`, `dzil clean`. While iterating: `prove -lr t/`
(**`-r` is required** — plain `prove -l t/` is not recursive). Never `dzil release` without
explicit permission; this distribution is co-maintained (`authority = cpan:JLMARTIN`).

## Delegation

Delegate behavior-relevant code to the right agent instead of touching it yourself — the
principle, the lanes and this repo's hazards are in `.claude/rules/io-k8s-rules.md`.

| Task | Agent |
|---|---|
| Implement / refactor / debug anything under `lib/` | `io-k8s-worker` (default) |
| Write or extend tests in `t/` | `io-k8s-test-writer` |
| POD, on the core or the API classes | `io-k8s-doc-writer` |
| Pre-release audit | `io-k8s-release-checker` |

`io-k8s-doc-writer` is this repo's documentation lane — it replaces the generic
`pod-writer` mentioned in the workspace `CLAUDE.md`.

The agents carry their conventions via `briefing.skills` (see `.claude/agents/`); the main
agent delegates rather than loading them. Skill sources live in `.claude/skills/` —
`io-k8s-core` holds the distribution internals, `perl-kubernetes-classes` the consumer-facing
API. Work is tracked on the local `karr` board.
