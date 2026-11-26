# Tasks — Phase 0 Project Foundation

**Inputs** — [Specification](spec.md), [plan](plan.md), [research](research.md), [data model](data-model.md), [contract](contracts/core-showcase.md), and [validation quickstart](quickstart.md).

**Start gate** — The owner ratified [constitution v0.1.0](../../.specify/memory/constitution.md) and approved [ADR-001, ADR-015 and the exact Phase 0 toolchain pins](research.md) on 2026-11-26. Complete the 00.06 review before implementation. Run only the task group authorized by the current prompt. Paths and command working directories are relative to the repository root unless stated otherwise.

**Evidence** — Mark a task complete only after its stated verification. Record the command, working directory, result and any blocker. An expected failure in a test-first task is verification of the red step. Remote results require remote evidence.

## Repository foundation · 00.07

- [X] T001 Create `README.md` and `.gitignore` and establish the approved directory layout (FR-006, NFR-MNT-002). Verify with `git status --short --untracked-files=all` and `git diff --check`. Review the tree for governing documents and avoid empty future packages.
- [X] T002 Add the root `analysis_options.yaml` with the shared lint configuration (FR-004, NFR-MNT-005). Verify its contents against the plan and run `git diff --check`. Run the analyzer after dependency resolution in T015.

**Verification (2026-11-26)** — From repository root, `git status --short --untracked-files=all` showed the three foundation files and `git diff --check` passed. Directory, README link, and `git check-ignore` checks passed. The root options include `package:lints/recommended.yaml`. Workspace resolution supplies the lint dependency in 00.08. Runtime analyzer verification is scheduled for T015.

**Checkpoint** — Repository structure and shared configuration are ready for the two workspace members.

## Dart Pub Workspace · 00.08

- [X] T003 Define the private workspace root in `pubspec.yaml` and member manifests in `packages/milesoft_core/pubspec.yaml` and `apps/showcase/pubspec.yaml` (FR-001, ARC-002, ARC-011, NFR-MNT-004, SC-001). Keep this increment to manifests. Declare the Flutter SDK and showcase-to-core dependencies, workspace resolution, and applicable test and lint dependencies. Verify the manifests with `dart pub workspace list` from root and inspect dependency direction and constraints. Verify the core manifest explicitly declares a valid SemVer version managed independently of the showcase and repository release.
- [X] T004 Generate and retain the root `pubspec.lock` and record the verified toolchain prerequisites in `README.md` (FR-001, ARC-011, NFR-MNT-004, SC-001). Run `flutter --version`, `dart --version`, `flutter doctor -v`, `flutter pub get`, `flutter pub get --enforce-lockfile` and `dart pub workspace list`. Check for one root lockfile, exactly two member paths and no dependency overrides. Report any toolchain check that is blocked.

**Verification (2026-11-26)** — From repository root, `flutter --version` and `dart --version` confirmed 3.50.0 stable and 3.14.0. `flutter doctor -v` completed successfully and reported Android Studio JDK 25 and SDK 37 as host defaults. Android builds with the approved pins remain for the showcase tasks. `flutter pub get --offline` and `flutter pub get --offline --enforce-lockfile` both succeeded using the installed Pub cache. `dart pub workspace list` returned the root, `packages/milesoft_core` and `apps/showcase`. Manifest review confirmed independent core version 0.1.0, showcase-to-core dependency, no overrides and one root lockfile.

**Checkpoint** — The two manifests resolve through a single lockfile.

## Core package · 00.09 · US1

- [X] T005 [US1] Write deterministic contract tests in `packages/milesoft_core/test/normalize_label_test.dart` for padded text, preserved internal whitespace, empty input and whitespace-only input (FR-002, FR-004, ARC-008, SHW-008, SC-001). In `packages/milesoft_core`, run `dart test` before creating the public implementation and record the expected failure.
- [X] T006 [US1] Implement and document `normalizeLabel` in `packages/milesoft_core/lib/milesoft_core.dart` using [data-model.md](data-model.md) values **Source label** and **Normalised label** and the [public contract](contracts/core-showcase.md) (FR-002, ARC-003, ARC-006, ARC-008, NFR-MNT-002, SC-001). In `packages/milesoft_core`, run `dart format --output=none --set-exit-if-changed lib test`, `dart analyze --fatal-infos` and `dart test`. Confirm the API and imports are pure Dart.

