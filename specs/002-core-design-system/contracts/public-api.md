# Proposed public package contracts

## milesoft_core

Export from package:milesoft_core/milesoft_core.dart. Preserve String normalizeLabel(String value) and its current trimming semantics. New contracts are additive.

| Public surface | Behaviour |
| --- | --- |
| Result<T>, Failure, ValidationIssue | Explicit success or expected failure. Proposed stable default codes are validation, authorization and transient. Map only recognised exceptions at a boundary. Unknown exceptions propagate with their stack. Mappers run only for success and pass failures through unchanged. Result and Failure introduce the shared ValidationIssue type. Validator reuses it in the next increment. |
| UseCase<I, O>, Validator<T> | Use cases may be expressed as functions returning FutureOr<Result<O>>. Keep validation synchronous with structured field errors. Let consumers use plain functions without an inheritance requirement. |
| PaginationParams, Page<T> | Validated offset and size, immutable result items and nullable next offset. Consumers supply typed filtering and deterministic order. Use explicit continuation information. |
| Clock, IdGenerator, Logger | Clock supplies UTC instants. Caller injects an ID source and defines uniqueness within its domain. IDs generated here carry no security-token guarantee. Logger accepts a severity, event and allowlisted structured fields without personal data or secrets. |
| RetryPolicy | Explicit retry-safe opt-in, bounded attempts and bounded backoff with injectable delay. Only classified transient failures retry. |
| Environment, FeatureFlags, AppConfig | Development, staging and production. Immutable validated snapshots and local optional module flags. Winning invalid values fail validation. Flags never grant privileged access. |

## milesoft_ui

Export the public theme builder, tokens and approved widgets from package:milesoft_ui/milesoft_ui.dart. Keep render helpers and catalogue fixtures internal.

| Public surface | Consumer behaviour |
| --- | --- |
| MileSoftTheme and semantic tokens | Build Material 3 light/dark themes and let consumers select light, dark or system. Use ColorScheme roles such as primary/onPrimary, surface/onSurface and error/onError, plus TextTheme roles. Propose spacing roles of 4/8/16/24/32 logical pixels, radius roles of 4/8/16 and elevation roles of 0/1/3. Values require design review. Per-mode color and typography overrides preserve semantic role routing. |
| MileSoftTextField | Label, error text, keyboard type, focus and disabled/read-only inputs. Callers retain ownership of controllers and focus nodes they supply. |
| MileSoftButton, MileSoftCard, MileSoftDialog | Theme-aware controls and surfaces. Disabled/loading actions are inert. Dialog exposes a result and an explicit dismiss policy, with predictable focus. |
| Local notification and status presentations | Use an in-app Material notification with caller text. State presentations accept caller text and optional action. Recoverable errors offer retry without exposing raw exceptions. |
| Responsive layout and PoweredByMileSoft | Size by available constraints. Verify narrow and wide layouts with long text. Preserve keyboard order and accessible names. Use approved branding or the accessible text fallback. |

Showcase supplies externalised text, deterministic examples and navigation. UI contracts accept ordinary strings and callbacks without depending on core types.
