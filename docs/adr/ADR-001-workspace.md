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