**Verification (2026-11-26)** — In `packages/milesoft_core`, `dart test` first failed to load the tests because the public library and `normalizeLabel` did not exist. After implementation, `dart format --output=none --set-exit-if-changed lib test` reported zero changes, `dart analyze --fatal-infos` reported no issues, and `dart test` passed all four cases. The public library uses only Dart's built-in `String.trim()` and has no imports. `git diff --check` passed.

**Checkpoint** — The core test suite passes using the Dart toolchain.

## Showcase · 00.10 · US1

- [X] T007 [US1] Scaffold Android and web under `apps/showcase/android/` and `apps/showcase/web/` using the pinned Flutter template and preserve the workspace manifest in `apps/showcase/pubspec.yaml` (FR-001, FR-003, DEV-003, SHW-001, SC-002). Inspect the generated platforms and wrapper, plugin and SDK pins against the plan. From root, rerun `flutter pub get --enforce-lockfile` and `dart pub workspace list`.
- [X] T008 [US1] Write a failing widget test in `apps/showcase/test/home_test.dart` for the expected core-derived label, representative narrow and wide layout, text scaling and accessible semantics. Cover keyboard access if the screen has interactive elements (FR-003, FR-004, SHW-007, SHW-008, NFR-ACC-002, NFR-ACC-003, NFR-ACC-005, SC-002). In `apps/showcase`, run `flutter test --no-pub` and record the expected failure before implementing the screen.
- [X] T009 [US1] Compose the core call in `apps/showcase/lib/main.dart` and render its output on a Material 3 home screen. Put visible strings in `apps/showcase/lib/l10n/app_en.arb` and configure localisation in `apps/showcase/pubspec.yaml` and `apps/showcase/l10n.yaml`. Apply [data-model.md](data-model.md) values **Source label** and **Normalised label** at the call site (FR-002, FR-003, DEV-003, SHW-001, SHW-007, UI-001, SC-002). Refresh the root lockfile if dependencies change, then enforce it. In `apps/showcase`, run `flutter analyze --no-pub` and `flutter test --no-pub`. Inspect the use of the core public API.
- [ ] T010 [US1] Verify the build targets under `apps/showcase/android/` and `apps/showcase/web/` (FR-003, DEV-003, SHW-001, SC-002). In `apps/showcase`, run `flutter build apk --debug --no-pub` and `flutter build web --no-pub`. Use `flutter devices`, then run `flutter run --no-pub -d <android-device-id>` and `flutter run --no-pub -d chrome` separately. Record available build and launch results and the visible label. Track unavailable targets as unverified for T021.

**Checkpoint** — US1 is independently testable from a clean checkout using workspace resolution, standalone core tests and the two showcase builds and launches.

**Scaffold and red-test evidence (2026-11-26)** — Flutter 3.50.0 generated Android and web only. Verified AGP 9.3.1, Gradle 9.5.0, template Android API and NDK pins, and explicit Build Tools 36.0.0. From root, `flutter pub get --offline --enforce-lockfile` passed and `dart pub workspace list` showed both members. Before adding the screen, `flutter test --no-pub` in `apps/showcase` exited 1 because `lib/main.dart` and `ShowcaseApp` did not exist.

**Showcase verification (2026-11-26)** — Refreshed the root lockfile with `flutter pub get --offline` and enforced it with `flutter pub get --offline --enforce-lockfile`. In `apps/showcase`, `flutter gen-l10n` generated the English resources, Dart format reported zero changes, `flutter analyze --no-pub` reported no issues, and `flutter test --no-pub` passed all three widget tests. Reviewed the call to the public core API. The home screen has no interactive controls requiring keyboard navigation.

