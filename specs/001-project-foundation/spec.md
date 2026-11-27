# Feature Specification — Phase 0 Project Foundation

**Feature Branch** — Current checkout (`main`)

**Created** — 2026-11-25

**Status** — Phase 0 scope and applicable ADRs approved. Implementation acceptance pending.

**Input** — [Phase 0 prompt 00.02](../../docs/development/Phase_0_Prompts.md)

## Clarifications

### Session 2026-11-25

- Q: Which scope should Phase 0 use for the initial workspace and showcase? → A: Use only the pure Dart core and Android/web showcase, with one demonstrated core capability. Schedule shared UI, the app shell and full core contracts for later phases.
- Q: What should passing the Phase 0 acceptance checks qualify the project to release? → A: Qualify for an internal v0.1.0 foundation recommendation with the minimal core demo. Tagging, publication and deployment each require separate authorization. Defer private distribution validation.
- Q: What toolchain, workspace layout and runner should Phase 0 planning use? → A: Use `packages/milesoft_core`, `apps/showcase` and a GitHub-hosted Linux runner. Verify compatibility and pin stable Flutter with its bundled Dart and the Android/JDK toolchain during planning.
- Q: What launch and test evidence should Phase 0 require on Android and web? → A: Require deterministic core unit and showcase widget tests plus CI builds for both targets. Record manual launch checks on an Android emulator or device and a supported web browser.
- Q: May Phase 0 proceed to planning under the current constitution, SRS and SAD as a working baseline, with these decisions taking precedence for Phase 0? → A: Approve the working baseline for Phase 0 planning. Obtain formal ratification and unresolved ADR approvals before dependent implementation.

### Session 2026-11-26

- The project owner ratified constitution v0.1.0 and approved the Phase 0 workspace, Android/web scope and exact toolchain pins in the [decision records](research.md).
- Use the existing private GitHub repository. Its administrator must supply its identity and enable required checks before remote verification.

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Verify the core works in the showcase (Priority P1)

A starter kit developer can resolve the workspace and run the showcase on Android and web to see a result produced by the shared core.

**Why this priority** — A working consumer demonstrates that the package boundary supports reuse.

**Independent Test** — From a fresh checkout, follow the setup instructions, run the standalone core tests, and manually launch the showcase on both targets.

1. **Given** the documented prerequisites, **when** a developer resolves dependencies from the repository root, **then** the workspace resolves the core and showcase together.
2. **Given** a resolved workspace, **when** a developer tests the core with the Dart toolchain, **then** the tests pass without a Flutter runtime and the core dependency graph contains no Flutter, Firebase, payment SDK or showcase dependency.
3. **Given** a clean build on each supported target, **when** the showcase opens, **then** its home screen displays the expected output of the same public core capability. A widget test verifies the displayed result, and dependency validation confirms the showcase consumes the core through its public interface.

### User Story 2 — Detect regressions before merge (Priority P2)

A maintainer can use the same lint standard across the workspace and see verification results on a pull request.

**Why this priority** — Reviewers need repeatable evidence that changes preserve package boundaries and supported builds.

**Independent Test** — Verify that a compliant change passes the mandatory checks and that an intentional lint or test failure is reported and blocks merging.

1. **Given** a pull request with a compliant change, **when** mandatory checks run, **then** results cover formatting, analysis, unit and widget tests, dependency boundaries, and Android debug and web builds.
2. **Given** a pull request with a failing mandatory check, **when** a maintainer attempts a normal merge, **then** repository merge controls prevent it.

### User Story 3 — Set up and verify the foundation from documentation (Priority P3)

A contributor can use the repository documentation to set up the project, find the public core contract, and reproduce verification locally.

**Why this priority** — A repeatable setup lets new contributors validate changes without relying on undocumented machine setup.

**Independent Test** — Follow the published instructions in a fresh checkout with the documented prerequisites.

1. **Given** a fresh checkout, **when** a contributor follows the guide, **then** they can resolve dependencies, run documented local checks, and launch the showcase on both supported targets.
2. **Given** a proposed package addition, **when** the contributor consults the guide, **then** they can identify the workspace membership rules, dependency direction and required approval or verification steps.

### Edge Cases

