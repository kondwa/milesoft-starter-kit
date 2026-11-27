# MileSoft Starter Kit --- Phase 2 Spec Kit and Codex Prompts

Version: 0.1.0 \| Draft implementation guide \| Target: internal v0.3.0

## Operating instructions

Use the existing repository; do not reinitialize Spec Kit. Read `.specify/memory/constitution.md`, `docs/requirements/SRS.md`, `docs/architecture/SAD.md`, approved ADRs, Phase 0/1 acceptance records and `docs/development/Internal_Release_Review.md`. The owner reports internal GO for v0.1.0 at `697147f` and v0.2.0 at `8f9e1b7`; verify locally. Tags, publication and deployment are separately authorized. Preserve accepted baselines and user changes.

Run one prompt at a time. Verify installed Spec Kit command names; use equivalent installed skills or ordinary Codex prompts if slash commands are unavailable. For 02.07--02.25 select only matching approved tasks; if implementation command cannot restrict scope, use ordinary Codex. Write failing tests first for new behavior, implement minimally, format/analyze/test, update only verified tasks and stop at each checkpoint. Report changed files, task IDs, commands, actual outcomes, evidence and decisions requiring approval. Never fabricate CI, device, OAuth or emulator results. Resolve material conflicts with owner before proceeding.

## Proposed package boundaries

- `milesoft_auth`: provider-neutral identity, use cases, state and reusable presentation; core/UI dependencies only as justified.
- `milesoft_profile`: profile contracts and workflows; core/UI/auth as justified.
- `milesoft_firebase`: implements auth/profile contracts using Firebase SDKs; no reverse dependency.
- Showcase/product composition root selects adapters; backend Firebase functions and rules are separately deployed per product/environment.

These boundaries are proposals subject to actual repository and approved SAD/ADRs. No new empty packages for future phases. Preserve independent package versions; v0.3.0 is an internal kit milestone, not a mandate to bump every package.

## Sequential prompts

### 02.01 --- Baseline and release verification

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Inspect Git status, workspace members, SDK constraints, existing APIs, CI and the release governance ADR. Read docs/development/Internal_Release_Review.md and both acceptance records. Verify that 697147f and 8f9e1b7 resolve to the reviewed commits and that current HEAD descends from the accepted baseline or has an approved transition. Confirm internal GO evidence including T034 disposition; do not require tags or publication. Run existing baseline checks. Report any regressions, missing evidence or uncommitted changes; stop on mandatory blockers. Do not alter historical records or accepted commits.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.02 --- Feature specification

``` text
/speckit.specify

Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Specify Phase 2 identity and profiles using exact AUT-001–015, PRF-001–007 and applicable BCK, UI, security and privacy IDs from the SRS. Define registration, session restoration, sign-out, verification, recovery, social sign-in, protected navigation, profile provisioning/editing, reauthentication and deletion stories. Specify Android and web reference coverage; record Apple applicability and iOS validation separately. Define failure, cancellation, offline, duplicate request, account collision and cross-user scenarios. Define measurable accessibility and security acceptance criteria now. Distinguish mandatory, should and could requirements; defer billing, full shell, onboarding, general settings and unrelated backend services. No code.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.03 --- Requirements clarification

``` text
/speckit.clarify

Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Ask focused questions about provider support by platform, verification policy, account linking, profile schema and avatar storage, preferences scope, deletion retention and completion SLA, emulator configuration, package visibility and licensing. Identify product-specific policy versus reusable defaults. Obtain approval for any deferral of mandatory requirements, including Apple where applicable; do not assume an unavailable device waives a requirement. Record decisions and unresolved blockers. No code.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.04 --- Technical plan

