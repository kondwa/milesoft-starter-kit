# ADR — Phase 1 application configuration

**Status** — Approved by the project owner on 2026-11-26 for 01.12.

## Context

The starter kit needs to validate product settings before dependent features start and allow deterministic test configuration.

## Decision

- Apply product defaults, the selected environment, and explicit test-only overrides in that order. Replace named settings field by field and merge flags by key. Omitted fields inherit. Validate the merged result so an invalid winning value produces a structured issue.
- Require a nonblank application name. The application ID uses dot-separated segments. Each segment starts with an ASCII letter and contains only ASCII letters, digits or underscores.
- Require language, region and currency defaults that belong to the product's declared supported values.
- Require absolute HTTP or HTTPS legal and support URLs with a host and without embedded credentials. Branding overrides are optional. Reject blank asset references when supplied.
- Accept boolean feature flags only. An absent flag disables its optional feature. Flags are local to the immutable configuration snapshot and never grant privileged access.
- Report all invalid required fields as structured validation issues before dependent features start.

## Consequences

Products declare their supported locale values. Each environment can supply only the values it overrides. Invalid overrides fail startup validation and callers can map field issues to localised messages.

[Owner approvals](../../specs/002-core-design-system/research.md#configuration-approval-for-0112)
