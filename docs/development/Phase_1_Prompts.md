# MileSoft Starter Kit — Phase 1 Spec Kit and Codex Prompts

Version: 0.1.0 | Draft implementation guide | Target release: v0.2.0

## Operating instructions

Use the existing repository and installed Spec Kit integration. Verify generated command names; if slash commands are unavailable, use the prompt body with the equivalent installed skill or ordinary Codex workflow. Run one prompt at a time. Review and approve each checkpoint before proceeding. Do not reinitialize the repository or replace Phase 0 work.

Governing inputs: `.specify/memory/constitution.md`, `docs/requirements/SRS.md`, `docs/architecture/SAD.md`, approved ADRs and Phase 0 acceptance evidence. Read these before each increment. Resolve material conflicts with the owner rather than silently changing requirements.

For every implementation increment: select only matching approved tasks; write failing tests for new behavior first; implement minimally; format, analyze and test; report changed files, task IDs, actual command results and blockers; mark only verified tasks complete. Stop at the checkpoint. If `/speckit.implement` cannot restrict scope, use ordinary Codex with the same instructions.

## Sequential prompts

### 01.01 — Baseline review

```text
Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Inspect the actual Phase 0 repository, acceptance report, Git status, workspace, SDK constraints, public APIs and CI configuration. Run available baseline checks. Compare the governing documents with the implementation. Report failures, missing evidence and conflicting decisions; stop before implementation if mandatory baseline checks fail. Do not overwrite user changes.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.02 — Specification

```text
/speckit.specify

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Create the Phase 1 feature specification for core abstractions and design system. Cover COR, CFG and UI requirements applicable to this phase using exact IDs from the SRS. Define developer and showcase user stories, measurable acceptance criteria, edge cases and exclusions. Include light/dark/system themes, accessible responsive controls and pure Dart contracts. Defer auth, billing, Firebase, app shell and CLI. Do not implement code.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.03 — Clarification

```text
/speckit.clarify

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Resolve material ambiguities in the specification: public API compatibility, failure taxonomy, pagination semantics, retry safety, configuration precedence, theme overrides, brand assets, accessibility and supported platforms. Ask focused questions; record approved answers and distinguish proposals from decisions. Do not implement code.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.04 — Technical plan

```text
/speckit.plan

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Produce a technical plan with package boundaries, public exports, dependency graph, API contracts, design tokens, widget behavior, test strategy, migration from Phase 0 and requirement traceability. Keep core pure Dart. Make UI depend on core only where justified. Prefer SDK primitives over dependencies. Define acceptance commands and ADRs. Do not implement code.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.05 — Task generation