``` text
/speckit.plan

Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Design dependency graph, public APIs, identity/session state machine, profile schema, Firebase adapters, backend callable contracts and rules, deletion workflow and test matrix. Reuse existing Result/Failure, configuration and UI APIs rather than inventing replacements. Use constructor injection and composition-root wiring; BLoC/Cubit where approved. Keep Firebase types out of domain contracts. Define emulator setup, platform provider setup, security threat model, accessibility reference profiles, independent consumer tests, ADRs and rollback strategy. Resolve any proposed localization dependency without creating a circular dependency or empty future package. No code.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.05 --- Task generation

``` text
/speckit.tasks

Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Generate ordered tasks with exact requirement IDs, file paths, dependencies, test-first steps and verification commands. Include negative security tests, profile recovery, session races, deletion retries, accessibility evidence and publication dry runs. Map each task to a prompt increment; include acceptance matrix and explicit manual evidence tasks. No implementation.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.06 --- Consistency analysis

``` text
/speckit.analyze

Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Perform read-only comparison of spec, plan, tasks, SRS, SAD, constitution and release ADR. Flag missing mandatory requirements, unsafe auth assumptions, dependency cycles, untestable criteria and scope creep. Check every mandatory requirement maps to tests or explicit manual evidence. Report severity and proposed corrections. Stop until material findings are resolved.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.07 --- Authentication package foundation

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Create only approved milesoft_auth workspace member and public entrypoint, metadata, tests and example scaffolding. Keep provider-neutral contracts free of Firebase and platform SDK types; isolate presentation from domain. Reuse existing core and UI dependencies only as justified. Add dependency boundary checks and keep publication disabled. Verify workspace and existing consumers.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.08 --- Authentication domain models and contracts

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Define immutable identity, provider capabilities, session states and auth repository interfaces using existing core result/failure conventions. Distinguish initializing, signed out, signed in, verification required and recoverable errors. Define cancellation, invalid credentials, network, rate limit and recent-login failures without exposing provider internals or sensitive data. Specify stream ordering and lifecycle. Test equality, invariants and failure mapping contracts.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.09 --- Authentication use cases

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement approved registration, sign-in, sign-out, verification, recovery, session observation and reauthentication use cases against interfaces. Validate inputs without logging credentials; avoid account enumeration in recovery responses. Define resend throttling and duplicate submission behavior. Do not store passwords or raw tokens. Test success, failures, cancellation and concurrent operations.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.10 --- Authentication state management

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement approved BLoC/Cubit flows and immutable state; separate session observation from transient form state. Handle initial restoration, sign-out during in-flight requests, stale results, disposal and duplicate taps. Define protected-route policy as UX only, with safe internal return destinations. Clear user-scoped state on sign-out. Test state transitions and race conditions.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.11 --- Fake authentication provider

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Build deterministic fake provider implementing the same contracts, with controllable clock, session stream, failures, cancellation and verification. No real credentials or network. Run reusable contract tests against fake and later emulator adapter. Keep test-only exports isolated; document limitations of fake security behavior.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.12 --- Firebase adapter package

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Create approved milesoft_firebase member with Firebase initialization injected by host, not global project assumptions. Implement provider-neutral mapping and SDK exception translation. Configure emulator endpoints explicitly by platform and environment before use; fail closed if emulator mode is misconfigured. No production credentials, deployment or live data. Verify SDK compatibility and dependency graph.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.13 --- Email and password authentication

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement Firebase Auth adapter for registration, sign-in, sign-out and SDK-managed session persistence. Use official SDK persistence options appropriate to platform; no custom token storage. Handle disabled users, duplicate accounts, wrong credentials and network failures safely. Test registration and session restoration with Auth emulator; distinguish restart/device evidence from unit tests.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.14 --- Verification and recovery

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement verification email, refresh/reload of identity, resend and password reset with approved action URLs and safe error messages. Enforce verification policy consistently in protected backend operations where required, not only UI. Test expired/invalid action codes, throttling, refresh and recovery with emulator where supported. Record manual email-delivery checks separately; do not send live mail.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.15 --- Social authentication

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement Google and Apple adapters only for approved applicable platforms using official flows. Handle cancellation, provider unavailability, account collision and explicit verified linking; never merge accounts based solely on email. Validate OAuth redirect/state/nonce requirements through SDK-supported mechanisms. Document required SHA fingerprints, authorized domains and Apple configuration without secrets. Test mocked flows and record real provider/device evidence separately; emulator success is not proof of live OAuth.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.16 --- Reusable authentication screens

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Build registration, sign-in, verification, reset and reauthentication screens using existing milesoft_ui components. Inject callbacks and policy; avoid Firebase imports and hardcoded product branding. Support localization-ready strings, keyboard navigation, focus/error announcements, autofill, password visibility, loading and cancellation. Test light/dark, 200% text scale, contrast, target sizes and screen-reader behavior against approved reference matrix. Do not change accepted UI APIs without approved migration.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.17 --- Profile package foundation

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Create milesoft_profile with immutable provider-neutral profile model, repository and public exports. Use authenticated UID as identity; define editable fields, server-managed fields, timestamps and approved extension mechanism. Separate preferences from future general settings. No Firebase SDK types in domain. Test serialization boundaries, validation and immutability.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.18 --- Profile management use cases

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement ensure/get/watch/update profile and approved preferences workflows. Make provisioning idempotent and recoverable after successful registration with missing profile. Handle concurrent updates, stale sessions, missing data and sign-out cleanup. Prevent client edits to roles, UID, entitlements and timestamps. Test duplicate provisioning, validation and failure recovery.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.19 --- Firestore profile repository

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement Firebase profile adapter and approved ensureProfile callable if required. Derive UID from authenticated principal, never trust caller-supplied ownership. Use server timestamps and transactional or create-if-absent semantics. Validate allowlisted fields and extension schema. Define offline behavior and conflict handling. Implement avatar storage only if approved, with size/type constraints and owner-scoped paths; otherwise record explicit disposition. Test with Firestore and Functions emulators.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.20 --- Profile management screens

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement reusable profile view/edit and approved preferences/avatar controls using existing UI components. Handle loading, missing profile recovery, validation, save conflicts and unsaved changes. Do not display privileged attributes as editable. Test keyboard, screen reader, 200% text, light/dark and responsive layouts. Verify user A data cannot remain visible after switching to user B.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.21 --- Account lifecycle and deletion

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement approved reauthentication and server-owned deletion request workflow. Derive UID from verified auth context; enforce recent authentication server-side using approved policy. Persist idempotent request and progress, block protected writes during deletion, invoke product-defined cleanup handlers, remove profile/files/device records as applicable, retain only approved legally necessary records and delete identity at appropriate final step. Handle partial failures, retries, duplicate requests and recovery after identity removal. Provide safe status and confirmation UX; explain store subscriptions may require separate cancellation. No live deletion. Test failure injection and cross-user denial.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.22 --- Firebase rules and emulator security

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Implement deny-by-default Firestore and Storage rules where applicable; restrict reads/writes to authorized owners, validate allowed fields, deny privileged changes and deletion-pending writes. Enforce authorization and validation in Admin SDK callables independently of rules; App Check supplements auth and must not be treated as ownership. Test unauthenticated, cross-user, malformed payload, privilege escalation, stale auth, duplicate deletion and pending-deletion cases. Use isolated emulator project and deterministic seed/cleanup; no production access. Document rules coverage and remaining live-only checks.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.23 --- Showcase integration

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Wire fake mode as safe default and explicit emulator mode through composition root. Demonstrate registration, sign-in, verification, reset, profile recovery/editing, protected routes, sign-out and deletion using test identities. Preserve Phase 1 catalogue and existing tests. Validate deep links and clear sensitive state on account switch. Document provider capability differences and avoid claiming unsupported platforms work.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.24 --- Security, accessibility and integration verification

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Execute approved matrix for Android/web and any applicable additional platforms. Run unit, widget, contract, emulator rules, backend and end-to-end tests. Verify session restoration, user switching, cross-user denial, deletion retries and failure recovery. Capture keyboard forward/reverse traversal, modal interactions, spoken screen-reader announcements, 200% text, contrast and touch bounds using approved reference profiles. Distinguish native/device evidence from browser or automated approximations. Run regression checks for Phase 0/1. Record PASS/FAIL/NOT VERIFIED with commands, environment and artifacts; do not waive missing evidence.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.25 --- Documentation and publication readiness

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Document public APIs, integration examples, provider configuration, emulator commands, security assumptions, account deletion hooks, migration and compatibility. Give each package independent metadata, changelog, example and approved license disposition. Check publicly resolvable runtime dependencies and clean external consumer resolution; do not use path overrides to conceal issues. Run publication dry runs only where permitted; report unpublished dependency blockers and name availability as unverified unless checked. Keep private packages publish_to: none; do not change licensing or expose proprietary code without approval. No publication.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

### 02.26 --- Final acceptance and internal release readiness

``` text
Read the governing documents and current Phase 2 artifacts. Follow the operating instructions in this guide.

