# Phase 0 Validation Quickstart

These commands apply after implementation. Install the pins in the [implementation plan](plan.md), configure the Android SDK and licenses, and make an Android emulator or device and supported browser available. Record the tool versions and devices used.

From the repository root in a clean checkout:

```text
flutter --version
dart --version
flutter doctor -v
flutter pub get --enforce-lockfile
dart pub workspace list
dart format --output=none --set-exit-if-changed packages/milesoft_core apps/showcase
dart analyze --fatal-infos
```

Confirm core and showcase resolve together. Inspect the resolved graph and run the documented dependency-boundary check to confirm the showcase-to-core edge, no workspace cycles, and no forbidden dependency reachable from core. Review the documented public entry point.

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

For remote acceptance, record the compliant PR's commit and workflow URL, the primary-branch workflow evidence, and the required check settings. Record a controlled failing PR and confirm that normal merge permissions cannot bypass it. Keep results and applicable coverage evidence with SC-001 through SC-004.
