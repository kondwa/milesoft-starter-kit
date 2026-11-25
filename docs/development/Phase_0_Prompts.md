# MileSoft Starter Kit — Phase 0 Spec Kit and Codex Prompts

Version 0.1.0 | Draft implementation guide

## Preparation

Create and clone a private repository named `milesoft-starter-kit`. Verify Git, Flutter, Dart, uv and Codex. Run `flutter doctor -v`.

```powershell
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
specify init --help
specify init --here --ai codex
specify check
```

CLI syntax is version-dependent; inspect installed help and generated integration files. Copy the SRS to `docs/requirements/SRS.md`, SAD to `docs/architecture/SAD.md`, and constitution to `.specify/memory/constitution.md` after initialization. Review and approve baseline decisions. Run each prompt separately; stop at each review gate.

## 00.01 — Constitution

```text
/speckit.constitution
Read the existing constitution, SRS and SAD. Preserve all twelve principles and mandatory requirements. Align Spec Kit templates and agent guidance. Identify contradictions and outstanding decisions; do not silently resolve material decisions or weaken principles. Do not implement code. Report changes and decisions requiring owner approval.
```

## 00.02 — Specification

```text
/speckit.specify
Create the Phase 0 Project Foundation specification using the SRS, SAD and constitution. Establish a Dart Pub Workspace, pure Dart milesoft_core package, Flutter showcase targeting Android and web, shared linting, automated tests, GitHub Actions quality gates and developer documentation. Showcase must demonstrate a minimal working core dependency. Define user stories, measurable acceptance criteria, traceability, assumptions and exclusions. Exclude authentication, billing, Firebase integration, production deployment and advanced UI. Do not implement code.
```

## 00.03 — Clarification

```text
/speckit.clarify
Review Phase 0 against governing documents. Identify unresolved SDK versions, workspace structure, private package distribution, platforms, CI runners, tests and governance. Ask focused questions; recommend lean defaults. Record approved clarifications. Do not implement code.
```

## 00.04 — Plan

```text
/speckit.plan
Develop the technical plan using approved specification and governing documents. Use native Pub Workspaces, pure Dart core and Flutter showcase for Android and web. Pin compatible toolchains, use shared linting, deterministic tests and GitHub Actions. Keep dependencies minimal; defer Firebase, billing, auth, BLoC and GetIt unless justified by approved scope. Define layout, contracts, test strategy, setup, ADRs and verification commands. Do not implement code.
```

## 00.05 — Tasks

```text
/speckit.tasks
Generate ordered, independently verifiable tasks grouped into foundation, workspace, core, showcase, testing, CI, documentation and acceptance. Include files, dependencies, requirement IDs and verification commands. Put failing tests before new behavior. Include checkpoints. Mark complete only after verification. Exclude later phases.
```

## 00.06 — Analysis

```text
/speckit.analyze
Perform read-only consistency analysis of specification, plan and tasks against SRS, SAD and constitution. Identify gaps, conflicts, violations, untestable criteria, unnecessary dependencies and scope creep. Verify traceability. Classify severity and propose corrections. Do not modify files or implement.
```

Resolve material findings before implementation. For each following prompt use `/speckit.implement` only if it respects the requested task scope; otherwise use an ordinary Codex prompt.

## 00.07 — Repository foundation

```text
/speckit.implement
Implement only the approved Repository foundation tasks from Phase 0 tasks.md. Create approved directories, README, gitignore, shared analysis configuration and documentation directories. Preserve governing documents and Spec Kit files. Do not create empty future packages. Verify structure.
Report changed files, actual verification results and blockers. Mark only successfully verified tasks complete.
```

## 00.08 — Dart Pub Workspace

```text
/speckit.implement
Implement only the approved Dart Pub Workspace tasks from Phase 0 tasks.md. Create root pubspec with approved SDK constraints and workspace members milesoft_core and showcase. Configure workspace resolution and compatible dependencies. Verify resolution and membership; document toolchain. No invented versions or overrides concealing conflicts.
Report changed files, actual verification results and blockers. Mark only successfully verified tasks complete.
```