**Platform evidence (2026-11-26)** — In `apps/showcase`, `flutter build web --no-pub` and `flutter build web --no-pub --no-web-resources-cdn` both succeeded. Served the build with bundled renderer assets on localhost and verified that Chrome 148 rendered “MileSoft Starter Kit.” `flutter devices` detected Chrome and the Pixel9a emulator running Android 16 (API 36). Earlier Android builds hit host memory and disk limits. With 3.88 GB free at the start of the latest retry, `flutter build apk --debug --no-pub` succeeded using Temurin 17.0.21+9 and produced `build/app/outputs/flutter-apk/app-debug.apk` (157,880,450 bytes). T010 remains open for the Android launch check.

## Testing · 00.11 · US2

- [X] T011 [US2] Verify the deterministic suites in `packages/milesoft_core/test/normalize_label_test.dart` and `apps/showcase/test/home_test.dart` (FR-004, SHW-008, NFR-MNT-006, SC-001, SC-002, SC-003). Run `dart test` from core and `flutter test --no-pub` from showcase. Add an applicable regression test for a defect found. If shared business logic is present, run `dart test --coverage=coverage` from core and record measured coverage against the 80% target. Record the rationale if the target is inapplicable.

## Quality gates · 00.11 · US2

- [X] T012 [US2] Define dependency verification cases for the valid graph, a missing showcase-to-core edge, a forbidden dependency reachable from core and a workspace cycle in `tool/check_workspace_dependencies.dart` verification notes (FR-002, ARC-003, ARC-006, ARC-007, ARC-008, SC-001). Record the expected pass or failure of each case before implementing enforcement.
- [X] T013 [US2] Add the dependency-boundary check in `tool/check_workspace_dependencies.dart` using the resolved graph and workspace dependencies (FR-002, ARC-003, ARC-006, ARC-007, ARC-008, SC-001). From root run `dart run tool/check_workspace_dependencies.dart`. Exercise each T012 case on isolated fixtures or a disposable verification copy and confirm the expected exit status.
- [X] T014 [US2] Confirm shared lint configuration applies to both members through `analysis_options.yaml` and the member manifests (FR-004, NFR-MNT-005, SC-003). Run `dart analyze --fatal-infos` from root and inspect the resolved lint rules.
- [X] T015 [US2] Verify the local workspace checks from `specs/001-project-foundation/quickstart.md` (FR-004, FR-005, DEV-003, NFR-MNT-005, SC-003). Run `dart format --output=none --set-exit-if-changed packages/milesoft_core apps/showcase tool`, `dart analyze --fatal-infos` and `dart run tool/check_workspace_dependencies.dart`, followed by both member test commands from T011. T016 establishes the scanner pin and verifies the separate supply-chain check.

**Checkpoint** — Local verification catches invalid workspace dependencies and covers shared formatting, lint and tests.

**Verification (2026-11-26)** — From root, `dart format --output=none --set-exit-if-changed packages/milesoft_core apps/showcase tool` reported zero changes, `dart analyze --fatal-infos` reported no issues, and `dart run tool/check_workspace_dependencies.dart` passed. Both members inherit the resolved root lint configuration. Isolated graph cases returned exit 0 for the valid graph and exit 1 for a missing runtime edge, transitive Flutter, transitive Firebase, a workspace cycle and a shared-to-showcase dependency. `dart test` passed four cases in core and `flutter test --no-pub` passed three cases in showcase after `flutter gen-l10n`. The current core only trims display text, so the shared business logic coverage target is inapplicable. `git diff --check` passed.

## GitHub Actions · 00.12 · US2

