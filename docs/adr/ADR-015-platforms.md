# ADR-015 — Phase 0 platforms

**Status** — Android and web approved by the project owner on 2026-11-26.

## Context

The showcase demonstrates the same shared Dart API on a mobile target and in a browser.

## Decision

Scaffold the showcase for Android and web. Require an Android debug build and a web build in CI. Record a manual launch and the expected core-derived label on an Android emulator or device and in a supported browser.

## Alternatives and consequences

Automated device and browser launches would add CI orchestration beyond Phase 0. The selected evidence combines deterministic widget tests and CI builds with a manual launch on each target. Later platforms and production use retain their own acceptance gates.

[Owner approval and research](../../specs/001-project-foundation/research.md#adr-015--platforms)

## Phase 1 extension

The owner approved Android and web for the themed showcase. CI retains both builds. Local acceptance exercises Android touch and web keyboard interaction at 320 and 1280 logical pixels, default and 200% text scaling, and light and dark appearances. Use the [reference scenarios](../../specs/002-core-design-system/quickstart.md#manual-acceptance) and record unverified combinations in the [acceptance evidence](../../specs/002-core-design-system/acceptance.md).
