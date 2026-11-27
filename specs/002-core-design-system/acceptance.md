# Phase 1 accessibility and testing evidence

Prompt 01.22 was verified locally on Windows with Flutter 3.50.0 and Dart 3.14.0, using the working tree based on `de4932d`. Remote CI for the reviewed revision and merge enforcement require separate evidence under DEV-004.

## Architecture and coverage

| Check | Local result |
| --- | --- |
| `flutter pub get --offline --enforce-lockfile`, `dart pub workspace list` | Passed. Three workspace members and no lockfile content change. Online dependency resolution was unexecuted. |
| `flutter gen-l10n` in the showcase | Passed. |
| `dart run tool/test/check_workspace_dependencies_test.dart` | Eight regression cases passed. The first run failed before the new checker entry point existed. Cases cover prohibited direct and transitive dependencies, workspace cycles and non-public imports. |
| `dart run tool/check_workspace_dependencies.dart` | Passed against the actual workspace. The checker verifies declared dependencies and import/export boundaries. |
| Core `dart test --concurrency=1 --coverage=coverage/phase-1-serial` | 39 tests passed. The initial concurrent run encountered a VM service WebSocket failure. |
| UI `flutter test --no-pub --coverage` | 33 tests passed. UI coverage was 207 of 214 executable lines (96.7%). |
| Showcase `flutter test --no-pub --reporter expanded` | 17 tests passed, including all eight new viewport, scale and appearance combinations. Initial runs measured the inner editable semantics rectangle or tapped the input while the field was partly above the scroll viewport. The final test measures the decorated input, scrolls it fully into view and verifies focus near its upper edge. |

Core LCOV includes all instrumented `packages/milesoft_core/lib` files. The denominator includes executable lines in the shared configuration, clock, logging, pagination, result and retry code and the export file. It excludes declarations that LCOV does not count as executable and test code. Coverage was **121 of 125 executable lines (96.8%)**, exceeding the SRS 80% shared-business-logic target by 16.8 percentage points. Core and UI counts are independent.

## Platform builds

`flutter build web --no-pub` passed in 315.8 seconds and produced `apps/showcase/build/web`. The Wasm dry run also passed. `flutter build apk --debug --no-pub` passed with two Gradle workers. Gradle assembled the APK in 49.9 seconds and produced `apps/showcase/build/app/outputs/flutter-apk/app-debug.apk`. Both builds use the application runtime from 01.21.

## Accessibility evidence

| Area | Automated widget scope | Platform evidence and gaps |
| --- | --- | --- |
| Keyboard and focus | Catalogue activation and navigation, form control keyboard interactions, focus preservation and dialog behavior are exercised in the showcase and shared UI suites. | Chrome opened the catalogue with Tab and Enter. Full forward and reverse traversal, visible focus, Escape and return to the dialog trigger on both platform profiles remain unverified. |
| Semantics | Labelled catalogue and form actions, the invalid name field, status text, attribution and control states are covered. | The Chrome accessibility tree exposed the catalogue heading, theme selector and five destinations at 1280 × 800 and 320 × 640. Assistive technology announcements and Android accessibility tree inspection remain unverified. |
| Contrast | Shared UI tests cover representative theme and component contrast. | Contrast measurements across all rendered states and appearances remain unverified. |
| Pointer and touch targets | Flutter's Android guideline checks the catalogue. The form test checks the decorated text field's interactive area separately from the smaller editable text semantics rectangle. | Per-control web CSS-pixel measurements and device touch-target measurements remain unverified. |
| Text scaling and overflow | The catalogue and invalid form exercise 320 and 1280 logical pixels, 100% and 200% text scaling, and light and dark host appearances. Separate cases cover adaptive panes and attribution. | Chrome rendered the narrow catalogue at default scale. The browser and Android 200% matrix, both Android viewport profiles, and host appearance changes while in system mode remain unverified. |

Chrome 148.0.7778.168 was exercised via headless browser automation with visual inspection of the narrow catalogue screenshot. The APK installed on a Pixel 9a API 36 emulator (1080 × 2424 physical pixels at 420 dpi, approximately 411 × 923 logical pixels before system insets, font scale 1.0). The activity reached the resumed state on retry and rendered the home label and catalogue button after a Bluetooth system dialog was dismissed. A subsequent tap on the catalogue button was followed by an Android “isn't responding” dialog. The cause was unverified, UI Automator produced no hierarchy, and Android catalogue navigation remains open. These checks provide scoped accessibility evidence. WCAG conformance has not been assessed.

