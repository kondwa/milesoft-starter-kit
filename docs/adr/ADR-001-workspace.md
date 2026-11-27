# ADR-001 — Repository and workspace

**Status** — Phase 0 scope approved by the project owner on 2026-11-26.

## Context

The core and showcase need reproducible local dependency resolution. The core has its own version and exposes a pure Dart API shared with consumers.

## Decision

Use a private repository with one native Dart Pub Workspace. Phase 0 has two members, `packages/milesoft_core` and `apps/showcase`. Commit the root lockfile and enforce it in CI. Declare the showcase's dependency on core with a compatible version constraint. Keep shared package dependencies independent of the showcase.

## Alternatives and consequences

Separate package resolution would require multiple lockfiles and make the integration harder to reproduce. Shared resolution surfaces SDK or package version incompatibilities in a single solve.

ADR-002 remains pending for private package distribution and external consumer validation. ADR-013 remains pending for distribution licensing. These decisions are required before dependent distribution work.

[Owner approval and research](../../specs/001-project-foundation/research.md#adr-001--workspace)

## Phase 1 extension

The owner approved the workspace extension on 2026-11-26. In 01.13, add `packages/milesoft_ui` as an independently versioned member and continue enforcing the root lockfile. The UI package uses the Flutter SDK and directly declares standalone `material_ui`. The owner approved this dependency on 2026-11-26 so shared widgets and the showcase use compatible Material types. The showcase composes UI and core through their public APIs.

In 01.21, retain the showcase's existing standalone `material_ui` dependency and verify catalogue regression and localisation behavior. Flutter 3.50 deprecated the bundled `package:flutter/material.dart` library. [Flutter migration guide](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)

[Phase 1 owner approvals](../../specs/002-core-design-system/research.md#increment-approvals-for-0109-through-0121)

Both shared packages currently declare `0.1.0` and are independently versioned. The showcase uses `^0.1.0` for each. The UI package and showcase both declare `material_ui: ^1.11.1`. The Phase 1 starter kit release target is tracked separately from package manifest versions. See the [public package contracts](../../specs/002-core-design-system/contracts/public-api.md).
