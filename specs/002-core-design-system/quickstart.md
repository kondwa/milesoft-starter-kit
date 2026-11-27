# Acceptance quickstart

Run against the approved Phase 1 SDK matrix, which retains the [Phase 0 pins](../../docs/adr/phase-0-toolchain.md). These commands are planned for the completed implementation. Record the actual versions, commit, platform targets and outcomes. Use the established Phase 0 setup for Android tooling.

From the repository root in PowerShell:

```powershell
flutter --version
dart --version
flutter pub get --enforce-lockfile
dart pub workspace list
Push-Location apps/showcase
flutter gen-l10n
Pop-Location
dart format --output=none --set-exit-if-changed packages/milesoft_core packages/milesoft_ui apps/showcase tool
dart analyze --fatal-infos
dart run tool/test/check_workspace_dependencies_test.dart
dart run tool/check_workspace_dependencies.dart
Push-Location packages/milesoft_core
dart test --coverage=coverage
Pop-Location
Push-Location packages/milesoft_ui
flutter test --no-pub --coverage
Pop-Location
Push-Location apps/showcase
flutter test --no-pub
flutter build web --no-pub
flutter build apk --debug --no-pub
Pop-Location
```

Check each process exit code before continuing. Expect three members, the approved dependency graph and passing tests. In 01.22, record executable and covered lines for shared business logic using core coverage output, document the file scope and compare the ratio against 80%. UI coverage is separate evidence. Use the pinned Phase 0 lockfile scanner and capture PR licence review for dependency changes. Verify remote CI against the reviewed SHA and record merge enforcement separately under DEV-004.

The required `Phase 0 quality` job now runs format, analysis, both boundary checks, and the core, shared UI and showcase suites. The job runs the package suites without coverage instrumentation. Use the coverage commands above for acceptance evidence. The job retains locked dependency resolution, the PR licence review reminder, the scanner and both platform builds. [Quality workflow](../../.github/workflows/quality.yml)

## Manual acceptance

1. Use an API 36 Android emulator with phone and expanded viewport profiles, and desktop Chrome with responsive viewport emulation. Record the Android image, browser version, actual logical viewport and effective text scale. Verify the core-derived label and discover all delivered catalogue examples.
2. Switch light, dark and system modes. Change host appearance while in system mode. Verify overrides and attribution in both appearances.
3. At 320 and 1280 logical pixels and default and 200% text scale, check theme selection, catalogue links, a labelled form field and its error, the dialog trigger and actions, and the error retry button in light and dark modes. Require usable layout, meaningful names and states, and no loss of content or action. Use 4.5:1 text contrast, 3:1 for large text, and 3:1 for required non-text indicators under applicable WCAG 2.2 criteria. Apply a 24 × 24 CSS pixel web pointer target minimum or document the applicable WCAG exception. Use a 48 × 48 logical pixel Android touch target as the Phase 1 verification criterion. On web, use Tab and Shift+Tab from catalogue navigation through theme selection and form actions, activate controls with Enter or Space as applicable, dismiss the dialog with Escape where dismissal is enabled, and verify visible focus returns to its trigger. Record defects and unverified combinations. Report these checks as scoped evidence. [WCAG 2.2](https://www.w3.org/TR/WCAG22/)
4. Exercise loading, empty, success and recoverable error examples and retry. Verify disabled, read-only and loading interactions.
5. Match results to SC-001 through SC-004 and the individual requirement matrix. Report the existing Phase 0 SC-002, SC-003 and SC-004 gaps separately. No pre-implementation command results are implied by this guide.