### Android retry

The same Pixel 9a API 36 profile initially showed an Android System UI timeout. Logcat recorded startup timeouts in System UI and Google services. Once the emulator settled, the activity returned `Status: ok`. Tapping **Browse catalogue**, **Forms**, and **Validate form** succeeded. UI Automator exposed the catalogue heading, theme selector and all five destinations. It also exposed the name field and its `Enter a name.` validation error. This verifies catalogue navigation and form validation on the default phone profile. T034 remains open for the other platform configurations, full keyboard and focus review, contrast, and per-control target measurements. The cause of the earlier showcase timeout remains unverified.

Phase 0 SC-002, SC-003 and SC-004 remain tracked in the [Phase 0 acceptance record](../001-project-foundation/acceptance.md).

## 01.23 documentation and CI review

The owner approved proceeding with the requirements checklist item still open. Compared 43 public symbols with the public contract and verified 34 local documentation link paths. The API review found additive changes relative to the Phase 0 `normalizeLabel` contract. Both package manifests remain at `0.1.0`, and the starter kit target remains `v0.2.0` subject to final acceptance.

The exact UI README theme snippet ran as a Flutter widget smoke test. An initial extraction captured Markdown and caused the first smoke test and analysis run to fail. After extracting the intended block, the smoke test passed and the temporary harness was removed before rerunning analysis. The showcase suite exercised the linked configuration fixture. Local locked offline resolution, workspace listing, localisation generation, formatting, analysis, eight architecture regression cases, the workspace boundary checker and all 89 core, UI and showcase tests passed. `git diff --check` passed.

Parsed the workflow YAML and compared the package test, formatting and boundary commands with the quickstart. The `Phase 0 quality` job now includes the UI suite and boundary regression runner. The lockfile, licence review, scanner and platform build steps retain their existing configuration. The Android and web build evidence above is from 01.22. The updated workflow, dependency scan and required-check enforcement still need remote evidence for the reviewed revision.

## 01.24 final acceptance review

Reviewed the Phase 1 workspace on Windows with Flutter 3.50.0 and Dart 3.14.0. The tree includes staged, unstaged and untracked Phase 1 changes over base SHA `de4932dc0d09ca8a88523b3f09f596abd891b6d9`. The base SHA identifies the checkout and cannot identify the reviewed working-tree content on GitHub. GitHub's pull-request workflow lookup for the base returned no runs.

**Release recommendation — Hold v0.2.0.** The full T034 accessibility matrix, remote CI and required-check enforcement remain open. Phase 0 SC-002, SC-003 and SC-004 retain their earlier disposition and separate evidence. Approval to conduct this review does not record a release approval or waive outstanding criteria.

### SRS traceability

PASS means the scoped requirement has supporting evidence. NOT VERIFIED means required evidence remains incomplete. FAIL denotes a condition exercised with a failing result. The earlier Android timeout did not recur in the successful default-phone navigation and form retry. Its cause remains unverified.

