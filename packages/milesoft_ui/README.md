# milesoft_ui

Shared Material UI for MileSoft Flutter applications. This package inherits the root lint configuration and uses the root workspace lockfile.

Import the public entry point with:

```dart
import 'package:milesoft_ui/milesoft_ui.dart';
```

The foundation exposes the standalone Material theme types `ColorScheme`, `TextTheme`, `ThemeData` and `ThemeMode` for use in the design system. They are the same types the showcase uses from `material_ui`. MileSoftTokens supplies semantic colors, typography, spacing, radius and elevation. The default light and dark palettes use the provisional seed #2563EB and Material 3 typography. Products can provide a semantic color scheme and partial typography overrides for each mode.

For light, dark and system selection, supply both variants to the app and pass
the app's current theme mode. Each variant accepts its own color scheme and
partial typography overrides. Supply a color scheme with matching brightness.

```dart
import 'package:material_ui/material_ui.dart' show Brightness, MaterialApp;
import 'package:milesoft_ui/milesoft_ui.dart';

final app = MaterialApp(
  theme: MileSoftTheme.build(),
  darkTheme: MileSoftTheme.build(brightness: Brightness.dark),
  themeMode: ThemeMode.system,
);
```

The theme applies shared tokens to cards, filled buttons and text-field
outlines.

Pass `colorOverrides` and `typographyOverrides` to `MileSoftTheme.build` for each appearance that needs customization. A matching-brightness `ColorScheme` supplies the semantic roles and a partial `TextTheme` merges with the defaults. Recheck contrast and focus indicators after applying product overrides. The showcase and package theme tests exercise these options.

`MileSoftTextField` participates in a Flutter `Form` and uses the active
theme's input styling. Pass a localised label and validation messages.
A supplied `errorText` takes precedence over the validator. Callers retain
ownership of any controller or focus node they supply.

The runtime dependencies are the Flutter SDK and standalone `material_ui`. Resolve dependencies from the repository root with `flutter pub get --enforce-lockfile`. Run `flutter analyze --no-pub` and `flutter test --no-pub` from this package.

`MileSoftCheckbox`, `MileSoftSwitch`, `MileSoftRadioGroup` and
`MileSoftDropdown` use native Material controls and participate in form
validation and reset. Supply localised labels and validator messages.
The controls own their form values after initialisation. Optional
`onChanged` callbacks report user changes. Radio and dropdown options use
typed `(value: ..., label: ...)` records with unique values.

`MileSoftButton` supports filled, tonal, outlined and text variants. A null
callback disables it, and setting `loading` blocks activation while showing
progress. Pass a localised `loadingLabel` for its progress announcement.
`MileSoftCard` provides elevated, filled and outlined theme-aware surfaces.

Open `MileSoftDialog` with `MileSoftDialog.show<T>` and close it with a
caller-supplied action. The returned future carries the action result.
Pass `dismissible: true` to allow incidental dismissal.

Use `MileSoftNotification.show` with a context under a
`ScaffoldMessenger` and a localised message for transient in-app feedback.

`MileSoftStatusView` presents loading, empty, success and error states.
Supply a localised title that identifies the state, optional safe display
copy, and an optional `(label: ..., onPressed: ...)` action for retry or
another next step. Long content can scroll within the available height.

`MileSoftResponsiveLayout` stacks its two panes below the supplied
`wideMinWidth` and lays them out as equal-width columns at that width and
above. An unbounded width uses the stacked layout. Choose the breakpoint
from the content's needs, and wrap the layout in a scroll view when its
content may exceed the available height. The layout follows the surrounding
text direction and traverses the primary pane before the secondary pane.

`PoweredByMileSoft` renders text-only attribution on a themed surface.
Supply a localised label such as the English “Powered by MileSoft”. The
text follows system scaling and uses the active theme’s on-surface color.

## Integration and accessibility

The package is independently versioned at `0.1.0`. Consumers in this workspace declare `milesoft_ui: ^0.1.0` and use standalone `material_ui: ^1.11.1` when they compose Material widgets or pass theme types. Existing core-only consumers can adopt the UI as a separate dependency. Keep controllers and focus nodes owned by the caller and use the public entry point for shared types. [Public API reference](../../specs/002-core-design-system/contracts/public-api.md)

Provide localised labels, status announcements and error messages in the consuming app. Check contrast, interactive target sizes, responsive layout and keyboard focus with the app's actual themes, strings and layouts. Package widget tests and scoped Chrome and Android checks provide regression evidence. The full manual matrix remains open and WCAG conformance has not been assessed. [Accessibility evidence](../../specs/002-core-design-system/acceptance.md)
