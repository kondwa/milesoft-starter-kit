# MileSoft Starter Kit

MileSoft Starter Kit is a reusable Dart and Flutter foundation for MileSoft applications. Phase 0 establishes a pure Dart core and a small Flutter showcase for Android and web that demonstrates the core's public API.

## Repository layout

| Path | Purpose |
| --- | --- |
| `packages/milesoft_core/` | Pure Dart workspace member with its own version and a planned public API |
| `apps/showcase/` | Flutter workspace member for the planned Android and web showcase |
| `analysis_options.yaml` | Shared Dart analysis configuration |
| `docs/` | Requirements, architecture, development guidance, and architecture decisions |
| `specs/` | Phase specifications, plans, tasks, and acceptance evidence |

## Develop Phase 0

Use Flutter stable 3.50.0 with its bundled Dart 3.14.0. Check the toolchain with `flutter --version`, `dart --version`, and `flutter doctor -v`. From the repository root, run `flutter pub get --enforce-lockfile` to resolve dependencies using the root `pubspec.lock`, then run `dart pub workspace list` to check the two member paths.

Android builds use the plan's Android API 36, Build Tools 36.0.0, NDK 28.2.13676358, and Temurin 17.0.21+9 pins. Check the active Java and Android SDK before building. Flutter Doctor on the 00.08 verification host detected Android Studio's JDK 25 and SDK 37 by default. Those defaults do not establish compatibility with the approved Android build pins.

Start with the [Phase 0 specification](specs/001-project-foundation/spec.md), [implementation plan](specs/001-project-foundation/plan.md), and [task list](specs/001-project-foundation/tasks.md). The plan records the approved toolchain pins. Follow the [development prompt sequence](docs/development/Phase_0_Prompts.md) and review each increment at its gate. The [validation quickstart](specs/001-project-foundation/quickstart.md) applies once the workspace and showcase exist.

The [constitution](.specify/memory/constitution.md) governs engineering practice, the [SRS](docs/requirements/SRS.md) defines requirements, and the [SAD](docs/architecture/SAD.md) describes the architecture. The [Phase 0 decision records](specs/001-project-foundation/research.md) capture the approved workspace, platforms, and toolchain.
