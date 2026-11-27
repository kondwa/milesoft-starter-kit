# Deferred release quality improvements

These checks move out of the internal pre-1.0 gate under the [approved quality ADR](../adr/internal-release-quality.md). Existing scoped passes remain valid. Every item below is **open**, and critical defects remain release blockers. Before public beta or stable production, resolve the items applicable to the announced support and obligations or record an owner disposition where allowed.

| Item | Requirements | Completion evidence |
| --- | --- | --- |
| QI-01 · Exhaustive contrast and targets | NFR-ACC-001/006, UI-4 | Record contrast and fully visible interactive hit bounds for every required control and state across supported profiles, appearances and scales. Record applicable thresholds and fix verified regressions. |
| QI-02 · Complete keyboard traversal | UI-009, NFR-ACC-005 | Capture forward and reverse order across catalogue and form interactions, including visible focus and activation. On Android, use a keyboard or input method that reliably delivers modifiers. |
| QI-03 · Modal and interaction paths | UI-006, UI-009, NFR-ACC-002/005 | Verify dialog action variants, Escape where enabled, focus restoration, disabled and loading controls and retry feedback across the approved platform matrix. |
| QI-04 · Spoken screen-reader verification | NFR-ACC-001/002/004 | With audio enabled, record TalkBack navigation, activation, reading order and spoken names, roles, state and validation errors. Add equivalent checks for other assistive technologies in the approved support matrix. |
| QI-05 · Distribution and production verification | ADR-002, ADR-013, SRS §14 | Record owner decisions, clean external-consumer and publishing checks when distributing, and approve and execute the applicable beta or production verification matrix before that release. |