- [ ] T016 [US2] Configure `.github/workflows/quality.yml` for pull requests and pushes to the primary branch. Use `ubuntu-24.04`, exact toolchain pins, immutable action revisions, least privilege and bounded job time. Enforce the root lockfile and use the format, analysis, boundary, test and build commands and working directories from T010 and T015. Pin OSV-Scanner and run `osv-scanner scan source --lockfile=pubspec.lock` from root in both triggers. Scanner errors and unresolved findings fail the required check unless a documented owner-approved exception applies. Capture the scan result. Require reviewer verification of licences for added or changed third-party dependencies and owner review for unknown or incompatible terms (FR-005, DEV-001, DEV-002, DEV-003, DEV-007, NFR-SEC-009, AC-018, SC-003). Validate the workflow YAML, check command parity with the quickstart, run the scan locally where available and run `git diff --check`.
- [ ] T017 [US2] Verify remote workflow execution and required merge protection for `.github/workflows/quality.yml`, recording evidence in `specs/001-project-foundation/acceptance.md` (FR-005, DEV-004, NFR-SEC-009, AC-018, SC-003). The existing private repository administrator must supply its identity and enable the required checks. With authorized access, inspect compliant PR and primary-branch runs, including scan output, and verify that a controlled failing PR is blocked from a normal merge. Capture the repository identity, workflow URLs, commits, runner image and settings evidence. Keep T017 unchecked and SC-003 `NOT VERIFIED` until the repository and required remote evidence are available.

**Checkpoint** — US2 passes when actual GitHub runs exercise the checks and a failed required check blocks a normal merge.

## Developer documentation · 00.13 · US3

- [ ] T018 [US3] Complete `README.md` and `docs/development/Phase_0_Setup.md` with prerequisites, setup, tests, builds, launches, CI checks, workspace/package addition guidance and links to the governing and feature documents (FR-006, NFR-MNT-002, DEV-003, SC-004). Verify local links and commands against `specs/001-project-foundation/quickstart.md` and `.github/workflows/quality.yml`.
- [ ] T019 [US3] Consolidate approved decisions and deferred approvals in `docs/adr/ADR-001-workspace.md`, `docs/adr/ADR-015-platforms.md` and `docs/adr/phase-0-toolchain.md` (FR-001, FR-005, FR-006, ARC-011, NFR-MNT-004, DEV-007). Verify recorded status, owner approval evidence and pins against `specs/001-project-foundation/research.md`.
- [ ] T020 [US3] Follow `docs/development/Phase_0_Setup.md` from a fresh checkout and record elapsed setup steps, command results and target launches in `specs/001-project-foundation/acceptance.md` (FR-006, DEV-003, SC-004). Using only documented prerequisites, run `flutter pub get --enforce-lockfile`, `dart pub workspace list`, the T010 and T015 commands and the pinned T016 scan.

**Checkpoint** — US3 passes when a fresh-checkout walkthrough independently reproduces setup, checks and launches.

## Acceptance · 00.14

- [ ] T021 Review the approved feature artifacts and `git diff --check` plus the implementation diff against the approved Phase 0 starting commit. Complete `specs/001-project-foundation/acceptance.md` with requirement IDs, task IDs, commands and PASS, FAIL or NOT VERIFIED status for SC-001 through SC-004 (FR-001 through FR-006, ARC-002, NFR-SEC-009, AC-018). Re-run applicable local checks from T010 and T015 and reconcile T017 and T020. Record scanner version, lockfile scan result, any approved exception and the reviewer’s licence findings and owner dispositions. Keep SC-003 `NOT VERIFIED` while required remote evidence is missing. Recommend internal v0.1.0 only when all mandatory checks pass. Tagging, publication and deployment require separate authorization.

## Dependencies and execution order

- Foundation → Workspace → Core → Showcase → Testing and quality gates → GitHub Actions → Documentation → Acceptance.
- T005 precedes T006. T008 precedes T009. Keep red and green evidence in each respective task.
- US2 requires the US1 packages and tests as CI inputs. Independently verify US2 through a compliant and a controlled failing PR. US3 requires the final commands and workflow as documentation inputs, then validates them through a separate fresh-checkout walkthrough.
- With their inputs available and under the same authorized prompt, T011 and T012 can run in parallel. Evidence review for T018 and approval-record review for T019 can also run in parallel. Keep edits to shared manifests, the lockfile and the acceptance record sequential.

## Implementation strategy

US1 is the first working increment. Demonstrate the core result on both targets before adding CI automation. Then deliver the merge gate and contributor walkthrough as independently verifiable increments. All three stories and the acceptance report are required for Phase 0 completion.
