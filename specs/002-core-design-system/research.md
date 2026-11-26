# Design research and decision records

## Approved through Phase 1 clarification

The owner approved additive compatibility for normalizeLabel, typed expected failures and immediate propagation of unexpected exceptions, bounded offset pagination, and retries limited to explicitly safe operations after classified transient failures. Selected environment values override product defaults, with explicit test-only overrides. Android and web, semantic theme overrides, text attribution fallback and the 320/1280 width and default/200% scale checks are approved. Phase 1 applies LOC-005 and CFG-005 while broader localisation remains in Phase 3. The owner authorised planning while leaving Phase 0 acceptance open.

## Proposed contracts

The owner approvals below supersede earlier pending status for the working baseline, release scope, toolchain and 01.07 contract.

| Proposal | Rationale and alternatives |
| --- | --- |
| Zero-based offset, explicit size 1–100 and nullable next offset | Caller applies its typed filter before slicing and supplies stable order. Explicit continuation avoids guessing from a full page. Cursor pagination and a generic query language add contracts without a Phase 1 consumer. |
| Three total attempts for opted-in safe work, 100 ms initial delay doubled with a 1 s cap | A deterministic bounded policy is easy to exercise with injected delay. A classified transient failure is eligible, while validation and authorization failures are terminal. No global retries or catch-all conversion. Propose no cancellation API in this phase. |
| Merge named config fields and merge flags by key | Preserve the distinction between absent and invalid winning values. Validate the final configuration once. Explicit constructor/factory inputs keep testing and environment selection reproducible. |
| SDK types and widgets for the UI surface | Material primitives provide behavior and semantics. Direct dependency on core would couple configuration and validation representations to presentation when caller-provided fields and callbacks suffice. |

## ADR and owner review register

| Decision | Status, rationale and consequence |
| --- | --- |
| ADR-001 scope extension | Proposed. Add milesoft_ui as a third workspace member with its own package version and the existing root lockfile. Separate workspaces would duplicate resolution and lose immediate compatibility checks. Record owner approval before changing membership. |
| ADR-015 Phase 1 application | Android/web and the layout matrix are approved in the spec. Record an ADR addendum and name the reference Android form factors and browser before acceptance. Other platforms retain their own milestones. |
| Phase 0 toolchain ADR | Existing pins approved for Phase 1 under 3A. |
| Core/config policy and UI boundary | Proposed as a Phase 1 ADR covering the policy defaults above and the independent SDK-only UI boundary. Confirm limits, failure codes and UI ownership before dependent implementation. |
| Showcase material_ui | Propose using Flutter Material directly for catalogue migration and dropping the extra package if parity and import review pass. Retention requires a documented rationale and licence review. |
| ADR-002 and ADR-013 | Deferred for dependent distribution and licensing. In-repo workspace validation can proceed after baseline and package approvals. External distribution requires approvals and clean consumer evidence. |
| SRS/SAD working baseline and releases | Approved under 1A. The Phase 0 findings remain open under 2A. |

## Owner approvals

- **1A — Approved 2026-11-26.** Use the SRS and SAD as the Phase 1 working baseline with the five recorded clarifications. Approve the revised specification, plan and 38 tasks. Version 0.1.0 covers the foundation and existing label API. Expanded core, configuration and UI target v0.2.0.
- **2A — Approved 2026-11-26.** Allow Phase 1 implementation with Phase 0 SC-002, SC-003 and SC-004 unverified. This covers Android launch, the standard fresh-checkout Android build and outstanding PR evidence, including merge enforcement. While GitHub Free prevents enforcement, review CI manually before merging and record PR results and applicable licence review. Failed checks can otherwise be bypassed, and Android defects may remain undiscovered. Keep tracking and collecting evidence. This exception expires at 01.24. Any remaining gap requires a separate owner decision before recommending release.
- **3A — Approved 2026-11-26.** Retain the Phase 0 SDK and toolchain pins. Apply the [approved result and failure ADR](../../docs/adr/phase-1-result-failure.md) at 01.07.

Exact pagination and retry defaults, the UI workspace extension and the showcase dependency decision remain subject to approval before their respective increments.
