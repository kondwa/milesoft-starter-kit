# ADR — Phase 1 pagination and retry

**Status** — Approved by the project owner on 2026-11-26.

## Context

Shared Dart consumers need bounded paging and predictable retries while retaining control of filtering, ordering and operation safety.

## Decision

**Pagination (01.09).** Use zero-based offsets and explicit page sizes from 1 through 100. Report a negative offset or out-of-range page size as a typed validation failure. Callers apply typed filters and a stable sort before paging. The data source supplies explicit continuation information. Return an immutable page with a nullable `nextOffset`. Empty and terminal pages return null. A full page alone provides insufficient continuation evidence.

**Retry (01.11).** Retry only when callers explicitly identify an operation as safe to retry and its failure is classified as transient. Default to three total attempts, counting the initial call. Start with a 100 ms delay and double it between attempts up to a 1 s cap. Inject delay for deterministic tests. Return the last typed failure on exhaustion and propagate unexpected exceptions.

## Alternatives and consequences

Cursor pagination would require a separate continuation contract. The chosen policy uses caller-defined filtering and stable ordering, and relies on the source to distinguish full terminal pages from pages with more results. Automatic retries for all failures could repeat unsafe work. Explicit opt-in and transient classification bound that risk and preserve the caller's terminal failure.

[Owner approvals](../../specs/002-core-design-system/research.md#increment-approvals-for-0109-through-0121)
