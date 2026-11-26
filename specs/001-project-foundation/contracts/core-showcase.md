# Core and Showcase Contract

Export `String normalizeLabel(String value)` from `package:milesoft_core/milesoft_core.dart`. Apply Dart string trimming semantics. Preserve the text and internal whitespace. The function is deterministic, synchronous and free of side effects.

| Input | Output |
| --- | --- |
| `"  MileSoft Starter Kit  "` | `"MileSoft Starter Kit"` |
| `"  Two  words  "` | `"Two  words"` |
| Empty or whitespace-only string | Empty string |

The showcase composition root passes a padded localised label through the public API and feeds the result to the Material 3 home screen. English launch and widget checks expect `MileSoft Starter Kit` as visible text. A widget assertion alone checks presentation. Verify the dependency edge and the call to the public API as part of integration review. No user input, routes, persistence or remote APIs are required.
