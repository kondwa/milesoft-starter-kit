# Phase 0 Validation Quickstart

These commands apply after implementation. Install the pins in the [implementation plan](plan.md) and the OSV-Scanner version pinned by CI. Configure the Android SDK and licenses, and make an Android emulator or device and supported browser available. Record the tool versions and devices used.

From the repository root in a clean checkout:

```text
flutter --version
dart --version
flutter doctor -v
flutter pub get --enforce-lockfile
dart pub workspace list
```

Run `flutter gen-l10n` from `apps/showcase` to produce the localised Dart sources. Then return to the repository root for the shared checks:

```text
dart format --output=none --set-exit-if-changed packages/milesoft_core apps/showcase tool
dart analyze --fatal-infos
dart run tool/check_workspace_dependencies.dart
osv-scanner scan source --lockfile=pubspec.lock
```

Confirm core and showcase resolve together and the core manifest declares its own valid SemVer version. Review the dependency-boundary check for the showcase-to-core edge, workspace cycles, and forbidden dependencies reachable from core. Use the OSV-Scanner version pinned by CI and record the result for the root lockfile. Record the reviewer’s licence verification for added or changed third-party dependencies and refer unknown or incompatible terms to the owner. Review the documented public entry point.

From `packages/milesoft_core`:

```text
dart test
```

From `apps/showcase`:

```text
flutter test --no-pub
flutter build apk --debug --no-pub
flutter build web --no-pub
flutter devices
flutter run --no-pub -d <android-device-id>
flutter run --no-pub -d chrome
```

Run the launch commands separately. Record the Android device or emulator and browser, build and launch results, and visible output defined by the [contract](contracts/core-showcase.md). Check narrow and wide layouts, text scaling, semantics and keyboard access where applicable. Stop and record any command or target that cannot be verified.

For remote acceptance, obtain the approved repository identity and required-check settings from its administrator. Record the compliant PR and main workflow evidence, including traceable equivalent current CI where applicable, and a controlled failing PR that normal merge permissions cannot bypass. Include the scan result and applicable coverage in the acceptance report. Link the consolidated version-bound owner review and licence findings. [Approved amendment](../../docs/adr/internal-release-quality.md)
