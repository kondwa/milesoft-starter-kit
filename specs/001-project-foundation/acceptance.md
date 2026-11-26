# Phase 0 acceptance evidence

## 00.14 release review — 2026-11-26

**Release recommendation** — Hold internal v0.1.0. SC-002, SC-003 and SC-004 still require evidence. Release approval has not been recorded.

Reviewed the ratified [constitution](../../.specify/memory/constitution.md), [SRS](../../docs/requirements/SRS.md), [SAD](../../docs/architecture/SAD.md), [approved Phase 0 scope and requirement mappings](spec.md#scope-and-traceability-mandatory), [plan](plan.md), [owner decisions](research.md) and [tasks](tasks.md). All 15 specification-quality items were checked. The project has no separately recorded Phase 0 starting SHA, so the review used the docs-only repository commit `dee6886a169f46df5b76793399279d22c30fa2a0` as the comparison baseline. The application, workspace, lockfile, lints, dependency checker and workflow match the passing `main` commit `883d7bc755be5aaceefa26f5595ebad8378a60ae`.

| Criterion | Status | Requirements and tasks | Evidence |
| --- | --- | --- | --- |
| SC-001 — Workspace and core boundaries | **PASS** | FR-001, FR-002, FR-004, ARC-002, ARC-011 · T003–T006, T011–T015, T020 | The fresh checkout resolved the two workspace members with the enforced root lockfile. Core declares its own SemVer version `0.1.0` and the showcase uses its public API. The standalone core suite and resolved dependency check passed. |
| SC-002 — Platform builds and launches | **NOT VERIFIED** | FR-002, FR-003, FR-004, DEV-003, SHW-001, SHW-007, SHW-008 · T007–T011, T016, T020 | The passing `main` run produced both builds. The local web rebuild and three showcase tests passed, and the unchanged implementation rendered the expected label in Chrome during T020. Android manual launch is unverified. |
| SC-003 — CI and merge enforcement | **NOT VERIFIED** | FR-004, FR-005, DEV-001–DEV-004, DEV-007, NFR-SEC-009, AC-018 · T011–T017 | Local checks and the primary-branch workflow passed. The PR list is empty, required-check settings return HTTP 403, and the controlled failing PR and reviewer licence evidence are pending. |
| SC-004 — Fresh contributor walkthrough | **NOT VERIFIED** | FR-006, DEV-003, NFR-MNT-002 · T018–T020 | Guide and ADR links resolve. Fresh setup, local checks, web build and Chrome launch passed. The standard Android build ran out of disk space in the disposable checkout. Android x64 built, and the emulator failed its disk-space preflight. |

### Local rerun

- From repository root, `flutter pub get --offline --enforce-lockfile`, `dart pub workspace list`, `dart format --output=none --set-exit-if-changed packages/milesoft_core apps/showcase tool`, `dart analyze --fatal-infos`, and `dart run tool/check_workspace_dependencies.dart` passed. `flutter gen-l10n` ran first from `apps/showcase`.
- In core, `dart test` passed all four cases. In showcase, `flutter test --no-pub` passed all three cases and `flutter build web --no-pub` passed. The core utility normalises display text and contains no shared business logic subject to the 80% coverage target.
- `flutter devices` listed Chrome, Edge and Windows. `adb devices -l` returned no Android devices. The host had about 0.27 GB free after the web build. The review used the successful standard Android build on the same CI commit and the existing local APK as build evidence. A local rebuild and emulator launch require sufficient disk space or another verification host.

### Scope and security review

- The implementation diff stays within the two-member workspace, one core API, minimal Material 3 showcase, tests, quality checks and documentation. Core has no runtime package dependencies. The showcase's Flutter and localisation dependencies support the approved UI. The dependency checker adds no package dependencies.
- `git diff --check dee6886` passed. The tracked credential-file and token-pattern checks returned zero matches in the reviewed scope. CI uses `contents: read`, disables checkout credential persistence and pins actions and downloaded tools. Android evidence covers the debug build.
- OSV-Scanner 2.7.1 rescanned `pubspec.lock` and reported no issues across 66 packages. All 62 hosted packages had local licence notices. PR reviewer licence verification and any owner dispositions remain pending. There are no recorded scan exceptions.
- T010, T017 and T020 remain open. The remaining evidence is the manual Android launch, the complete fresh Android walkthrough, a passing PR with licence review and a controlled failing PR blocked from merge. The distribution and licensing approvals under ADR-002 and ADR-013 remain deferred.

## SC-003 — Quality checks and merge enforcement

**Status** — NOT VERIFIED · 2026-11-26

GitHub confirmed [kondwa/milesoft-starter-kit](https://github.com/kondwa/milesoft-starter-kit) is private and uses `main` as its default branch. The local `origin` matches that repository.

**Local CI equivalents** — Workflow lint, locked dependency resolution, generation, format, analysis, dependency boundaries, four core tests, three widget tests, Android debug build and web build passed. OSV-Scanner 2.7.1 scanned 66 packages from `pubspec.lock` and reported no issues. See [T016 verification](tasks.md#github-actions--0012--us2).

| Evidence | Result |
| --- | --- |
| Primary-branch run | [Quality run 45800249983](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45800249983) passed on push to `main` at `883d7bc755be5aaceefa26f5595ebad8378a60ae`. Runner image was `ubuntu-24.04` version `20261122.23.1`. Lockfile enforcement, formatting, analysis, dependency boundaries, both test suites, Android debug and web builds passed. |
| Compliant pull request run and licence review | The pull request list was empty. Passing PR checks and reviewer evidence are pending. |
| Required checks and controlled merge failure | The required-status-checks endpoint returned HTTP 403 and reported that this private repository needs GitHub Pro to enable the feature. No controlled blocked merge was verified. |
| Remote lockfile scan | OSV-Scanner checked 66 packages from the root lockfile and reported no issues in the passing `main` run. |

T017 remains unchecked. The passing `main` run satisfies the primary-branch evidence. Once the repository supports private branch protection, the administrator must require **Phase 0 quality** and pull request review for `main`. Reviewers verify licences for added or changed third-party dependencies, record the outcome on the pull request and refer unknown or incompatible terms to the project owner. Remaining evidence is a passing PR and a controlled failing PR blocked from a normal merge. [GitHub protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)

## SC-004 — Fresh-checkout developer walkthrough

**Status** — NOT VERIFIED · 2026-11-26

Followed the [developer setup guide](../../docs/development/Phase_0_Setup.md) against a clean local clone of `main` at `883d7bc755be5aaceefa26f5595ebad8378a60ae`. The host used Flutter 3.50.0, Dart 3.14.0 and Temurin 17.0.21+9.

| Step | Result | Elapsed |
| --- | --- | --- |
| Clone and setup | `flutter doctor -v`, `flutter pub get --enforce-lockfile` and `dart pub workspace list` passed. Pub listed core and showcase under the workspace root. | 70.9 s |
| Local checks | Localisation generation, format, analysis, dependency boundaries, four core tests and three showcase tests passed. OSV-Scanner 2.7.1 checked 66 packages and found no issues. | 80.9 s |
| Web build and launch | `flutter build web --no-pub` passed. Served the generated output on localhost and verified that Chrome 148 rendered “MileSoft Starter Kit”. | 81.4 s build |
| Android debug build | `flutter build apk --debug --no-pub` failed during `mergeDebugNativeLibs` because the host ran out of disk space. | 128.9 s |
| Android x64 debug build | `flutter build apk --debug --no-pub --target-platform=android-x64` passed after the disposable checkout's failed build output was cleared. | 80.7 s |
| Android launch | The Pixel9a emulator exited at its disk-space check. The host had 1.98 GB free after clearing regenerable checkout caches. No physical Android device was connected. | Not verified |

T020 remains unchecked. The standard Android build from this checkout and the Android launch still need verification. The standard Android build previously passed in the linked `main` workflow.
