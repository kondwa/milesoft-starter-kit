# Feature Specification: Phase 1 Core and Design System

**Feature branch** — Current working branch `main`

**Created** — 2026-11-26

**Status** — Approved on 2026-11-26. Phase 0 evidence remains open under the [owner disposition](research.md#owner-approvals).

**Input** — [Phase 1 prompt 01.02](../../docs/development/Phase_1_Prompts.md)

## Clarifications

### Session 2026-11-26

- Q: May Phase 1 specification and planning proceed while the Phase 0 Android launch, fresh-checkout walkthrough, and PR merge-enforcement evidence remain open? → A: Yes. Phase 1 specification and planning may proceed. Keep Phase 0 acceptance criteria open until verified or explicitly resolved. Implementation and release gates still apply.

- Q: Which localisation requirements should Phase 1 deliver? → A: Include LOC-005 string externalisation and CFG-005 product locale defaults. Deliver the remaining LOC requirements in Phase 3.

- Q: Which public core contract should Phase 1 adopt? → A: Preserve `normalizeLabel(String)`. Return typed failures with stable codes for expected validation, authorization, and transient errors. Propagate unexpected exceptions. Use bounded offset pagination. Retry only explicitly safe operations after a classified transient failure.

- Q: Which configuration sources should take precedence at startup? → A: The selected environment overrides product defaults. Tests may supply explicit overrides, which take precedence in tests. Validate the merged configuration before startup.

- Q: Which platforms and accessibility checks should Phase 1 require for the themed showcase? → A: Require Android and web. Allow products to override semantic colors and typography in light and dark themes. System mode follows the host. Use approved MileSoft assets when available and accessible “Powered by MileSoft” text otherwise. Check semantics, contrast, touch targets and web keyboard navigation at 320 and 1280 logical pixels, at default and 200% text scaling.

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Use shared core contracts (Priority: P1)

An application developer uses shared contracts for operation outcomes, input validation, paged results, time, identifiers, logging, and retry decisions. This makes behavior consistent across products and testable without a UI or live services.

**Independent test** — Exercise the public contracts from a Dart-only consumer with deterministic fixtures.

- **CORE-1** — Consumers distinguish success from typed validation, authorization and transient failures with stable codes. Field errors identify the relevant fields and messages are safe for display. Unexpected exceptions propagate.
- **CORE-2** — A valid filter, offset and page size return matching items in the expected order. Empty and terminal pages end traversal. Invalid offsets and page sizes produce a documented validation outcome.
- **CORE-3** — Given a fixed clock and a deterministic identifier source, repeated tests produce the expected timestamps and IDs. A captured log contains the expected level and structured fields without including the fixture’s sensitive values.
- **CORE-4** — An explicitly retry-safe operation retries only after a classified transient failure, up to the configured attempt limit. Unsafe operations, validation failures and authorization failures each get one attempt. Tests control delay without waiting.

### User Story 2 — Configure a product and its environments (Priority: P1)

An application developer supplies product defaults and selects an environment. Startup detects missing or malformed mandatory values before dependent features can run.

**Independent test** — Start a consumer with development, staging and production fixtures, then repeat with missing, malformed and conflicting values.

- **CONFIG-1** — Valid fixtures expose the expected application name and identifier, branding, language, currency, region, and legal and support URLs. The selected environment overrides conflicting product defaults. Explicit test overrides take precedence in tests. Unselected environments contribute no values.
- **CONFIG-2** — Before dependent features start, validate the merged configuration. Missing and malformed required values produce safe diagnostics identifying the offending fields. Disabling an optional module leaves unrelated functionality available. Client flags grant no privileged access.

### User Story 3 — Use accessible components in the showcase (Priority: P1)

A showcase visitor browses the component catalogue, switches themes, and tries a form and interactive controls at narrow and wide sizes. A product developer can reuse those controls with the product’s own colors and type styles.

**Independent test** — Open the showcase with local fixtures and exercise controls using Android touch and web keyboard input.

- **UI-1** — Light and dark selections apply immediately. System mode follows the host setting. Product overrides for semantic colors and typography reach representative controls in both light and dark themes, and shared spacing, elevation and radius roles apply consistently.
- **UI-2** — A labelled text field supports entry, validation feedback, disabled and read-only states. Labelled checkboxes, switches, radio groups and dropdowns support keyboard interaction, disabled states and form validation. Buttons and dialogs respond to keyboard focus and activation. A loading button suppresses duplicate activation. A card and a notification demonstrate the shared theme and appropriate semantics.
- **UI-3** — Loading, empty, success and error examples are distinguishable through text or semantics. The recoverable error example provides a working retry action and displays safe, externalised text.
- **UI-4** — On Android and web, representative controls and catalogue navigation remain visible and operable at 320 and 1280 logical pixels at default and 200% text scaling. For internal pre-1.0, sample meaningful semantic names and states, form validation, visible keyboard focus, contrast and touch targets across those profiles. Confirmed critical accessibility defects block release. Record exhaustive checks in the [quality backlog](../../docs/development/Release_Quality_Backlog.md).
- **UI-5** — Every delivered shared capability has a discoverable catalogue example using deterministic data. The existing core-derived showcase label remains covered. The branding example uses approved MileSoft assets when available and accessible “Powered by MileSoft” text otherwise.

### Edge Cases

- Empty or whitespace-only labels retain the Phase 0 contract. Pagination tests include empty data, terminal continuation and values outside approved bounds.
- Retry tests cover immediate success, exhaustion and ineligible operations. Unexpected errors retain enough diagnostic context for debugging without disclosing private data to the caller-facing UI.
- Configuration tests include missing values, malformed URLs, conflicting configuration sources and flags that disable optional behavior.
- Showcase tests include long caller-supplied labels, system appearance changes, narrow layouts, scaled text, keyboard-only use and loading-state reactivation. RTL verification belongs to Phase 3 under LOC-008.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001** — Provide documented pure Dart contracts for expected operation outcomes, exception handling, validation, pagination and filtering. Keep Flutter, Firebase, payment SDKs and product dependencies outside core.
- **FR-002** — Provide time and identifier contracts with deterministic substitutes, privacy-safe structured logging, and bounded retry behavior for explicitly safe operations.
- **FR-003** — Support immutable, environment-specific application configuration, product identity and defaults, optional-module flags and validation of the merged values before dependent features start.
- **FR-004** — Provide reusable Material 3 semantic tokens and light, dark and system themes with product branding and theme overrides.
- **FR-005** — Provide reusable forms, buttons, cards, dialogs, notifications and loading, empty, success and error presentations. Apply responsive behavior and accessible navigation, interaction and feedback.
- **FR-006** — Demonstrate all delivered capabilities in the existing showcase, including approved MileSoft attribution and representative theme and layout variants.

### Key Entities

- **Operation outcome and validation issue** — A success value or an expected failure, with field associations where applicable and diagnostics suitable for their audience.
- **Page request and page** — A bounded selection and its results, with filtering and continuation under the approved semantics.
- **Product configuration** — Product identity, environment, presentation defaults, support links, and flags.
- **Theme and catalogue example** — Semantic appearance settings and a discoverable demonstration of a shared capability or state.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001** — All CORE-1 through CORE-4 scenarios pass using deterministic unit or contract tests. The boundary check passes and shared business logic reaches at least 80% coverage.
- **SC-002** — CONFIG-1 and CONFIG-2 pass for all three environment fixtures, including invalid input, precedence and module isolation cases.
- **SC-003** — UI-1 through UI-5 pass. The catalogue demonstrates every delivered capability, all three theme choices and all four status presentations. Record automated checks and representative manual accessibility findings separately. Use the internal pre-1.0 scope in the [quality amendment](../../docs/adr/internal-release-quality.md).
- **SC-004** — Record passing formatting, analysis, tests, dependency checks, Android debug and web builds, and applicable remote CI. Carry applicable Phase 0 gaps forward. Trace any approved equivalent CI evidence and link the consolidated version-bound owner review and licence disposition.

## Scope and Traceability *(mandatory)*

| SRS ID | Feature requirement | Acceptance | Planned verification |
| --- | --- | --- | --- |
| COR-001 | FR-001 | CORE-1 | Unit tests for success and expected failure |
| COR-002 | FR-001 | CORE-1 | Exception propagation and safe message tests |
| COR-003 | FR-001 | CORE-1 | Valid and invalid field input tests |
| COR-004 | FR-001 | CORE-2 | Filter, bounds and continuation tests |
| COR-005 | FR-002 | CORE-3 | Time and identifier behavior tests |
| COR-006 | FR-002 | CORE-3 | Structured log capture and sensitive-data tests |
| COR-008 | FR-002 | CORE-4 | Fake-delay retry, exhaustion and ineligibility tests |
| COR-009 | FR-002 | CORE-3 | Injected clock and identifier contract tests |
| CFG-001 | FR-003 | CONFIG-1 | Name and identifier fixture tests |
| CFG-002 | FR-003, FR-004 | CONFIG-1, UI-1 | Product branding and theme override tests |
| CFG-003 | FR-003 | CONFIG-1 | Three-environment isolation tests |
| CFG-004 | FR-003 | CONFIG-2 | Module disablement and unrelated capability tests |
| CFG-005 | FR-003 | CONFIG-1 | Language, currency and region default tests |
| CFG-006 | FR-003 | CONFIG-1, CONFIG-2 | Valid and malformed legal and support URL tests |
| CFG-007 | FR-003 | CONFIG-2 | Startup failure and safe diagnostic tests |
| UI-001 | FR-004 | UI-1 | Theme and representative component tests |
| UI-002 | FR-004 | UI-1 | Light, dark and host appearance tests |
| UI-003 | FR-004 | UI-1 | Semantic color and typography override tests |
| UI-004 | FR-004 | UI-1 | Spacing, elevation and radius role checks |
| UI-005 | FR-005 | UI-2 | Text, checkbox, switch, radio and dropdown form input, validation and field-state tests |
| UI-006 | FR-005 | UI-2 | Button, card, dialog and notification widget tests |
| UI-007 | FR-005 | UI-3 | Four-state rendering, semantics and recovery tests |
| UI-008 | FR-005 | UI-4 | Narrow, wide and text-scale layout tests |
| UI-009 | FR-005 | UI-2, UI-4 | Catalogue focus and keyboard walkthrough |
| UI-010 | FR-006 | UI-5 | Approved branding and attribution semantics check |
| UI-011 | FR-006 | UI-5 | Catalogue navigation and capability inventory |
| ARC-006, ARC-007, ARC-008 | FR-001, FR-004 | SC-001 | Source imports and resolved dependency graph inspection |
| ARC-002 | Phase package quality | SC-004 | Independent versions and API review in T014 and T036 |
| ARC-011 | Phase package quality | SC-004 | Compatible constraints and locked resolution in T014 and T036 |
| NFR-SEC-009 | Phase quality gates | SC-004 | Pinned lockfile scan and acceptance evidence in T037 and T038 |
| LOC-005 | FR-005, FR-006 | UI-3, UI-5 | Externalised catalogue strings and caller-supplied component text |
| SHW-001, SHW-002, SHW-006, SHW-007, SHW-008, SHW-009 | FR-006 | UI-1, UI-3, UI-4, UI-5 | Catalogue, theme, localization resources, layout and regression checks |
| NFR-ACC-001 through NFR-ACC-006 | FR-004, FR-005, FR-006 | UI-2, UI-3, UI-4, SC-003 | Applicable contrast, non-color cues, semantics, text scaling, keyboard and target-size checks |
| DEV-001, DEV-002, DEV-003, DEV-004, AC-018 | Phase quality gates | SC-004 | CI results, required-check enforcement evidence and platform builds |

Acceptance scenario IDs carry into tests and ordered tasks during prompts 01.04 and 01.05.

**Exclusions and later milestones** — Authentication, profiles, Firebase, billing, entitlements, application shell, persistent theme and language preferences, and generator or CLI work remain in their SRS roadmap phases. Theme selection here covers the live showcase session. Phase 1 includes LOC-005 string externalisation and CFG-005 product locale defaults. Phase 3 retains LOC-001 through LOC-004 and LOC-006 through LOC-010, including locale-aware formatting, language selection and RTL support. Propose leaving connectivity monitoring (COR-007), remote flags and version or maintenance controls (CFG-008, CFG-009 and CFG-010), and dashboard/reporting widgets (UI-012) for later scope approval. These exclusions preserve applicable release requirements, including persisted theme and language scenarios AC-005 and AC-006.

### **Open decisions for the owner**

1. **Baseline and release sequence.** The owner approved the SRS/SAD working baseline and scoped v0.1.0 to the foundation and existing core API. The expanded core, configuration and UI target v0.2.0. The [original implementation disposition](research.md#owner-approvals) records the previous Phase 0 gaps. Use the [amended Phase 0 acceptance record](../001-project-foundation/acceptance.md) for current status.
2. **Scope and dependencies.** The owner approved local in-app notifications for 01.17 under UI-006 and the success state for 01.18 under UI-007. The requested 01.21 catalogue includes accessible navigation under UI-009. The workspace extension is approved. Retain standalone material_ui in the showcase. The owner approved a direct standalone material_ui dependency for milesoft_ui in 01.13. Record the Phase 1 platform decisions in the applicable ADR. Owner approval of ADR-002 and ADR-013 remains a prerequisite for dependent private distribution.

The clarification log records approved decisions. The owner approved the pagination limits, filter and continuation semantics, retry defaults, workspace extension in the [approval register](research.md#increment-approvals-for-0109-through-0121). Remaining proposals include detailed transient classification and allocation of UI acceptance requirements across increments. Review these details before dependent implementation.

## Assumptions

- Android and web are the approved Phase 1 targets. The Phase 0 toolchain pins are approved for Phase 1.
- The catalogue can exercise all approved Phase 1 capabilities with local fixtures. Existing Phase 0 behavior remains covered unless the owner approves a documented migration.