| SRS ID | Result | Evidence |
| --- | --- | --- |
| COR-001 | PASS | Result tests cover success, failure and nullable values. |
| COR-002 | PASS | Result and retry tests cover exception propagation and safe diagnostic fields. |
| COR-003 | PASS | Validator and configuration tests verify structured issues. |
| COR-004 | PASS | Pagination tests cover bounds, sorted and filtered fixtures, and continuation. |
| COR-005 | PASS | Clock and ID tests exercise UTC and deterministic identifiers. |
| COR-006 | PASS | Logger tests exercise event capture and metadata allowlisting. |
| COR-008 | PASS | Retry tests exercise transient classification, eligibility, backoff and exhaustion. |
| COR-009 | PASS | Clock and ID tests exercise injected implementations. |
| CFG-001 | PASS | Configuration fixtures assert the product name and identifier. |
| CFG-002 | PASS | Configuration and theme tests exercise branding references and product overrides. |
| CFG-003 | PASS | Configuration fixtures cover development, staging and production and verify precedence. |
| CFG-004 | PASS | Flag fixtures disable preview while unrelated flags remain enabled. |
| CFG-005 | PASS | Configuration fixtures cover language, region and currency defaults. |
| CFG-006 | PASS | Configuration tests validate legal and support URLs. |
| CFG-007 | PASS | Invalid merged settings return typed field issues without exposing input values. |
| UI-001 | PASS | Theme and component tests exercise shared Material 3 styling. |
| UI-002 | PASS | Theme and catalogue tests cover light, dark and system choices. |
| UI-003 | PASS | Theme tests cover semantic color and partial typography overrides. |
| UI-004 | PASS | Token tests verify spacing, radius and elevation roles. |
| UI-005 | PASS | Form tests exercise text entry, selection controls, validation and reset. |
| UI-006 | PASS | Widget tests exercise button and card variants, dialogs and notifications. |
| UI-007 | PASS | Status widgets and showcase tests cover all four states and retry. |
| UI-008 | PASS | Widget tests cover narrow and wide layouts and scaled content. Platform accessibility evidence is tracked separately. |
| UI-009 | NOT VERIFIED | Chrome catalogue activation and widget focus tests passed. Full browser keyboard and visible focus walkthrough is open. |
| UI-010 | PASS | Attribution widget and showcase tests verify the approved localised text fallback. |
| UI-011 | PASS | Catalogue inventory and navigation are covered by showcase tests and scoped platform checks. |
| ARC-002 | PASS | Each shared manifest carries its own version. |
| ARC-006 | PASS | Dependency checker and regression cases verify inward dependencies. |
| ARC-007 | PASS | Dependency checker and cycle regression pass. |
| ARC-008 | PASS | Dependency checker and tests verify pure core and public package boundaries. |
| ARC-011 | PASS | Shared constraints match the consumers and locked resolution passed. |
| NFR-SEC-009 | PASS | The checksum-verified OSV-Scanner v2.7.1 scanned 66 locked packages locally and reported no issues. |
| LOC-005 | PASS | Showcase strings are externalised and localisation generation passed. |
| SHW-001 | PASS | Showcase inventory and deterministic fixtures cover the capabilities delivered in Phase 1. |
| SHW-002 | PASS | Catalogue is discoverable with five destinations. |
| SHW-006 | PASS | Showcase exercises loading, empty and error examples, with recovery. |
| SHW-007 | PASS | Showcase widget tests exercise narrow and wide layouts. |
| SHW-008 | PASS | Showcase integration and foundation regression tests pass locally. |
| SHW-009 | PASS | Showcase tests exercise all theme selections and use generated localised strings. |
| NFR-ACC-001 | NOT VERIFIED | Scoped checks provide evidence toward the target. Full applicable review remains open. |
| NFR-ACC-002 | NOT VERIFIED | Representative widget labels and Chrome and Android accessibility trees passed. Full platform matrix remains open. |
| NFR-ACC-003 | NOT VERIFIED | Widget tests at 100% and 200% passed. Platform text-scale matrix remains open. |
| NFR-ACC-004 | NOT VERIFIED | Status widgets provide text and distinct cues. Full rendered-state review remains open. |
| NFR-ACC-005 | NOT VERIFIED | Chrome Tab and Enter and widget Escape/focus checks passed. Complete browser traversal remains open. |
| NFR-ACC-006 | NOT VERIFIED | Representative automated contrast and target checks passed. Per-control platform measurements remain open. |
| DEV-001 | NOT VERIFIED | The workflow configures PR analysis. Execution for this working tree has no remote PR evidence. |
| DEV-002 | NOT VERIFIED | The workflow configures all three suites for PRs. Execution for this working tree has no remote PR evidence. |
| DEV-003 | PASS | Workspace, boundary checks and showcase exercise both shared packages locally. |
| DEV-004 | NOT VERIFIED | GitHub returned HTTP 403 on the required-status-check endpoint and reported that this private repository needs GitHub Pro or public visibility to enable that feature. No controlled failing PR was available. |
| AC-018 | NOT VERIFIED | Remote pipeline evidence for the reviewed Phase 1 contents is unavailable. |

### Local test and coverage rerun

