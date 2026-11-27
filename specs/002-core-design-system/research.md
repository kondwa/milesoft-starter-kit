# Design research and decision records

## Approved through Phase 1 clarification

The owner approved additive compatibility for normalizeLabel, typed expected failures and immediate propagation of unexpected exceptions, bounded offset pagination, and retries limited to explicitly safe operations after classified transient failures. Selected environment values override product defaults, with explicit test-only overrides. Android and web, semantic theme overrides, text attribution fallback and the 320/1280 width and default/200% scale checks are approved. Phase 1 applies LOC-005 and CFG-005 while broader localisation remains in Phase 3. The owner authorised planning while leaving Phase 0 acceptance open.

## Contract decisions and proposals

The owner approvals below supersede earlier pending status for the working baseline, release scope, toolchain and 01.07 contract.

| Decision or proposal | Rationale and alternatives |
| --- | --- |
| Approved. Zero-based offset, explicit size 1–100 and nullable next offset | Caller applies its typed filter before slicing and supplies stable order. Explicit continuation avoids guessing from a full page. Cursor pagination and a generic query language add contracts without a Phase 1 consumer. |
| Approved. Three total attempts for opted-in safe work, 100 ms initial delay doubled with a 1 s cap | A deterministic bounded policy is easy to exercise with injected delay. A classified transient failure is eligible, while validation and authorization failures are terminal. No global retries or catch-all conversion. Propose no cancellation API in this phase. |
| Approved. Merge named config fields and merge flags by key | Preserve the distinction between absent and invalid winning values. Validate the final configuration once. Explicit constructor/factory inputs keep testing and environment selection reproducible. |
| UI workspace structure approved. The direct standalone material_ui dependency is approved for 01.13. | Material primitives provide behavior and semantics. Direct dependency on core would couple configuration and validation representations to presentation when caller-provided fields and callbacks suffice. |

## ADR and owner review register

| Decision | Status, rationale and consequence |
| --- | --- |
| ADR-001 scope extension | Approved. See the Phase 1 addendum to [ADR-001](../../docs/adr/ADR-001-workspace.md#phase-1-extension). |
| ADR-015 Phase 1 application | Android/web and the layout matrix are approved in the spec. Record an ADR addendum and name the reference Android form factors and browser before acceptance. Other platforms retain their own milestones. |
| Phase 0 toolchain ADR | Existing pins approved for Phase 1 under 3A. |
| Core/config policy and UI boundary | Result and failure, pagination, retry, [application configuration](../../docs/adr/phase-1-app-config.md) and the revised UI runtime dependency are approved. |
| Showcase material_ui | Retain the existing standalone dependency at 01.21 under the owner correction. Verify catalogue regressions and localisation. |
| ADR-002 and ADR-013 | Deferred for dependent distribution and licensing. In-repo workspace validation can proceed after baseline and package approvals. External distribution requires approvals and clean consumer evidence. |
| SRS/SAD working baseline and releases | Approved under 1A. The Phase 0 findings remain open under 2A. |

## Owner approvals

- **1A — Approved 2026-11-26.** Use the SRS and SAD as the Phase 1 working baseline with the five recorded clarifications. Approve the revised specification, plan and 38 tasks. Version 0.1.0 covers the foundation and existing label API. Expanded core, configuration and UI target v0.2.0.
- **2A — Approved 2026-11-26.** Allow Phase 1 implementation with Phase 0 SC-002, SC-003 and SC-004 unverified. This covers Android launch, the standard fresh-checkout Android build and outstanding PR evidence, including merge enforcement. While GitHub Free prevents enforcement, review CI manually before merging and record PR results and applicable licence review. Failed checks can otherwise be bypassed, and Android defects may remain undiscovered. Keep tracking and collecting evidence. This exception expires at 01.24. Any remaining gap requires a separate owner decision before recommending release.
- **3A — Approved 2026-11-26.** Retain the Phase 0 SDK and toolchain pins. Apply the [approved result and failure ADR](../../docs/adr/phase-1-result-failure.md) at 01.07.

### Increment approvals for 01.09 through 01.21

The owner approved all five decisions on 2026-11-26.

1. Use zero-based offsets and page sizes of 1–100. Report negative offsets and out-of-range sizes as typed validation failures.
2. Let callers apply typed filters and a stable sort before paging. The data source supplies explicit continuation. Return a nullable nextOffset, with null for empty or terminal pages. Page length alone does not establish continuation.
3. Allow three total attempts for explicitly retry-safe operations after classified transient failures. Start at 100 ms and double each delay up to 1 s. Inject delay for tests. Return the final typed failure on exhaustion and propagate unexpected exceptions.
4. Add independently versioned milesoft_ui to the root workspace with a Flutter SDK runtime dependency. The showcase composes UI and core.
5. Superseded on 2026-11-26 after owner review. Retain the existing standalone material_ui dependency at 01.21. Flutter 3.50 formally deprecated its bundled Material library. The owner separately approved declaring standalone material_ui directly in milesoft_ui on 2026-11-26 so its Material types align with the showcase. This supersedes the earlier Flutter-SDK-only dependency scope. [Flutter migration guide](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)

See the [pagination and retry ADR](../../docs/adr/phase-1-pagination-retry.md) and [workspace ADR](../../docs/adr/ADR-001-workspace.md#phase-1-extension).

### Configuration approval for 01.12

On 2026-11-26 the owner approved all three configuration decisions: field-by-field precedence and per-key flag merging, the required settings and validation rules, and boolean flags disabled by default when absent. The [application configuration ADR](../../docs/adr/phase-1-app-config.md) records the approved rules.

### Design token approval for 01.14

On 2026-11-26 the owner approved provisional Material 3 defaults with seed #2563EB, default Material 3 typography and per-mode product overrides. The approved logical-pixel scales are spacing 4/8/16/24/32, radius 4/8/16 and elevation 0/1/3. Verify default semantic color contrast in light and dark modes. The seed is a provisional design value.

### Form controls extension for 01.16

On 2026-11-26 the owner approved adding shared checkbox, switch, radio group and dropdown form controls under UI-005. Each uses caller-localised labels and validation messages and supports disabled and keyboard interaction through Material primitives. Add catalogue examples in 01.21. Shared date selection remains outside this extension.

### Notification approval for 01.17

On 2026-11-26 the owner approved an accessible local in-app notification in 01.17 under UI-006. Use Material SnackBar with caller-localised text.

### Success state approval for 01.18

On 2026-11-26 the owner approved including success with loading, empty and recoverable error in 01.18 under UI-007. The shared view accepts localised status text and an optional action.

### Branding approval for 01.20

On 2026-11-26 the owner approved the text-only Powered by MileSoft fallback for 01.20. The repository inspection found no approved brand asset. The widget takes a localised label and uses semantic theme text. Catalogue integration belongs to 01.21.
