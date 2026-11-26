# Tasks — Phase 1 Core and Design System

**Status** — Approved on 2026-11-26. All tasks are pending.

**Inputs** — [Specification](spec.md), [plan](plan.md), [decisions](research.md), [data model](data-model.md), [public contracts](contracts/public-api.md), and [acceptance commands](quickstart.md).

## Setup and foundational gates

Use the existing workspace. The 01.06 review and remediation are complete and the owner approved the Phase 1 specification, plan, task list and working baseline. Record owner approvals and applicable ADR decisions in docs/adr before dependent work, including core and configuration contracts before their respective increments. T036 reviews these records for completeness. Confirm the workspace extension before 01.13, and settle the showcase dependency disposition before 01.21. The [approved implementation disposition](research.md#owner-approvals) keeps Phase 0 SC-002, SC-003 and SC-004 open and expires at 01.24. Obtain a separate owner decision on any remaining gap before recommending release. Distribution remains subject to ADR-002 and ADR-013.

Paths are repository-relative. For each increment, run only its approved work. Run the listed behavioural tests before production changes and record the expected failing assertion or missing API, then rerun them after implementation. Defect fixes require regression tests. No test-first exception is assumed. Record any explicitly approved sequencing exception and run the required tests before merge.

At every implementation checkpoint, run targeted verification plus the applicable common checks in [quickstart.md](quickstart.md). Before the UI member exists, omit it from the formatter paths. Analyse from root. Record the commit, command, working directory, exit status and failed or skipped checks in the increment evidence. Mark a test-first task complete after red and green evidence exists. Stop for review at each numbered heading.

## US1 — Shared core contracts

**Independent acceptance** — CORE-1 through CORE-4 pass from a Dart-only consumer and the existing label contract still passes. This is the first independently testable delivery.

### 01.07 — Result and failure

- [ ] T001 [US1] Add failing outcome, nullable success, mapping, propagation, shared field issue, safe diagnostics and unexpected exception tests in packages/milesoft_core/test/result_test.dart (COR-001, COR-002 · CORE-1).
- [ ] T002 [US1] Implement approved contracts in packages/milesoft_core/lib/src/result.dart and export through packages/milesoft_core/lib/milesoft_core.dart. Define and export ValidationIssue in 01.07. Apply Result.branch, Result.value, Failure.code, Failure.fieldIssues, ValidationIssue.code and ValidationIssue.fieldKey from [data-model.md](data-model.md). Preserve normalizeLabel and run dart test from packages/milesoft_core (COR-001, COR-002 · CORE-1).

### 01.08 — Use cases and validation

- [ ] T003 [US1] Add failing synchronous/asynchronous use-case, expected failure and field validation tests in packages/milesoft_core/test/use_case_validation_test.dart (COR-001, COR-003 · CORE-1).
- [ ] T004 [US1] Implement function-friendly UseCase and Validator in packages/milesoft_core/lib/src/use_case.dart and packages/milesoft_core/lib/src/validation.dart. Reuse the ValidationIssue type delivered in T002. Verify Validator returns those same structured issues. Update the public barrel and run dart test from core (COR-001, COR-003 · CORE-1).

### 01.09 — Pagination and filtering

- [ ] T005 [US1] Add failing tests for invalid bounds, immutability, stable filter/order and first, empty and terminal pages in packages/milesoft_core/test/pagination_test.dart (COR-004 · CORE-2).
- [ ] T006 [US1] Implement and export packages/milesoft_core/lib/src/pagination.dart with PaginationParams.offset, PaginationParams.size, Page.items and Page.nextOffset from [data-model.md](data-model.md) after exact bounds and filter semantics are approved. Run dart test from core (COR-004 · CORE-2).

### 01.10 — Clock, identifiers and logging

- [ ] T007 [P] [US1] Add failing UTC time and deterministic identifier tests in packages/milesoft_core/test/clock_id_test.dart (COR-005, COR-009 · CORE-3).
- [ ] T008 [P] [US1] Add failing severity, structured field and private-data exclusion tests in packages/milesoft_core/test/logger_test.dart (COR-006 · CORE-3).
- [ ] T009 [US1] Implement contracts and deterministic fixtures in packages/milesoft_core/lib/src/clock.dart, packages/milesoft_core/lib/src/id_generator.dart, packages/milesoft_core/lib/src/logger.dart and packages/milesoft_core/test/support/core_fakes.dart. Apply the documented UTC, identifier and log-field guarantees. Update the public barrel and run dart test from core (COR-005, COR-006, COR-009 · CORE-3).

### 01.11 — Retry policies

- [ ] T010 [US1] Add failing fake-delay tests for immediate success, safe transient recovery, exhaustion, bounded backoff, unsafe and terminal failures, and unexpected exceptions in packages/milesoft_core/test/retry_policy_test.dart (COR-008 · CORE-4).
- [ ] T011 [US1] Implement and export packages/milesoft_core/lib/src/retry_policy.dart after retry defaults and classification are approved. Apply RetryPolicy.attemptLimit, RetryPolicy.initialDelay, RetryPolicy.delayCap from [data-model.md](data-model.md) and its [retry transitions](data-model.md#retry-transitions). Depends on T002. Run dart test from core (COR-008 · CORE-4).

## US2 — Product and environment configuration

**Independent acceptance** — CONFIG-1 and CONFIG-2 pass for development, staging and production, including invalid input, isolation and flags.

### 01.12 — Application configuration

- [ ] T012 [US2] Add failing fixture tests for three environments, winning invalid values, test-only precedence, missing fields, ranges of valid product inputs, optional flags and immutable snapshots in packages/milesoft_core/test/app_config_test.dart (CFG-001, CFG-002, CFG-003, CFG-004, CFG-005, CFG-006, CFG-007 · CONFIG-1, CONFIG-2).
- [ ] T013 [US2] Implement and export packages/milesoft_core/lib/src/app_config.dart, including Environment and FeatureFlags. Apply AppConfig.environment, AppConfig.name, AppConfig.identifier, AppConfig.brandingReferences, AppConfig.localeDefaults, AppConfig.urls and AppConfig.featureFlags from [data-model.md](data-model.md). Validate merged inputs before dependent features start. Depends on T004 where structured validation is shared. Run dart test from core (CFG-001, CFG-002, CFG-003, CFG-004, CFG-005, CFG-006, CFG-007 · CONFIG-1, CONFIG-2).

## US3 — Accessible showcase and reusable UI

**Independent acceptance** — UI-1 through UI-5 pass using local fixtures and the approved Android/web matrix. Component tests run independently of the showcase.

### 01.13 — UI package foundation

- [ ] T014 [US3] Add packages/milesoft_ui/pubspec.yaml, packages/milesoft_ui/lib/milesoft_ui.dart and packages/milesoft_ui/README.md. Register UI in pubspec.yaml, resolve pubspec.lock, and inherit root lint options. Declare an independent UI version and check compatible workspace constraints. Verify flutter pub get --enforce-lockfile, dart pub workspace list and dart analyze --fatal-infos (ARC-002, ARC-011, ARC-006, ARC-007, ARC-008 · SC-001, SC-004).
- [ ] T015 [US3] Add a package smoke test in packages/milesoft_ui/test/package_smoke_test.dart and inspect the resolved UI dependency graph with flutter pub deps --json, run the existing dart run tool/check_workspace_dependencies.dart baseline check, and run flutter test --no-pub from UI (ARC-006, ARC-007, ARC-008 · SC-001, SC-004).

### 01.14 — Design tokens

- [ ] T016 [US3] Add failing semantic role, spacing, elevation, radius and default contrast checks in packages/milesoft_ui/test/tokens_test.dart (UI-003, UI-004, NFR-ACC-006 · UI-1).
- [ ] T017 [US3] Implement approved token roles in packages/milesoft_ui/lib/src/tokens.dart. Apply ThemeInputs.spacing, ThemeInputs.elevation and ThemeInputs.radius from [data-model.md](data-model.md). Export agreed public types and run flutter test --no-pub from UI (UI-003, UI-004 · UI-1).

### 01.15 — Material 3 themes

- [ ] T018 [US3] Add failing light/dark, host appearance, semantic override and contrast tests in packages/milesoft_ui/test/theme_test.dart (UI-001, UI-002, UI-003, CFG-002, NFR-ACC-006 · UI-1).
- [ ] T019 [US3] Implement and export packages/milesoft_ui/lib/src/milesoft_theme.dart. Apply ThemeInputs.colorOverrides, ThemeInputs.typographyOverrides and ThemeInputs.mode in [data-model.md](data-model.md). Depends on T017. Run flutter test --no-pub from UI (UI-001, UI-002, UI-003, CFG-002 · UI-1).

### 01.16 — Form controls

- [ ] T020 [US3] Add failing field input, validation message, semantics, keyboard, disabled, read-only and caller ownership tests in packages/milesoft_ui/test/text_field_test.dart (UI-005, LOC-005, NFR-ACC-002, NFR-ACC-005 · UI-2).
- [ ] T021 [US3] Implement and export packages/milesoft_ui/lib/src/milesoft_text_field.dart. Apply ComponentState.enabled and ComponentState.readOnly in [data-model.md](data-model.md), and retain caller controller and focus ownership. Depends on T019. Run flutter test --no-pub from UI (UI-005 · UI-2).

### 01.17 — Buttons, cards, dialogs and notifications

- [ ] T022 [P] [US3] Add failing button and card tests for focus, callbacks, disabled/loading state, duplicate activation and product themes in packages/milesoft_ui/test/button_card_test.dart (UI-006, NFR-ACC-002, NFR-ACC-005 · UI-2).
- [ ] T023 [P] [US3] Add failing dialog and local notification tests for dismissal, returned result, focus and feedback semantics in packages/milesoft_ui/test/dialog_notification_test.dart (UI-006, NFR-ACC-002, NFR-ACC-005 · UI-2).
- [ ] T024 [US3] Implement and export packages/milesoft_ui/lib/src/milesoft_button.dart, packages/milesoft_ui/lib/src/milesoft_card.dart, packages/milesoft_ui/lib/src/milesoft_dialog.dart and packages/milesoft_ui/lib/src/local_notification.dart after approval of the notification allocation. Apply ComponentState.loading, ComponentState.enabled and ComponentState.action from [data-model.md](data-model.md). Run flutter test --no-pub from UI (UI-006, LOC-005 · UI-2).

### 01.18 — Loading, empty, success and error states

- [ ] T025 [US3] Add failing state semantics, long text, optional action and retry callback tests in packages/milesoft_ui/test/status_view_test.dart (UI-007, SHW-006, LOC-005, NFR-ACC-002, NFR-ACC-004 · UI-3).
- [ ] T026 [US3] Implement and export packages/milesoft_ui/lib/src/status_view.dart with all four statuses after success-state allocation approval. Apply ComponentState.status and ComponentState.action from [data-model.md](data-model.md). Run flutter test --no-pub from UI (UI-007, SHW-006, LOC-005 · UI-3).

### 01.19 — Responsive layouts

- [ ] T027 [US3] Add failing narrow/wide, default/200% scale, keyboard order and overflow tests in packages/milesoft_ui/test/responsive_layout_test.dart (UI-008, UI-009, SHW-007, NFR-ACC-003, NFR-ACC-005 · UI-4).
- [ ] T028 [US3] Implement and export packages/milesoft_ui/lib/src/responsive_layout.dart using available constraints and approved breakpoints. Run flutter test --no-pub from UI (UI-008, UI-009, SHW-007 · UI-4).

### 01.20 — Branding components

- [ ] T029 [US3] Add failing attribution semantics, fallback, scaling and contrast tests in packages/milesoft_ui/test/powered_by_milesoft_test.dart (UI-010, CFG-002, NFR-ACC-002, NFR-ACC-006 · UI-5).
- [ ] T030 [US3] Implement and export packages/milesoft_ui/lib/src/powered_by_milesoft.dart using approved assets when available and the accessible externalised text fallback otherwise. Run flutter test --no-pub from UI (UI-010, LOC-005 · UI-5).

### 01.21 — Showcase catalogue

- [ ] T031 [US3] Add failing coverage for catalogue navigation, keyboard access, three theme modes, capabilities and representative states in apps/showcase/test/catalogue_test.dart. Preserve apps/showcase/test/home_test.dart coverage (UI-002, UI-007, UI-009, UI-011, SHW-001, SHW-002, SHW-006, SHW-007, SHW-008, SHW-009 · UI-1 through UI-5).
- [ ] T032 [US3] Compose both public packages in apps/showcase/lib/main.dart and apps/showcase/lib/catalogue.dart. Add deterministic core/config and component examples and externalise text in apps/showcase/lib/l10n/app_en.arb. Update apps/showcase/pubspec.yaml and pubspec.lock per the approved material_ui disposition. Depends on T013 and T030 plus all component checkpoints. Run flutter gen-l10n and flutter test --no-pub from showcase (UI-002, UI-009, UI-011, SHW-001, SHW-002, SHW-006, SHW-007, SHW-008, SHW-009, LOC-005 · UI-1 through UI-5).

## Cross-cutting verification and release review

### 01.22 — Accessibility and testing

- [ ] T033 [P] Extend tool/check_workspace_dependencies.dart and add failing boundary cases in tool/test/check_workspace_dependencies_test.dart before tightening the checker. Use a standalone Dart main with explicit failure exits and no test-package dependency. From root run dart run tool/test/check_workspace_dependencies_test.dart and dart run tool/check_workspace_dependencies.dart to verify forbidden graph edges, cycles and public imports (ARC-006, ARC-007, ARC-008, DEV-003 · SC-001).
- [ ] T034 [P] Audit the approved accessibility matrix in apps/showcase/test/catalogue_test.dart and follow the reference environments, thresholds and keyboard path in [quickstart.md](quickstart.md#manual-acceptance). Add failing regression tests before fixing discovered defects. Record focus, keyboard, semantics, contrast, touch targets, text scaling and overflow separately from any manual gaps in specs/002-core-design-system/acceptance.md (NFR-ACC-001, NFR-ACC-002, NFR-ACC-003, NFR-ACC-004, NFR-ACC-005, NFR-ACC-006 · SC-003).
- [ ] T035 Run the full quickstart, including core and UI coverage and Android debug and web builds. Record the shared business logic coverage denominator and result against 80%, UI coverage separately, and all blocked checks in specs/002-core-design-system/acceptance.md (DEV-003, AC-018 · SC-001, SC-004).

### 01.23 — Documentation and API review

- [ ] T036 [P] Document exports, configuration, theme overrides, examples, accessibility limits and migration in packages/milesoft_ui/README.md and README.md. Verify the ADRs recorded before implementation and document independent versions and compatible constraints. Record applicable changes in docs/architecture/SAD.md and CHANGELOG.md. Check public exports against the contracts and run documented examples (LOC-005, ARC-002, ARC-006, ARC-008, ARC-011 · SC-001 through SC-003).
- [ ] T037 [P] Extend .github/workflows/quality.yml to verify both packages and run dart run tool/test/check_workspace_dependencies_test.dart from root while preserving lockfile enforcement, PR licence review, dependency scanning and platform builds. Retain or explicitly coordinate the required status check name. Validate workflow commands against quickstart.md and record remote run results for the reviewed SHA when available (DEV-001, DEV-002, DEV-003, DEV-004, NFR-SEC-009, AC-018 · SC-004).

### 01.24 — Final acceptance

- [ ] T038 Review the diff and requirement matrix and rerun mandatory checks from specs/002-core-design-system/quickstart.md. Record per-ID PASS, FAIL or NOT VERIFIED, source SHA, coverage, accessibility limits, unresolved defects, remote CI, scanner results (NFR-SEC-009) and merge enforcement in specs/002-core-design-system/acceptance.md. Keep Phase 0 gaps visible. Recommend v0.2.0 only if mandatory criteria and release approvals support it. Obtain explicit authorisation before pushing, tagging, publishing or deploying (all in-scope SRS IDs · SC-001 through SC-004).

## Dependencies and parallel opportunities

The review gate after each increment controls execution. US1 precedes US2, and both precede catalogue integration. 01.13 establishes the package for UI work, 01.14 provides tokens for 01.15, and the component increments feed 01.21. Accessibility and documentation follow the integrated catalogue. Final acceptance follows 01.22 and 01.23.

[P] identifies file-disjoint work within an authorised increment. T007 and T008 can be drafted independently, as can T022 and T023. T033 and T034 can proceed together with separate test ownership. T036 and T037 can proceed together while coordinating workflow command documentation. Serialise changes to shared exports, lockfiles, the showcase entry point and common evidence. Run the shared verification after the parallel work is integrated.

Keep the exclusions and later milestones in [spec.md](spec.md#scope-and-traceability-mandatory). No application work starts under 01.05.