| Check | Result |
| --- | --- |
| SDK versions and `flutter pub get --offline --enforce-lockfile` | PASS. The pinned SDKs resolved from local caches with the root lockfile enforced. |
| `dart pub workspace list` and `flutter gen-l10n` | PASS. Three members and the workspace root resolved. Showcase localisations generated. |
| Workspace formatter and `dart analyze --fatal-infos` | PASS. 50 Dart files checked and no analysis issues. |
| `dart run tool/test/check_workspace_dependencies_test.dart` and `dart run tool/check_workspace_dependencies.dart` | PASS. Eight boundary cases and the actual workspace check passed. |
| Core `dart test --concurrency=1 --coverage=coverage/phase-1-final` | PASS. All 39 tests passed. Reported 121 of 125 executable lines in core `lib/` (96.8%), above 80%. |
| UI `flutter test --no-pub --coverage` | PASS. All 33 tests passed. Reported 206 of 214 executable lines in UI `lib/` (96.3%). |
| Showcase `flutter test --no-pub` | PASS. All 17 tests passed. |
| Showcase `flutter build web --no-pub` | PASS. Produced `apps/showcase/build/web`. Wasm dry run passed. |
| Showcase `flutter build apk --debug --no-pub` | PASS. Produced `apps/showcase/build/app/outputs/flutter-apk/app-debug.apk`. Gradle assembled the debug build in 8.6 seconds. |
| `osv-scanner scan source --lockfile=pubspec.lock` | PASS. Windows amd64 v2.7.1 matched the release asset SHA-256 `7121dcf420aefbbf89a7f0050c4d3094e079ff93afd334dfc96f16b02ec85800`. Exit 0, 66 packages, no issues reported. |

Core coverage counts are from LCOV restricted to core `lib/`. The first formatter invocation passed a package name where a directory was expected. After correcting that, the formatter's built-in threshold reported 6.63% across a wider instrumented scope. Summing the emitted core-only `LH` and `LF` records applies the SRS threshold to the intended denominator.

### Phase 1 success criteria

| Criterion | Result | Evidence |
| --- | --- | --- |
| SC-001 | PASS | Core scenarios, boundary checks and the shared business logic coverage target passed. |
| SC-002 | NOT VERIFIED | CONFIG-1 covers all three environment fixtures. CONFIG-2 has passing focused tests for invalid values, flag precedence and isolation, concentrated on the production fixture. The full cross-environment matrix remains unverified. |
| SC-003 | NOT VERIFIED | Automated showcase and shared widget checks and scoped Chrome and Android checks passed. T034 platform checks remain open. |
| SC-004 | NOT VERIFIED | Local tests and both builds passed. The updated remote workflow and branch enforcement remain unverified. |

### Release blocker recheck

- **Latest protection and owner approval.** GitHub now reports `main` protected with required PR reviews. The classic rule has no required status checks configured, and no open PR exists. The owner requested approval of remaining approval requirements. Recorded as owner intent to proceed once mandatory evidence is complete. No acceptance exception or distribution ADR approval was specified. Release remains on hold for T034, reviewed PR CI and proof that a failing mandatory check blocks merging, alongside the separately tracked Phase 0 gaps.

- **Classic protection and API 36 follow-up.** GitHub returned `protected: false` for `main`, HTTP 404 `Branch not protected` from the classic protection endpoint, an empty active rules list and no open PRs. On the restarted API 36 emulator (1080 × 2424, font scale 1.0), APK installation and activity launch passed. Both UI Automator captures failed, so this follow-up established launch only. The prior successful API 36 catalogue and form hierarchy evidence remains above. T034 and merge enforcement remain open.

- **SC-002 now passes locally.** Added validation, override precedence and flag isolation cases for development, staging and production. All ten configuration tests passed using the cached Dart test runner. The standard `dart test` invocation encountered restricted package-network and telemetry access.
- **Android smoke passed on the restarted emulator.** On API 37 at 1080 × 2400 and 420 dpi, cold launch returned `Status: ok`. Touch navigation opened the catalogue and Forms, and UI Automator exposed the name validation error after submission. The approved API 36 phone result remains recorded above. T034 still requires the remaining reference profiles, text scales, keyboard and focus checks, contrast and target measurements.
- **GitHub visibility and access confirmed.** The repository is public and the authenticated viewer has admin access. The classic required-check endpoint returned 404 `Branch not protected` and the active rules endpoint for `main` returned an empty list. A successful push run exists at `883d7bc755be5aaceefa26f5595ebad8378a60ae` (run `45800249983`). PR CI for the reviewed changes and a controlled failure proving merge enforcement remain unverified. The release recommendation remains hold.
