# ADR — Risk-based quality for internal pre-1.0 releases

**Status** — Approved by the project owner on 2026-11-27.

## Context and decision

Internal releases support incremental delivery to a limited audience. Their acceptance evidence should cover the delivered capabilities and material risks. This amendment changes the active gate for internal pre-1.0 releases, including v0.1.0 and v0.2.0. Historical criteria and results remain part of the release record.

- **Accessibility.** Verify representative responsive layout and navigation on supported Android and Chrome profiles, default and enlarged text scaling, meaningful names and states, form validation, visible keyboard focus, contrast and pointer or touch targets. Keep applicable thresholds from the phase quickstart. Use representative controls and states with platform and automated evidence. A confirmed critical accessibility defect blocks release. Track exhaustive contrast and target measurements, full keyboard traversal, exhaustive modal interaction and spoken screen-reader verification as future work.
- **CI and merge governance.** Require PRs, passing automated CI, effective branch protection, security and licence checks, and evidence that a failed required check blocks merging. Equivalent current evidence satisfies the historical Phase 0 PR CI gate when the record ties it to the original foundation scope, passing Phase 0 checks and current superset checks and shows verified enforcement. Do not reopen historical PRs solely to reproduce that evidence.
- **Owner review.** Consolidate review and licence disposition into one owner record per intended release version, or one report with a distinct decision for each version. Record source revisions and the PR, CI and acceptance evidence relied on for traceability. Reassess material changes to the reviewed scope or evidence before release. Separate attestations on individual PR heads are no longer the internal release gate. The [solo-maintainer ADR](solo-maintainer-release-governance.md) continues to govern when owner review is allowed and when independent review is required.

## Release maturity

| Release class | Additional requirements |
| --- | --- |
| Internal pre-1.0 | Use the proportionate evidence above. Retain test-first practice, approved phase acceptance, applicable CI, coverage, security and licence gates, and the owner's version-bound review and release authorization. |
| Public beta | Before opening access, approve a documented supported-platform and accessibility test matrix, verify representative end-to-end onboarding and recovery where delivered, and document known limitations, support and feedback channels, privacy and security handling, and rollback or recovery. Close applicable backlog items or document an owner-approved disposition consistent with the release's obligations. |
| pub.dev distribution | Approve ADR-002 and ADR-013 and verify package contents, licence and notices, version constraints, public API documentation, publishing checks and installation and tests from a clean external consumer. Resolve either ADR earlier if another mandatory dependency requires it. |
| Stable production | Complete applicable SRS acceptance and accessibility compliance, supported-platform, security and privacy verification, and applicable payment integrity checks. Verify monitoring, incident ownership, backup and recovery, rollback or forward recovery, and obtain explicit production deployment approval. |

Apply the combined gates when more than one class applies. Legal, licensing, privacy and platform obligations apply to every class where relevant. Publishing, tagging and deployment require explicit owner authorization.

## Adoption

Update Constitution VI, X and XII, the SRS and SAD, Phase 0 SC-003/T017, Phase 1 UI-4/SC-003/T034, the platform and solo-maintainer ADRs, and the current release registers. Record deferred work in the [quality backlog](../development/Release_Quality_Backlog.md). The [consolidated review](../development/Internal_Release_Review.md) carries the release decisions and licence dispositions. Policy approval records the new criteria. The owner records release decisions separately.
