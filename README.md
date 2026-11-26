# MileSoft Starter Kit

MileSoft Starter Kit is a reusable Dart and Flutter foundation for MileSoft applications. The Android and web showcase opens to the original core-derived title. Choose **Browse catalogue** to explore the shared core contracts, form controls, status views and responsive layouts, or switch the theme for the current session.

## Repository layout

| Path | Purpose |
| --- | --- |
<<<<<<< HEAD
| `packages/milesoft_core/` | Pure Dart configuration, results, validation, pagination, retry, clock, ID and logging contracts |
| `packages/milesoft_ui/` | Shared Flutter themes, tokens, controls, status views and responsive layout |
| `apps/showcase/` | Android and web Material 3 showcase with a catalogue of shared core and UI examples |
=======
| `packages/milesoft_core/` | Independently versioned pure Dart library with the `normalizeLabel` public API |
| `apps/showcase/` | Android and web Material 3 showcase that displays the result of the core API |
>>>>>>> 697147f (completed phase 0)
| `analysis_options.yaml` | Shared Dart analysis configuration |
| `docs/` | Requirements, architecture, development guidance, and architecture decisions |
| `specs/` | Phase specifications, plans, tasks, and acceptance evidence |

## Develop Phase 0

Start with the [developer setup guide](docs/development/Phase_0_Setup.md) for the pinned toolchain, workspace setup, local checks, and Android and web launch commands. The [GitHub Actions workflow](.github/workflows/quality.yml) runs the shared checks and builds on pull requests and pushes to `main`.

The [Phase 0 specification](specs/001-project-foundation/spec.md), [implementation plan](specs/001-project-foundation/plan.md), and [task list](specs/001-project-foundation/tasks.md) define the scope and implementation order. Follow the [development prompt sequence](docs/development/Phase_0_Prompts.md) at each review gate and use the [validation quickstart](specs/001-project-foundation/quickstart.md) for acceptance checks.

The [constitution](.specify/memory/constitution.md) governs engineering practice, the [SRS](docs/requirements/SRS.md) defines requirements, and the [SAD](docs/architecture/SAD.md) describes the architecture. The ADRs record the approved [workspace](docs/adr/ADR-001-workspace.md), [platforms](docs/adr/ADR-015-platforms.md), and [toolchain](docs/adr/phase-0-toolchain.md).
<<<<<<< HEAD

## Integrate the shared packages

Import `package:milesoft_core/milesoft_core.dart` and `package:milesoft_ui/milesoft_ui.dart` from consumers in the workspace. Both packages currently declare `0.1.0` and version independently. The showcase declares `^0.1.0` for each and shares the `material_ui: ^1.11.1` constraint with the UI package. Run `flutter pub get --enforce-lockfile` from the root. Package publication is disabled. [Workspace decision](docs/adr/ADR-001-workspace.md)

Existing consumers can keep using `normalizeLabel`, which trims surrounding whitespace and preserves case and internal whitespace. Adopt the new core contracts as needed. When adding UI, use standalone `material_ui` for types passed to the shared widgets, keep theme selection in the app, and supply localised labels and messages. Use the package entry points instead of `src/` imports. [Public API reference](specs/002-core-design-system/contracts/public-api.md) · [Theme and widget examples](packages/milesoft_ui/README.md)

The showcase runs with deterministic local fixtures. Call `AppConfig.load` with product defaults, the selected environment and the supported language, region and currency sets. Environment values take precedence over defaults. Apply explicit overrides only in test composition. Handle `Failed<AppConfig>` before starting dependent features. Keep secrets out of the configuration and enforce permissions separately from feature flags. [Runnable configuration example](apps/showcase/lib/catalogue_core.dart) · [Configuration rules](docs/adr/phase-1-app-config.md)

Use the [Phase 1 quickstart](specs/002-core-design-system/quickstart.md) to reproduce package and showcase checks. The [acceptance evidence](specs/002-core-design-system/acceptance.md) records the current limits of manual accessibility verification.
=======
>>>>>>> 697147f (completed phase 0)