```text
/speckit.tasks

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Generate ordered tasks grouped by the implementation increments 01.07–01.24. Include file paths, dependencies, requirement IDs, test-first tasks and verification commands. Identify checkpoints and parallelizable work without conflicting edits. Do not implement code.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.06 — Consistency analysis

```text
/speckit.analyze

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Perform read-only analysis of specification, plan and tasks against governing documents. Identify missing requirements, contradictory contracts, untestable criteria, dependency violations and scope creep. Rank findings by severity and recommend corrections. Stop for approval of material changes.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.07 — Result and failure

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement approved Result<T> and Failure contracts with explicit success/failure handling, stable failure codes and safe diagnostic separation. Define nullability and exception conversion semantics. Test success, failure, mapping and propagation; do not swallow unexpected exceptions or expose sensitive details.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.08 — Use cases and validation

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement approved UseCase and Validator contracts. Define input/output typing, synchronous versus asynchronous behavior and structured field errors. Test valid and invalid inputs and failure propagation. Avoid forcing inheritance where simple functions suffice.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.09 — Pagination and filtering

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement Page<T>, PaginationParams and only approved filtering abstractions. Define cursor or offset semantics, limits, empty results and continuation behavior. Test boundaries and invalid requests. Keep database-specific query types outside core.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.10 — Clock, identifiers and logging

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement Clock, IdGenerator and Logger contracts with deterministic test doubles. Define UTC handling, identifier guarantees and structured logging levels. Avoid logging secrets or personal data; do not use predictable identifiers for security tokens. Test time and logging behavior.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.11 — Retry policies

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement approved retry policy with bounded attempts, backoff, injectable delay and retry classification. Retry only explicitly safe/idempotent operations; do not retry validation or authorization failures by default. Test exhaustion, success, non-retryable failures and cancellation if supported. Use fake delays.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.12 — Application configuration

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement AppConfig, Environment and FeatureFlags according to approved contracts. Define precedence, validation, safe defaults and immutable configuration. Test missing and malformed values and environment isolation. Never treat client flags as authorization or embed secrets.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.13 — UI package foundation

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Create milesoft_ui as a Flutter workspace member with public exports, README, linting and tests. Resolve dependencies with existing toolchain. Keep product and Firebase dependencies out. Add core dependency only if an approved contract requires it. Verify workspace and package analysis.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.14 — Design tokens

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement semantic colors, typography, spacing and radius tokens with approved brand defaults and product overrides. Use semantic roles rather than hardcoded component colors. Test token consistency and contrast. Do not invent official brand assets; document provisional values.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.15 — Material 3 themes

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement MileSoftTheme for light, dark and system theme selection through the consuming app. Support product color and typography overrides and semantic component themes. Test theme construction, overrides and readable contrast. Avoid global mutable state.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.16 — Form controls

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement approved MileSoftTextField and form controls using Flutter primitives. Support labels, errors, disabled/read-only states, keyboard types, focus and accessibility semantics. Respect controller ownership and disposal. Test input, validation display and keyboard behavior.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.17 — Buttons, cards and dialogs

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement approved MileSoftButton, MileSoftCard and MileSoftDialog variants. Support disabled/loading states, keyboard focus, semantic labels and safe dialog dismissal. Prevent duplicate activation while loading. Test callbacks, states and theme overrides.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.18 — Loading, empty and error states

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement reusable loading, empty and recoverable error states with optional actions and localized caller-supplied text. Avoid exposing raw exceptions. Test semantics, retry callbacks and layouts with long text.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.19 — Responsive layouts

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement approved responsive layout primitives using available constraints and documented breakpoints. Support narrow and wide screens, text scaling, keyboard navigation and RTL where applicable. Test representative widths and overflow behavior. Avoid device-name assumptions.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.20 — Branding components

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Implement PoweredByMileSoft using approved brand assets if available; otherwise use a clearly documented text-only fallback. Support theme contrast and accessibility. Do not fetch or invent logos. Test layout and semantics.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.21 — Showcase catalogue

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Extend the existing showcase with a navigable catalogue of implemented core and UI features, including theme switching, responsive examples and all component states. Keep examples deterministic and free of live services. Preserve Phase 0 behavior or document approved migration. Test catalogue navigation and representative examples.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.22 — Accessibility and testing

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Audit all components for keyboard access, focus, semantics, contrast, touch targets, text scaling and overflow. Add missing unit/widget tests and architecture boundary checks. Run coverage and compare shared business logic against the SRS target. Build Android debug and web. Distinguish automated checks from manual accessibility review; do not claim WCAG conformance from tests alone.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.23 — Documentation and API review

```text
/speckit.implement

Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Document public APIs, examples, package dependencies, configuration, theme customization, accessibility limitations and migration notes. Update ADRs, changelog and architecture documentation for approved decisions. Review breaking changes and versioning; avoid undocumented public exports. Verify examples and CI coverage for both packages.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 01.24 — Final acceptance

```text
Read the governing documents and current Phase 1 artifacts. Follow the operating instructions in this guide.

Review the complete Phase 1 diff and approved spec, plan, tasks and governing documents. Run mandatory checks and produce a requirement-by-requirement PASS/FAIL/NOT VERIFIED report with commands and evidence. Report coverage, accessibility limitations, unresolved defects and remote CI status. Recommend v0.2.0 only if mandatory criteria pass. Do not push, tag, publish or deploy without explicit approval.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

## Verification commands

Run from repository root (adapt to the approved Phase 0 scripts):

```powershell
flutter pub get
dart pub workspace list
dart format --output=none --set-exit-if-changed .
Push-Location packages/milesoft_core
dart analyze
dart test
Pop-Location
Push-Location packages/milesoft_ui
flutter analyze
flutter test --coverage
Pop-Location
Push-Location apps/showcase
flutter analyze
flutter test
flutter build web
flutter build apk --debug
Pop-Location
```

Run the existing CI workflow and record actual remote results separately.

## Acceptance checklist

- [ ] Phase 0 baseline verified and Phase 1 specification, plan and tasks approved.
- [ ] All applicable COR, CFG and UI requirements traced to evidence.
- [ ] Core remains pure Dart; no circular or product-specific dependencies.
- [ ] Core contracts and configuration tested; retry safety verified.
- [ ] UI package resolves and supports light/dark themes and product overrides.
- [ ] Components cover approved states, accessibility and responsive behavior.
- [ ] Showcase demonstrates all delivered components.
- [ ] Formatting, analysis, tests, coverage target and platform builds verified.
- [ ] Remote CI passes; no unresolved critical defects.
- [ ] Documentation, ADRs, changelog and release readiness approved.

## Scope and limitations

Component names and sequencing are proposed, subject to approved specifications and actual repository contracts. No Phase 0 repository, SDK compatibility, or test results have been independently verified for this guide. Authentication, billing, Firebase integration and application shell remain out of scope. The guide does not authorize a release or external repository changes.
