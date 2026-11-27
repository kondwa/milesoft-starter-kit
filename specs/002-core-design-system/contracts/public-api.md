# Phase 1 public package contracts

## milesoft_core

Export from package:milesoft_core/milesoft_core.dart. Preserve String normalizeLabel(String value) and its current trimming semantics. New contracts are additive.

| Public surface | Behaviour |
| --- | --- |
| Result<T>, Success<T>, Failed<T>, Failure, FailureCode, ValidationIssue | Explicit success or expected failure. Stable codes are validation, authorization and transient. Map recognised exceptions at the boundary that can interpret them. Unknown exceptions propagate with their stack. Mappers run on success and pass failures through unchanged. Validator shares the ValidationIssue type. |
| UseCase<I, O>, Validator<T> | Use cases may be expressed as functions returning FutureOr<Result<O>>. Keep validation synchronous with structured field errors. Let consumers use plain functions without an inheritance requirement. |
| PaginationParams, Page<T> | Zero-based offset and page size 1–100. Invalid input reports a typed validation failure. Consumers filter and stably sort before paging. The source supplies explicit continuation. Items are immutable and nextOffset is null for empty or terminal pages. |
| Clock, SystemClock, IdGenerator, Logger, LogLevel, LogEntry | Clock.nowUtc returns UTC instants, with SystemClock backed by the host wall clock. IdGenerator.generate delegates uniqueness to the injected implementation and carries no security-token guarantee. Logger.log emits entries at debug, info, warning or error to an injected sink. Use fixed event identifiers and explicitly allowlisted numeric or boolean metadata. The allowlist defaults to empty and callers must keep personal or secret values out of all log inputs. |
| RetryPolicy | RetryPolicy.run accepts synchronous and asynchronous operations. Set retrySafe to true to retry a Failed outcome with FailureCode.transient. The default is three total attempts, with a 100 ms first delay that doubles up to a 1 s cap. The attempt limit must be positive and delays nonnegative. A caller may inject the delay. Return the last outcome on exhaustion and propagate operation or delay exceptions. |
| Environment, FeatureFlags, AppConfig | Development, staging and production. Validate the winning values after merging named fields and boolean flags under the [approved configuration rules](../../../docs/adr/phase-1-app-config.md). Return an immutable snapshot or structured field issues. Absent flags disable their features. Flags never grant privileged access. |

## milesoft_ui

Export the public theme builder, tokens and approved widgets from package:milesoft_ui/milesoft_ui.dart. Keep render helpers and catalogue fixtures internal.

The entry point re-exports standalone Material `ColorScheme`, `TextTheme`, `ThemeData` and `ThemeMode`. Supporting types include `MileSoftFormOption<T>` for radio and dropdown records, `MileSoftButtonVariant`, `MileSoftCardVariant` and `MileSoftStatus`. `MileSoftTokens` exposes the semantic schemes and the spacing, radius and elevation scales.

| Public surface | Consumer behaviour |
| --- | --- |
| MileSoftTheme and semantic tokens | MileSoftTheme.build provides light and dark Material 3 variants. The consuming MaterialApp selects light, dark or system. A supplied color scheme must match the requested brightness. Cards, filled buttons and input outlines use shared component tokens. Use ColorScheme roles such as primary/onPrimary, surface/onSurface and error/onError, plus TextTheme roles. MileSoftTokens resolves a ColorScheme and TextTheme for a mode. The approved provisional seed is #2563EB with Material 3 typography. Spacing is 4/8/16/24/32, radius is 4/8/16, and elevation is 0/1/3 in logical pixels. Products can supply a semantic color scheme and merge partial typography overrides for each mode. |
| MileSoftTextField | Label, error text, keyboard type, focus and disabled/read-only inputs. Callers retain ownership of controllers and focus nodes they supply. |
| MileSoftCheckbox, MileSoftSwitch, MileSoftRadioGroup, MileSoftDropdown | Accept localised labels, initial values, validators, enabled state and optional change callbacks. Participate in Flutter Form validation and reset. Radio and dropdown options use typed value and label records with unique values. |
| MileSoftButton, MileSoftCard, MileSoftDialog | Buttons support filled, tonal, outlined and text variants, and disable activation during caller-controlled loading. Cards support elevated, filled and outlined surfaces. MileSoftDialog.show returns a typed result. Incidental dismissal is disabled by default and can be enabled at the call site. |
| MileSoftNotification | Show caller-localised feedback through the active ScaffoldMessenger and Material SnackBar. |
| MileSoftStatusView | Select loading, empty, success or error. Supply a localised title, optional message and optional action. Use safe display copy and supply a retry callback for recoverable errors. Status text is announced by a live region, and long content can scroll. |
| MileSoftResponsiveLayout | Stack the primary and secondary panes below the caller-supplied breakpoint or when width is unbounded. At the breakpoint and above, use equal-width columns with token spacing. Follow ambient directionality and keep primary-to-secondary keyboard order. The caller chooses the breakpoint based on pane content and supplies vertical scrolling where needed. |
| PoweredByMileSoft | Supply a localised attribution label for a themed surface. The approved text-only fallback uses the theme’s body-small text style and on-surface color. |

Showcase supplies externalised text, deterministic examples and navigation. UI contracts accept ordinary strings and callbacks without depending on core types. Use standalone material_ui for Material types shared with the showcase, using the approved direct UI package dependency.
