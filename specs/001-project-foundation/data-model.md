# Phase 0 Data Model

The showcase passes an in-memory display label to core and renders the returned string. The sample is fixed and contains no user or production data.

| Value | Type | Rule |
| --- | --- | --- |
| Source label | Non-null Dart string | Surround the localised sample text with whitespace before the demonstration call |
| Normalised label | Non-null Dart string | Trim leading and trailing whitespace, preserve internal content and case |

No persistent entities, identifiers, database schema, migrations or state transitions are needed. See the [core and showcase contract](contracts/core-showcase.md) for edge cases and expected output.
