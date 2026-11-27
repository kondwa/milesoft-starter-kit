# Data model — proposed Phase 1 contracts

| Entity | Fields and invariants |
| --- | --- |
| Result and Failure | Result.branch denotes exactly one outcome. Result.value is present on success and may be null only if the declared type permits it. Failure.code is stable. Failure.fieldIssues optionally contains safe ValidationIssue entries. Diagnostic capture is separate from the result seen by UI. |
| ValidationIssue | ValidationIssue.code is stable and ValidationIssue.fieldKey identifies the field. The caller resolves display copy through its resources. Multiple issues can refer to one field. |
| PaginationParams and Page | PaginationParams.offset ≥ 0 and PaginationParams.size is 1–100. Page.items is immutable. Page.nextOffset is nullable and uses the same offset basis in the filtered order. A terminal or empty page has no continuation. No database-specific objects cross the contract. |
| RetryPolicy | RetryPolicy.attemptLimit includes the first attempt. RetryPolicy.initialDelay and RetryPolicy.delayCap bound backoff under the approved policy. See [retry transitions](#retry-transitions). |
| AppConfig | AppConfig.environment selects development, staging or production. AppConfig.name, AppConfig.identifier, AppConfig.brandingReferences, AppConfig.localeDefaults, AppConfig.urls and AppConfig.featureFlags are fields of the immutable snapshot. Replace named settings field by field and merge flags by key in defaults, selected environment and test-only override order. Omitted values inherit. Validate winning values under the [approved configuration rules](../../docs/adr/phase-1-app-config.md). Produce an immutable snapshot or structured startup issues. |
| Theme inputs | ThemeInputs.colorOverrides and ThemeInputs.typographyOverrides apply independently to light and dark. ThemeInputs.spacing, ThemeInputs.elevation and ThemeInputs.radius represent the shared token roles. ThemeInputs.mode is owned by the consuming app for the session. |
| Component state | ComponentState.enabled, ComponentState.readOnly and ComponentState.loading describe applicable interaction states. ComponentState.status covers loading, empty, success and error. ComponentState.action can invoke the caller only when the control is actionable. |

Field identities in this table document constraints. They do not require separate public properties where an approved contract represents the same constraint through types or constructor arguments.

## Retry transitions

Unsafe work executes once. For explicitly safe work, retry only a classified transient failure, with the approved delay between attempts. Success, terminal failure and exhaustion end the sequence. Exhaustion returns the final typed failure. Unexpected exceptions propagate.
