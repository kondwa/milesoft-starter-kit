# ADR — Phase 1 result and failure contract

**Status** — Approved by the project owner on 2026-11-26 under 3A.

## Context

Shared Dart consumers need explicit outcomes and a common field issue type while retaining the existing label API.

## Decision

Preserve `normalizeLabel(String)`. Use typed failures with stable codes for expected validation, authorization and transient errors. Permit null success only when the declared type permits it. Export `ValidationIssue` in 01.07 for `Validator` to reuse in 01.08. Propagate unexpected exceptions with their original stacks and keep diagnostics separate from user-facing failures.

## Alternatives and consequences

Converting unexpected exceptions would hide defects. Separate field issue types would require conversion. A shared type keeps the contract usable from pure Dart.

[Owner approval](../../specs/002-core-design-system/research.md#owner-approvals)
