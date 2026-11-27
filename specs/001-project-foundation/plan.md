# Implementation Plan — Phase 0 Project Foundation

**Spec Kit feature** — 001-project-foundation
**Date** — 2026-11-26
**Input** — [Approved planning specification](spec.md)

## Summary

Establish a two-member Pub Workspace, exercise one pure Dart capability from a minimal Material 3 showcase, and verify Android and web through GitHub Actions and manual launches. Deliver contributor setup and reproducible checks. The owner ratified the constitution and approved the Phase 0 workspace, platform and toolchain decisions on 2026-11-26.

## Technical Context

| Area | Plan |
| --- | --- |
| Language and SDK | Flutter stable 3.50.0 (revision ab2912035e160d9cad6306df307576da6128ebdb) with Dart 3.14.0. Use Dart SDK constraint ^3.14.0 and pin tooling exactly in CI. |
| Dependencies | Flutter SDK for showcase, Dart test for core, SDK flutter_test for showcase, and a shared lint ruleset. Choose compatible package constraints and commit the resolved root lockfile. |
| Android | API 36 compile and target, minimum API 24, Build Tools 36.0.0, NDK 28.2.13676358, Gradle wrapper 9.5.0, AGP 9.3.1, Temurin 17.0.21+9. Use the pinned Flutter Android template, keeping its Kotlin arrangement. |
| Web | Standard Flutter web build and one recorded supported browser launch. |
| CI | GitHub-hosted x64 ubuntu-24.04. Record the actual image revision from the run. Pin SDKs and action revisions independently. |
| Storage and services | In-memory sample label only. No backend, persistence, credentials, accounts or live network dependencies at runtime. |
| Verification | Deterministic unit/widget tests, shared formatting and analysis, dependency graph verification, Android debug and web builds, and manual launch evidence. |
| Performance | Phase 0 evidence is successful launch and rendering on both targets. Production latency and availability measurements belong to their applicable milestones. |

## Constitution Check

Review before research and after design.

| Principles | Before design | After design |
| --- | --- | --- |
| I, II, IV | Approved two-member scope | One documented Dart API, one showcase consumer, independent package version and one reproducible workspace resolution. |
| III | Pure Dart boundary required | Showcase root computes the sample and passes the resulting text explicitly to the view. Static UI has no nontrivial presentation state. Verify inward imports and acyclic dependencies. |
| V | Approved planning baseline | [Spec traceability](spec.md#scope-and-traceability-mandatory) carries into the tests and downstream tasks. Ratification and scoped ADR approvals are recorded. |
| VI | Test-first and coverage policy applicable | Record red and green results for core behavior, unit/widget evidence and applicable shared business logic coverage against the 80% target. Use fixed fixtures. |
| VII, VIII | Security applies to repository and CI. Commercial controls are outside scope. | Read-only CI permissions, no production secrets or data, lockfile vulnerability scanning and reviewer licence verification. |
| IX, X | Android/web and minimum UI approved for planning | Record builds and manual launches. Check layout, semantics, text scaling and applicable keyboard access. Externalise visible English strings in showcase resources. |
| XI, XII | No cloud runtime or production deployment | Required PR gates, reproducible toolchain and evidence traceable to commit. CI time limits, no paid external services and no release actions. |

No constitution exception is proposed. Any change to the approved working baseline requires owner review.

## Project Structure

| Path | Responsibility |
| --- | --- |
| pubspec.yaml, pubspec.lock, analysis_options.yaml | Workspace membership, single committed lockfile and shared lint rules |
| packages/milesoft_core/lib/milesoft_core.dart | Public pure Dart capability |
| packages/milesoft_core/test/ | Dart unit tests |
| apps/showcase/lib/ | Composition root, localised string resources and Material 3 home screen |
| apps/showcase/test/, android/, web/ | Widget tests and platform scaffolding under the showcase |
| .github/workflows/ | Pull request and primary-branch verification |
| README.md, docs/development/, docs/adr/ | Contributor entry point, local checks and architecture decisions |

Use ordinary compatible versions for member dependencies with workspace resolution. Keep generated caches and build output out of Git, retain the root lockfile and avoid resolution overrides. Defer Firebase, authentication, billing, GoRouter, BLoC and GetIt. The showcase needs a single screen and explicit constructor inputs. Shared UI and app shell packages belong to later phases.

## Contracts and Verification

- [Core and showcase contract](contracts/core-showcase.md) and [data model](data-model.md) define the expected behavior and sample inputs.
- [Research and ADRs](research.md) document the approved ADR-001 workspace, ADR-015 platforms and Phase 0 toolchain pins. ADR-002 and ADR-013 remain deferred to distribution work.
- [Quickstart](quickstart.md) defines commands and acceptance evidence. Validate membership and the showcase-to-core edge, then traverse the core dependency graph for forbidden SDK/product dependencies and check the workspace graph for cycles. Inspect source imports and public entry points as well as manifests.
- Start with failing core tests for normalisation and an empty input case. Then implement the contract and run core tests. Add a widget test for the visible result and applicable accessibility/layout checks. Report executed commands and results. Record a blocked target as unverified.
- Run one required CI workflow on pull requests and pushes to the primary branch. Resolve with the root lockfile, then check format, lint, dependencies, tests and both builds. Configure required status checks and use a controlled failing PR to prove enforcement under normal merge permissions. Preserve evidence against the commit under review.
- Run `osv-scanner scan source --lockfile=pubspec.lock` from root in that workflow. Pin the scanner release when implementing CI. Scanner errors and unresolved vulnerabilities fail the check unless a documented owner-approved exception applies. A reviewer verifies licences of new or changed third-party dependencies, escalating unknown or incompatible terms to the owner. Preserve scan output and the licence review or disposition in acceptance evidence.
- The approved repository administrator supplies its identity and enables required checks. Record passing primary-branch CI, compliant PR CI or its approved current equivalent, and a controlled blocked merge. Capture licence findings in the consolidated version-bound owner review. [Approved amendment](../../docs/adr/internal-release-quality.md)

## Complexity Tracking

No additional architectural complexity or constitution exception is proposed.
