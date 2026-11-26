# MileSoft Starter Kit

MileSoft Starter Kit is a reusable Dart and Flutter foundation for MileSoft applications. Phase 0 establishes a pure Dart core and a small Flutter showcase for Android and web that demonstrates the core's public API.

## Repository layout

| Path | Purpose |
| --- | --- |
| `packages/milesoft_core/` | Independently versioned pure Dart library with the `normalizeLabel` public API |
| `apps/showcase/` | Android and web Material 3 showcase that displays the result of the core API |
| `analysis_options.yaml` | Shared Dart analysis configuration |
| `docs/` | Requirements, architecture, development guidance, and architecture decisions |
| `specs/` | Phase specifications, plans, tasks, and acceptance evidence |

## Develop Phase 0

Start with the [developer setup guide](docs/development/Phase_0_Setup.md) for the pinned toolchain, workspace setup, local checks, and Android and web launch commands. The [GitHub Actions workflow](.github/workflows/quality.yml) runs the shared checks and builds on pull requests and pushes to `main`.

The [Phase 0 specification](specs/001-project-foundation/spec.md), [implementation plan](specs/001-project-foundation/plan.md), and [task list](specs/001-project-foundation/tasks.md) define the scope and implementation order. Follow the [development prompt sequence](docs/development/Phase_0_Prompts.md) at each review gate and use the [validation quickstart](specs/001-project-foundation/quickstart.md) for acceptance checks.

The [constitution](.specify/memory/constitution.md) governs engineering practice, the [SRS](docs/requirements/SRS.md) defines requirements, and the [SAD](docs/architecture/SAD.md) describes the architecture. The ADRs record the approved [workspace](docs/adr/ADR-001-workspace.md), [platforms](docs/adr/ADR-015-platforms.md), and [toolchain](docs/adr/phase-0-toolchain.md).
