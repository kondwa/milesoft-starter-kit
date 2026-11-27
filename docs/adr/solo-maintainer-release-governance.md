# ADR — Solo Maintainer Release Governance

**Status** — Approved by the project owner on 2026-11-27. GitHub configuration and enforcement verification are pending.

## Context

The starter kit currently has one maintainer. GitHub requires one approving review on `main`, and the release evidence calls for independent approval and licence review. The [risk-based quality amendment](internal-release-quality.md) supersedes separate PR-head attestation with a consolidated version-bound owner review for eligible internal releases. The maintainer needs a review process that can operate with one person while preserving the controls in [Constitution VI, VII and XII](../../.specify/memory/constitution.md) and the failed-check merge gate in [SRS DEV-004](../requirements/SRS.md).

## Decision

- For internal, non-production Phase 0 and Phase 1 releases, allow the project owner to record a consolidated version-bound self-review when an independent reviewer is unavailable. Identify the owner, release version, source revisions and supporting PR, CI and acceptance evidence, unresolved findings and disposition. Reassess material changes to scope or evidence.
- Require a separate licence finding in the review record for added or changed third-party dependencies. Record when there are no dependency changes. Unknown or incompatible terms remain a release blocker until the owner records their disposition.
- Keep PRs into `main`, the required **Phase 0 quality** check from GitHub Actions and administrator enforcement. Preserve all required tests, builds, scans and acceptance criteria. Keep the controlled failing-check demonstration and subsequent passing cleanup run. An owner self-review is recorded as such in the PR and release evidence.
- Retain independent review for changes to security or access controls, credential handling, payment or entitlement integrity, production deployment, and external distribution or licensing policy. When that review is unavailable, hold the affected release.
- Require the owner to authorize each release against its exact source SHA. Tagging, publication and deployment require separate authorization. External distribution remains subject to ADR-002, ADR-013 and the applicable consumer verification.

## Adoption and verification

In GitHub **Settings → Branches**, edit the classic rule for `main`. Keep **Require a pull request before merging** enabled and turn off its **Require approvals** option. Keep **Require status checks to pass before merging**, **Phase 0 quality** from GitHub Actions, **Require branches to be up to date before merging**, conversation resolution and **Do not allow bypassing the above settings**. Keep force pushes and branch deletion disabled. [GitHub branch protection settings](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule)

The classic approval setting applies to the whole branch. The owner must enforce the independent-review requirement for the excluded changes before merging them. Record the eligible self-review in the consolidated release report, then link it from the acceptance record. If independent review must be enforced by GitHub for the excluded changes, agree a scoped enforcement mechanism before disabling the branch-wide approval option.

Verify the saved classic protection and active rulesets, then demonstrate that a failed mandatory check blocks a normal merge without bypass. Record the owner review only after the candidate's applicable acceptance evidence is complete.

This decision addresses the review approval requirement. T034, controlled failure evidence and any other incomplete release criteria still require their own evidence.