Review all governing documents, approved ADRs, acceptance matrix, tasks, Git diff and actual CI evidence. Trace each mandatory AUT/PRF and applicable BCK/NFR/AC requirement to evidence; include disposition of should/could items and platform limitations. Verify no regressions against accepted Phase 0/1 baselines. Record reviewed commit, toolchain, tests, manual evidence, unresolved blockers and recommended GO/HOLD for internal v0.3.0. A mandatory FAIL or NOT VERIFIED remains HOLD unless owner formally changes the requirement through governance. Do not authorize your own release, tag, push, publish or deploy. Request separate owner approval.

Stop after this increment and report evidence, blockers and decisions requiring approval.
```

## Verification commands (adapt to approved repository)

From workspace root:

``` powershell
flutter pub get
dart pub workspace list
dart format --output=none --set-exit-if-changed .
```

Run `dart analyze` and `dart test` for pure Dart packages; `flutter analyze` and `flutter test` for Flutter packages and showcase. From showcase run `flutter build web` and `flutter build apk --debug`. Use existing CI scripts as canonical where available. For backend, use its locked dependency install and approved lint/build/test scripts; from configured Firebase directory use `firebase emulators:exec --project demo-milesoft-phase2 --only auth,firestore,functions,storage "<approved test command>"` with only configured emulators. Replace placeholder with actual test command and use isolated demo project; never target production. Run `dart pub publish --dry-run` from eligible package directories only after metadata and dependency review; do not publish. Verify actual remote CI separately.

## Acceptance evidence matrix

  ------------------------------------------------------------------------------------------------------------------------------------------------
  Area                                Minimum evidence
  ----------------------------------- ------------------------------------------------------------------------------------------------------------;
  Baseline                            Accepted commits verified, regression checks pass

  AUT-001--006                        Registration, login, verification, reset, restoration, logout tests

  AUT-007--008                        Applicable provider/platform matrix; real OAuth evidence or explicit blocker

  AUT-009--012                        Session stream, route guards, reauthentication, deletion workflow tests

  AUT-013--015                        Approved disposition and tests for implemented optional capabilities

  PRF-001--007                        Idempotent provisioning, editing, timestamps, preferences, protected fields; avatar/extensions disposition

  Backend security                    Emulator denial tests and callable authorization tests; deletion recovery

  Accessibility                       Approved reference matrix with manual and automated evidence

  Distribution                        Standalone consumption, metadata and dry-run findings; no publication

Release                             Actual CI, traceability, reviewed commit and owner GO/HOLD decision
  ------------------------------------------------------------------------------------------------------------------------------------------------;

For every criterion record requirement ID, test or evidence path, command, environment, commit, outcome and blocker. Missing mandatory evidence is not a pass. Internal acceptance does not authorize public release.

## Deferred scope

Phase 3 owns full application shell, onboarding and general settings. Phase 4 owns billing and entitlements. Later phases own general notifications, analytics, exports, generator and production readiness. Identity-specific hooks may be defined only where necessary; do not implement future modules prematurely.
