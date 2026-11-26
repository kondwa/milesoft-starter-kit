# ADR-015 — Phase 0 platforms

**Status** — Android and web approved by the project owner on 2026-11-26.

## Context

The showcase demonstrates the same shared Dart API on a mobile target and in a browser.

## Decision

Scaffold the showcase for Android and web. Require an Android debug build and a web build in CI. Record a manual launch and the expected core-derived label on an Android emulator or device and in a supported browser.

## Alternatives and consequences

Automated device and browser launches would add CI orchestration beyond Phase 0. The selected evidence combines deterministic widget tests and CI builds with a manual launch on each target. Later platforms and production use retain their own acceptance gates.

[Owner approval and research](../../specs/001-project-foundation/research.md#adr-015--platforms)