- With an incompatible or missing toolchain, a required command fails or is blocked. The guide identifies the supported prerequisites and the verification record reports the outcome.
- A dependency from the core back to the showcase, a dependency on a prohibited SDK, or a dependency cycle fails boundary verification.
- If a target is unavailable, acceptance for that target stays pending until build and launch evidence is available.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001** — The repository MUST provide a Dart Pub Workspace with exactly two initial members at `packages/milesoft_core` and `apps/showcase`, with explicitly declared and reproducibly resolved dependencies. The core manifest MUST declare its own valid SemVer version independently of the showcase and repository release.
- **FR-002** — `milesoft_core` MUST be a pure Dart package with one minimal, documented public capability consumed by the showcase. The core MUST have no Flutter, Firebase, payment SDK or product dependencies. Workspace packages MUST have acyclic dependencies.
- **FR-003** — The Flutter showcase MUST build and launch on Android and web, use Material 3, and display the result from the core on its home screen. Verify the screen at representative narrow and wide widths and cover applicable semantics, text scaling and keyboard access.
- **FR-004** — Both workspace members MUST follow shared analysis and lint rules. Automated tests MUST cover the public core capability, the showcase integration as displayed in its widget test, and applicable regressions. New or changed business behavior MUST follow the constitution’s test-first rule. Shared business logic, where present, MUST target at least 80% coverage. Tests MUST be deterministic and require no production data, credentials or services.
- **FR-005** — GitHub Actions MUST run formatting, static analysis, unit and widget tests, dependency-boundary checks, and Android debug and web builds for pull requests and the primary branch using a GitHub-hosted Linux runner. CI MUST use the compatible stable Flutter, bundled Dart and Android/JDK toolchain pins established during planning. Mandatory pull request checks MUST block normal merges on failure. CI MUST use least privilege and report check results.
- **FR-006** — Developer documentation MUST cover prerequisites, workspace membership and dependency rules, local setup, run and verification commands, the public core capability, CI checks, adding packages, and how the governing documents and feature artifacts relate.

**FR-005 supply-chain checks** — Run pinned OSV-Scanner against the root `pubspec.lock` on pull requests and primary-branch pushes. Scanner errors and unresolved findings fail the check unless a documented, owner-approved exception applies. A reviewer MUST verify licences for added or changed third-party dependencies and refer unknown or incompatible terms to the owner.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001** — One clean checkout resolves both required workspace members, verifies an explicit valid SemVer version in the core manifest, runs the core tests independently, and passes all declared dependency-boundary checks.
- **SC-002** — Both CI builds succeed. Record successful manual launches on one Android emulator or device and one supported web browser, with the expected core-derived result visible in each. The widget test and applicable accessibility and layout checks pass.
- **SC-003** — For internal pre-1.0, record successful required checks on the primary branch and a compliant PR, and a controlled failure that proves a mandatory check blocks normal merging. Equivalent current PR CI may satisfy the historical Phase 0 PR gate when passing foundation checks and current superset checks are linked. Record repository, commands, results, root lockfile scan and applicable core coverage. Record licence findings in the consolidated version-bound owner review. [Approved amendment](../../docs/adr/internal-release-quality.md)
- **SC-004** — One fresh-checkout walkthrough completes setup, local verification and both showcase launches using the documented prerequisites and commands.

## Scope and Traceability *(mandatory)*

The table maps the Phase 0 planning baseline to the [SRS](../../docs/requirements/SRS.md). Verification entries are planned evidence for the later task list.

| SRS IDs | Feature requirement | Acceptance criterion | Planned verification |
| --- | --- | --- | --- |
| ARC-002, ARC-011, NFR-MNT-004 | FR-001 | SC-001 | Clean workspace resolution and core SemVer manifest review |
| ARC-003, ARC-006, ARC-007, ARC-008, NFR-MNT-002 | FR-002 | SC-001, SC-002 | Dependency graph, standalone unit test and public interface review |
| DEV-003, SHW-001, SHW-007, UI-001, NFR-ACC-002, NFR-ACC-003, NFR-ACC-005 | FR-003 | SC-002 | Two build and launch checks, widget test, and responsive and accessibility checks of the foundation screen |
| NFR-MNT-005, NFR-MNT-006, SHW-008 | FR-004 | SC-001, SC-002, SC-003 | Workspace lint run, test results and applicable coverage evidence |
| DEV-001, DEV-002, DEV-003, DEV-004, DEV-007, NFR-SEC-009, AC-018 | FR-005 | SC-003 | Workflow runs, permissions review, controlled merge-gate failure, lockfile scan and licence review |
| NFR-MNT-002, DEV-003 | FR-006 | SC-004 | Fresh-checkout walkthrough and documentation review |

**Exclusions and later milestones** — Authentication, onboarding, billing, entitlements, Firebase integration, production deployment, advanced UI and navigation, the full component catalogue and full core contracts are outside Phase 0. Full showcase workflows and production acceptance requirements remain scheduled for their applicable milestones. Private package publication and external consumer validation are outside workspace acceptance and remain subject to ADR-002 and ADR-013. Phase 0 verifies Android and web only. Later platform obligations remain subject to the SRS and ADR-015.

**Release boundary** — Passing SC-001 through SC-004 qualifies Phase 0 for an internal v0.1.0 foundation recommendation. Tagging, publication and deployment each require separate authorization. Verify the external consumer and approve distribution and licensing before a release that relies on private package distribution.

**Open verification inputs** — The approved repository identity, required-check settings, actual runner image, clean builds and remote runs require implementation evidence. Record approvals for later capabilities before dependent work. See the [original constitution review and decision backlog](../../docs/development/Phase_0_Constitution_Review.md).

## Assumptions

- The showcase demonstrates one small core capability with local data and no backend. The feature does not prescribe a public API shape.
- The repository owner can configure required GitHub checks. Remote workflow execution and merge enforcement require actual repository evidence before acceptance.
- The [constitution](../../.specify/memory/constitution.md), the SRS and the [SAD](../../docs/architecture/SAD.md) are the approved working baseline for Phase 0 planning. Apply the owner decisions recorded in Clarifications when choosing Phase 0 scope and planning evidence.
