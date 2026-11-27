# Implementation Plan — Phase 1 Core and Design System

**Feature** — 002-core-design-system
**Branch** — main
**Date** — 2026-11-26
**Input** — [Phase 1 specification](spec.md)
**Status** — Approved on 2026-11-26 with increment-specific decisions pending. See the [owner approvals](research.md#owner-approvals).

## Summary

Extend the existing pure Dart core with reusable contracts and validated configuration. Add a Flutter design system and demonstrate both packages in the existing showcase. Preserve the public label normalisation contract and carry forward the unresolved Phase 0 evidence.

## Technical Context

| Area | Design |
| --- | --- |
| SDK | Retain the approved Phase 0 pins for Phase 1. Flutter 3.50.0, Dart 3.14.0, Dart constraint ^3.14.0, Android API 36 compile/target and API 24 minimum. See the [toolchain record](../../docs/adr/phase-0-toolchain.md) for the full matrix. |
| Package resolution | Native Pub Workspace with one enforced root lockfile. Independently version shared packages. Add the approved UI member in 01.13. |
| Runtime dependencies | Dart SDK for core and Flutter SDK for UI. The approved UI runtime dependencies are the Flutter SDK and standalone material_ui because the bundled Material library is deprecated in the pinned SDK. Showcase consumes both through their public entry points. Use existing localisation facilities for catalogue strings. |
| Platform and state | Android and web. Local fixtures, session-only theme selection, no persisted settings or backend. Use native theme selection and local state for a single preference. Apply Constitution III if nontrivial presentation state is introduced. |
| Reliability | Bounded page sizes and retry attempts. Inject time, identifiers and retry delay for deterministic tests. No new latency target beyond applicable SRS gates. |

## Constitution Check

| Principles | Before design | After design |
| --- | --- | --- |
| I–IV | Reuse approved workspace and core API | A cohesive UI package owns theme and widgets. Showcase composes both shared packages. No UI-to-core dependency is needed. |
| V | Planning authorised by clarification 1 | [Traceability](#requirement-traceability) ties the design to acceptance. Owner approval of open scope gates implementation. Record applicable ADR decisions before any dependent increment. |
| VI, XII | Test-first and applicable checks required | Write a failing test for each new business behaviour and regression tests for defects. Require at least 80% shared business logic coverage, documented public contracts, and recorded results. |
| VII, XI | Safe configuration, diagnostics and recovery required | Validate the winning values before use. Keep privileged decisions outside flags. Bound retries and keep private details out of user messages and logs. |
| VIII | Commercial features deferred | No payment or entitlement flows introduced. |
| IX, X | Approved Android/web, Material 3 and externalised copy | Verify the approved width and scale matrix and report observed accessibility limitations. |

## Project Structure

| Path | Responsibility |
| --- | --- |
| packages/milesoft_core/lib/milesoft_core.dart | Existing public entry point plus selected core and configuration exports |
| packages/milesoft_core/lib/src/ and test/ | Core contracts, policies and deterministic unit tests |
| packages/milesoft_ui/lib/milesoft_ui.dart | Public theme, tokens and component entry point |
| packages/milesoft_ui/lib/src/ and test/ | Flutter implementations and widget tests |
| apps/showcase/lib/ and test/ | Catalogue, local fixtures, composition and regression tests |
| pubspec.yaml, pubspec.lock, tool/check_workspace_dependencies.dart, .github/workflows/quality.yml | Membership, locked resolution and quality gates |

```text
showcase ──> milesoft_core ──> Dart SDK
    └──────> milesoft_ui ───> Flutter SDK + material_ui
```

See the [contracts](contracts/public-api.md) and [data model](data-model.md) for the public surface, design tokens and widget behaviour. Keep package internals private and use explicit composition for configuration and diagnostics.

## Migration and sequencing

Preserve the Phase 0 API export, signature, whitespace semantics and existing tests. Keep the current home label reachable in the catalogue and keep its regression coverage. Resolve the workspace lockfile after adding UI, and verify that every member still resolves. Retain standalone material_ui in the showcase during catalogue integration. Verify imports, generated localisation integration and regression tests. Plan an additive core version and initial UI version under SemVer. Expanded core, configuration and UI target v0.2.0. Exact package versions and tagging remain subject to release review.

Implement core and configuration in 01.07–01.12, package and components in 01.13–01.20, the catalogue in 01.21, and verification and documentation in 01.22–01.24. Place local UI notifications alongside interactive controls in 01.17, success alongside other state presentations in 01.18, and accessible catalogue navigation in 01.21. These allocations are proposed for 01.05.

## Requirement traceability

The [specification matrix](spec.md#scope-and-traceability-mandatory) holds individual acceptance and test mappings. Carry these IDs and scenarios into ordered tasks in 01.05.

| Design | SRS IDs | Acceptance and evidence |
| --- | --- | --- |
| Outcomes, use cases, validation and pages | COR-001, COR-002, COR-003, COR-004 | CORE-1, CORE-2. Contract and boundary tests |
| Time, identity, logging and retry | COR-005, COR-006, COR-008, COR-009 | CORE-3, CORE-4. Deterministic unit tests |
| Configuration | CFG-001, CFG-002, CFG-003, CFG-004, CFG-005, CFG-006, CFG-007 | CONFIG-1, CONFIG-2 and UI-1. Startup and override fixtures |
| Themes and tokens | UI-001, UI-002, UI-003, UI-004 | UI-1. Theme, override and contrast tests |
| Forms, controls, states and responsive access | UI-005, UI-006, UI-007, UI-008, UI-009 | UI-2 through UI-4. Widget and manual checks |
| Attribution and catalogue | UI-010, UI-011, LOC-005 | UI-3, UI-5. Catalogue inventory, semantic labels and string review |
| Boundaries and quality | ARC-002, ARC-006, ARC-007, ARC-008, ARC-011, DEV-001, DEV-002, DEV-003, DEV-004, NFR-SEC-009, AC-018 | SC-001, SC-004. Independent versions, compatible constraints, resolved graph, lockfile scan, builds and enforcement evidence |

Apply the specification's linked SHW and NFR-ACC checks to the catalogue and preserve its later-milestone exclusions.

## Complexity Tracking

The [decision research](research.md) records owner approvals, design proposals and required ADRs. The time-bound Phase 0 evidence disposition is recorded in the owner approvals. Use the [acceptance guide](quickstart.md) to record actual results. Phase 0 SC-002, SC-003 and SC-004 remain open.