## 00.09 — Core package

```text
/speckit.implement
Implement only the approved Core package tasks from Phase 0 tasks.md. Keep core pure Dart and independent of Flutter, Firebase and products. Write failing tests before implementing only the minimal approved public contract needed by showcase. Document API, format, analyze and test. Defer full core abstractions to Phase 1.
Report changed files, actual verification results and blockers. Mark only successfully verified tasks complete.
```

## 00.10 — Showcase

```text
/speckit.implement
Implement only the approved Showcase tasks from Phase 0 tasks.md. Create minimal Flutter Android and web app demonstrating core dependency. Use Material 3 and a simple home screen. Write widget tests. No auth, billing, Firebase, onboarding or advanced navigation. Analyze, test and build available platforms.
Report changed files, actual verification results and blockers. Mark only successfully verified tasks complete.
```

## 00.11 — Quality gates

```text
/speckit.implement
Implement only the approved Quality gates tasks from Phase 0 tasks.md. Configure shared linting, formatting, deterministic tests and appropriate dependency checks. Verify core has no Flutter/Firebase dependencies and shared packages do not depend on showcase. Avoid speculative tooling. Run checks.
Report changed files, actual verification results and blockers. Mark only successfully verified tasks complete.
```

## 00.12 — GitHub Actions

```text
/speckit.implement
Implement only the approved GitHub Actions tasks from Phase 0 tasks.md. Configure pull request and primary branch CI with pinned compatible toolchain, reproducible dependencies, format, analysis, unit/widget tests and Android debug/web builds. Least privilege; no production deployment or live credentials. Validate syntax and local equivalents; distinguish actual remote CI results.
Report changed files, actual verification results and blockers. Mark only successfully verified tasks complete.
```

## 00.13 — Documentation

```text
/speckit.implement
Implement only the approved Documentation tasks from Phase 0 tasks.md. Document prerequisites, workspace, dependency management, development/test commands, showcase, CI, adding packages and relationship of governing documents and feature specs. Record approved ADRs and pending decisions. Verify documented commands where possible.
Report changed files, actual verification results and blockers. Mark only successfully verified tasks complete.
```

## 00.14 — Acceptance

```text
/speckit.implement
Implement only the approved Acceptance tasks from Phase 0 tasks.md. Review approved spec, plan, tasks and governing documents. Run mandatory checks and review Git diff for scope creep, security, architecture and unnecessary dependencies. Produce traceability report with PASS, FAIL or NOT VERIFIED and evidence. Recommend v0.1.0 only when mandatory criteria pass. Do not tag, push or deploy without approval.
Report changed files, actual verification results and blockers. Mark only successfully verified tasks complete.
```

## Local verification (PowerShell)

```powershell
flutter pub get
dart pub workspace list
dart format --output=none --set-exit-if-changed .
cd packages/milesoft_core
dart analyze
dart test
cd ../../apps/showcase
flutter analyze
flutter test
flutter build web
flutter build apk --debug
flutter run -d chrome
```

## Acceptance

- [ ] Governing documents and Phase 0 spec/plan approved
- [ ] Tasks reviewed and consistency findings resolved
- [ ] Workspace resolves; core remains pure Dart
- [ ] Core tests and showcase widget tests pass
- [ ] Showcase consumes core
- [ ] Analysis and formatting pass
- [ ] Android debug and web builds pass
- [ ] Actual GitHub Actions CI passes
- [ ] Documentation and traceability complete
- [ ] No unresolved critical defects; owner approves release

## Limitations

This is a proposed guide, not an executed implementation. Spec Kit command syntax and SDK compatibility have not been verified against installed versions. Private package distribution remains a pending ADR; prove external consumption before claiming reusable release readiness. Phase 0 intentionally defers full UI and app packages to subsequent phases.
