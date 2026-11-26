# Phase 0 constitution review

Prompt 00.01 review gate · 2026-11-25 · Owner approval pending

Sources are the [constitution](../../.specify/memory/constitution.md), [SRS](../requirements/SRS.md), [SAD](../architecture/SAD.md) and [Phase 0 prompts](Phase_0_Prompts.md).

## Conflicts and scope decisions

| Finding | Owner decision |
| --- | --- |
| SAD §4 proposes starting with core, UI, app and showcase. Prompts 00.02 and 00.04 scope the foundation to pure Dart core and a Flutter showcase. | Confirm the initial workspace members and the milestone for introducing the shared UI and app packages. |
| SRS §14 calls v0.1.0 “Foundation and core,” while SRS §13 and SAD §17 place the full core contracts in Phase 1. Prompt 00.14 permits a v0.1.0 recommendation after Phase 0. | Define the evidence and core capabilities required for the v0.1.0 tag. |
| SRS §§7 and 12 include mandatory showcase and production acceptance scenarios beyond Phase 0, including authentication and billing. Phase 0 excludes those capabilities and advanced UI. | Confirm the Phase 0 acceptance subset and the later milestones where dependent SRS requirements will be verified. Keep full production acceptance in force. |
| The baseline names BLoC/Cubit, GetIt, GoRouter and Firebase. Prompt 00.04 defers integrations and state or injection tooling unless justified. Constitution III still requires inward contracts, composition-root injection and BLoC/Cubit for nontrivial presentation state. | Confirm which baseline tools the minimal showcase needs, and document any deviation from approved architecture through an ADR. |

The generic Spec Kit test guidance conflicts with Constitution VI. The project task template and root agent guidance now explicitly require test-first sequencing for new or changed business behavior, regression tests for defects and all applicable mandatory tests. The generated skill still carries its generic default, so the root guidance explicitly addresses it.

## Approval and verification backlog

- **Baseline approval.** Ratify the constitution and approve the SRS and SAD baseline for Phase 0. Confirm the owner as ratifying and amendment authority. The constitution retains version 0.1.0 and its draft status. Remove the temporary sync report once reviewed and record ratification when approved.
- **Phase 0 decisions.** Confirm repository and workspace policy under ADR-001, Android/web milestone scope under ADR-015, and the compatibility and pinning approach for Flutter, Dart, Android and CI tooling. Resolve workspace layout, CI runners, applicable tests, coverage measurement and dependency checks during Phase 0 clarification and planning.
- **Distribution and licensing.** Decide when ADR-002 and ADR-013 must be approved. Prove private distribution with a clean external consumer before any release that relies on it. Confirm the licence and applicable third-party review before distribution.
- **Later dependent work.** ADR-003 through ADR-012 and ADR-014 remain proposed. Carry forward backend isolation, identity, tenancy, mobile and web billing, offline storage, generator tooling, subscription management, admin tooling, reference product and email. SAD §18 also leaves billing precedence and trial policy, retention and residency, package extraction thresholds, observability and budget, accessibility reference devices and release credential ownership open.

Review and record the baseline decisions before proceeding to prompt 00.02. Record each remaining decision before the work that depends on it.
