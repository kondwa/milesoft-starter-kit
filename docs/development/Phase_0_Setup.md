# Phase 0 developer setup

Phase 0 contains a pure Dart library and one Flutter showcase. The showcase calls `normalizeLabel` from `package:milesoft_core/milesoft_core.dart` and displays the resulting “MileSoft Starter Kit” label.

## Prerequisites

- Git and access to the [public repository](https://github.com/kondwa/milesoft-starter-kit).
- Flutter stable 3.50.0 with its bundled Dart 3.14.0 on PATH.
- Eclipse Temurin 17.0.21+9 and an Android SDK with API 36, Build Tools 36.0.0, NDK 28.2.13676358, and accepted SDK licences. Use an Android emulator or device running API 24 or later.
- Chrome for the web launch and OSV-Scanner 2.7.1 for the root lockfile scan.
- Network access for a cold dependency cache and scanner data. Allow disk space for Flutter, Android SDK components, Gradle caches and build outputs. If you use the emulator, keep at least 5 GB free at startup. [Android Emulator disk requirements](https://developer.android.com/studio/run/emulator-troubleshooting#disk-space)

The [toolchain ADR](../adr/phase-0-toolchain.md) records the approved pins. Check the active Android SDK and Java in `flutter doctor -v`. If Flutter selects another JDK, use `flutter config --jdk-dir="<temurin-install-dir>"` with the actual installation path. This changes the local Flutter configuration. The Android project supplies the Gradle wrapper and plugin versions.

## Clone and resolve the workspace

```text
git clone https://github.com/kondwa/milesoft-starter-kit.git
cd milesoft-starter-kit
flutter --version
dart --version
flutter doctor -v
flutter pub get --enforce-lockfile
dart pub workspace list
```

Pub lists the repository root and the members `packages/milesoft_core` and `apps/showcase`. Both use the root `pubspec.lock`. Keep that lockfile under version control. For an intentional dependency change, run `flutter pub get` from root, review the manifest and lockfile diff, then rerun with `--enforce-lockfile`.

## Run local checks

Generate localisation sources from `apps/showcase` before workspace analysis.

```text
flutter gen-l10n
```

Return to the repository root for formatting, static analysis and dependency checks.

```text
dart format --output=none --set-exit-if-changed packages/milesoft_core apps/showcase tool
dart analyze --fatal-infos
dart run tool/check_workspace_dependencies.dart
osv-scanner scan source --lockfile=pubspec.lock
```

Both members inherit the root Dart lint configuration. The dependency check requires the showcase's direct runtime dependency on core and checks for prohibited dependencies and cycles. Review third-party licences whenever dependencies are added or changed.

Run `dart test` from `packages/milesoft_core`. Run the following checks and builds from `apps/showcase`.

```text
flutter test --no-pub
flutter build apk --debug --no-pub
flutter build web --no-pub
```

The showcase outputs are `build/app/outputs/flutter-apk/app-debug.apk` and `build/web/`. See the [public API contract](../../specs/001-project-foundation/contracts/core-showcase.md) for the expected result.

## Launch the showcase

Start the emulator or connect the device, then run `flutter devices` from `apps/showcase`. Replace the Android placeholder with the device ID. Run each launch separately and stop it before starting the next.

```text
flutter run --no-pub -d <android-device-id>
flutter run --no-pub -d chrome
```

For an x64 emulator on a host with limited disk space, build just that architecture and launch the resulting APK. CI still runs the standard Android debug build.

```text
flutter build apk --debug --no-pub --target-platform=android-x64
flutter run --no-pub -d <android-device-id> --use-application-binary=build/app/outputs/flutter-apk/app-debug.apk
```

To check the compiled web output, serve `build/web/` with a local HTTP server and open its URL in Chrome. Confirm that “MileSoft Starter Kit” appears on both targets. Record the device or emulator, Android API, browser, commands and results in the [acceptance evidence](../../specs/001-project-foundation/acceptance.md).

## Credentials and local configuration

Keep real credentials, signing keys and production data out of commits and PR attachments. Use dummy values in tracked examples and verify staged changes before pushing. The root `.gitignore` covers common local environment and signing files. If a credential is exposed, revoke or rotate it promptly and notify the owner.

## CI and package changes

For eligible internal Phase 0 and Phase 1 releases, follow the approved [Solo Maintainer Release Governance ADR](../adr/solo-maintainer-release-governance.md) when an independent reviewer is unavailable. Record the version-bound owner review and licence findings in the [consolidated review](Internal_Release_Review.md) and link the supporting source and PR evidence. Apply the ADR's independent review requirement to the excluded changes.

The [Quality workflow](../../.github/workflows/quality.yml) runs on pull requests targeting `main` and on pushes to `main`. It enforces the lockfile, generates localisations, runs lint, tests, the dependency boundary check and the OSV scan, then builds Android debug and web. The review records any changed dependency terms and escalates unknown or incompatible terms to the project owner. For eligible internal releases, retain the findings in the consolidated release review.

Treat a new workspace member as a scope change. After approval, place a reusable package under `packages/` or a product under `apps/`. Add its path to the root workspace list, set `resolution: workspace` in the new manifest, and declare compatible SDK and dependency constraints. Give a shared package an independent SemVer version, public API documentation and tests. Keep dependencies directed toward shared code. Resolve from root, review the root lockfile, and rerun the workspace checks. [Workspace ADR](../adr/ADR-001-workspace.md)

The [constitution](../../.specify/memory/constitution.md) governs engineering practice. The [SRS](../requirements/SRS.md) defines requirements, and the [SAD](../architecture/SAD.md) describes architecture. The [feature specification](../../specs/001-project-foundation/spec.md) traces Phase 0 requirements to acceptance criteria. The [plan](../../specs/001-project-foundation/plan.md) and [tasks](../../specs/001-project-foundation/tasks.md) define how to deliver and verify them.
