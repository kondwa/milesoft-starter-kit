# ADR — Phase 0 toolchain

**Status** — Pins approved by the project owner on 2026-11-26.

## Context

Contributors and CI need the same Flutter SDK and a compatible Android build toolchain. GitHub updates the hosted image periodically.

## Decision

| Component | Pin |
| --- | --- |
| Flutter stable | 3.50.0, revision `ab2912035e160d9cad6306df307576da6128ebdb` |
| Bundled Dart | 3.14.0, with workspace SDK constraint `^3.14.0` |
| Java | Eclipse Temurin 17.0.21+9 |
| Android | Compile and target API 36, minimum API 24, Build Tools 36.0.0, NDK 28.2.13676358 |
| Android build | Gradle 9.5.0, AGP 9.3.1, and the pinned Flutter template's Kotlin configuration |
| CI | GitHub-hosted x64 `ubuntu-24.04` job with the actual image version recorded from its logs |

The [Quality workflow](../../.github/workflows/quality.yml) also pins OSV-Scanner 2.7.1 and action revisions. Use the root lockfile for Dart and Flutter package resolution.

## Alternatives and consequences

Floating SDK versions allow local and CI results to diverge. A self-hosted image would add maintenance beyond the foundation. Explicit pins reduce drift. Upgrades require reviewing compatibility and repeating the local and CI checks.

[Owner approval and research](../../specs/001-project-foundation/research.md#phase-0-toolchain-adr) · [Acceptance evidence](../../specs/001-project-foundation/acceptance.md)
