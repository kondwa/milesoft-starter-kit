# MileSoft Starter Kit --- Software Architecture Document

  Property         Value
  ---------------- ---------------------------------
  Version          0.1.0
  Date             25 November 2026
  Status           Draft for architectural review
  Classification   Internal
  Repository       `milesoft-starter-kit`
  Baseline         SRS v0.1.0; Constitution v0.1.0

## 1. Purpose and scope

This document translates the SRS into an implementable architecture for a reusable Flutter application SDK, application generator, Firebase backend template and showcase. It is subordinate to the approved SRS and constitution. All decisions herein are proposed until approved; conflicts and material ambiguities must be escalated before implementation. Product-specific business rules, cross-product identity, mandatory AI and proprietary payment processing are excluded.

## 2. Architectural drivers

- Independent product deployment and upgrade; no shared production customer database.
- SIMPEL: extract only cohesive reusable capabilities with demonstrated need.
- Pure Dart domain logic, replaceable adapters, explicit dependencies and test-first development.
- Verified commercial transactions, server-enforced access and privacy-safe operations.
- Android and web first, iOS commercial readiness next; Windows conditional.
- Low operating costs, reproducible builds, accessible and localised interfaces.

## 3. System context and trust boundaries

``` mermaid
flowchart LR
  U[Customer] --> A[Generated Flutter product]
  D[Developer] --> G[MileSoft CLI]
  G --> A
  G --> B[Product backend template]
  A --> SDK[Versioned shared SDK]
  A --> AUTH[Firebase Auth]
  A --> DB[Firestore via security rules]
  A --> B
  B --> DB
  B --> P[Payment provider APIs]
  P --> B
  B --> N[Messaging and email adapters]
  B --> S[Secret Manager]
```

The distributed client is untrusted. Firebase identity establishes a principal, not permission to every resource. App Check supplements but never replaces authorisation. Callable functions verify identity, ownership, entitlement and input. Public webhooks authenticate provider messages independently of Firebase Auth. Admin SDK access bypasses Firestore rules and therefore requires explicit server authorisation. Product/environment boundaries isolate data, secrets, billing accounts or configurations and deployment identities.

## 4. Repository and distribution

``` text
milesoft-starter-kit/
  apps/showcase/
  packages/
    milesoft_core/
    milesoft_ui/
    milesoft_app/
    milesoft_auth/
    milesoft_profile/
    milesoft_onboarding/
    milesoft_billing/
    milesoft_entitlements/
    milesoft_settings/
    milesoft_storage/
    milesoft_notifications/
    milesoft_analytics/
    milesoft_localization/
    milesoft_export/
    milesoft_support/
    milesoft_firebase/
    milesoft_testing/
  backend/firebase/
  templates/flutter_saas/
  tools/milesoft_cli/
  docs/{requirements,architecture,adr}/
  specs/
  .specify/memory/constitution.md
  .github/workflows/
  pubspec.yaml
  analysis_options.yaml
```

These are logical boundaries, not a mandate to create empty packages. Start with core, UI, app and showcase; extract other packages as vertical slices mature. Root Pub Workspace resolves compatible local packages; members use workspace resolution. Generated products live outside the workspace and consume immutable versioned releases. Proposed private Git distribution must be proven with a clean external consumer, including transitive dependencies, authentication and lockfile reproducibility; if workspace layout prevents reliable consumption, publish standalone package artifacts to a private registry or use a documented release export. Never depend on local paths in released products. Commit application lockfiles; pin toolchains in CI. Use semantic versioning and compatibility matrices.

## 5. Logical components and dependencies

  --------------------------------------------------------------------------------------------------------------------------------;
  Module                  Responsibility                                           Allowed direct shared dependencies (proposed)
  ----------------------- -------------------------------------------------------- -----------------------------------------------;
  core                    Result, failure, clock, identifiers, logging contracts   None

  localization            Locale resources and formatting                          core

  ui                      Material 3 tokens, widgets and states                    core, localization

  auth                    Identity contracts, use cases, presentation              core, ui, localization

  profile                 Profile contracts and workflows                          core, ui, auth

  onboarding              Configurable onboarding                                  core, ui, profile

  storage                 Persistence contracts and local adapters                 core

  settings                Preferences and settings screens                         core, ui, storage, localization

  billing                 Plans, purchase contracts and UI                         core, ui

  entitlements            Access snapshots, feature checks, limits                 core

  notifications           Device and notification contracts                        core

  analytics               Consent-aware event and error contracts                  core

  export                  Export contracts and encoders                            core

  support                 Support links and feedback UI                            core, ui

  firebase                Firebase implementations of feature contracts            core and implemented feature modules

  app                     Bootstrap, shell, routing and module composition         core, ui and selected feature modules

testing                 Fakes, fixtures and contract suites                      core and tested contracts
  --------------------------------------------------------------------------------------------------------------------------------;

No production package depends on testing, showcase or a product. Feature modules never depend on Firebase adapter package or app shell. Optional integrations must be absent or explicitly disabled in generated products; the shell accepts route/module registrations instead of importing every optional SDK. Split adapters by capability if a single Firebase package forces unwanted platform dependencies. Domain/application sublibraries must not import presentation or SDK types even where packaged together.

``` mermaid
flowchart TD
  Product --> App[App composition root]
  Product --> Features[Product features]
  App --> UI[Shared UI]
  App --> Contracts[Shared feature contracts]
  App --> Adapters[Selected infrastructure adapters]
  Features --> Contracts
  Adapters --> Contracts
  UI --> Core[Pure Dart core]
  Contracts --> Core
```

Arrows denote source dependencies. Composition may be performed directly by the generated product rather than the app package; no reverse dependency from contracts to adapters is allowed.

## 6. Internal feature architecture

Phase 1 implements three Pub workspace members. `milesoft_core` is pure Dart and owns the shared contracts and validated public app configuration. `milesoft_ui` depends on Flutter and standalone `material_ui`, owns the theme and widgets, and takes caller-localised strings and callbacks. The showcase composes both entry points and supplies deterministic data, navigation and appearance selection. The dependency checker guards inward dependencies, cycles and cross-package imports. [Public contracts](../../specs/002-core-design-system/contracts/public-api.md) · [Workspace ADR](../adr/ADR-001-workspace.md)

``` text
lib/src/
  domain/          # entities, value objects, repository contracts
  application/     # use cases, orchestration, ports
  infrastructure/  # adapters, DTOs, mapping
  presentation/    # Cubits/BLoCs, screens, widgets
lib/milesoft_feature.dart # documented public exports
```

Use constructor injection; GetIt only at composition roots. Widgets dispatch intents and render state; BLoCs coordinate use cases, never perform privileged authorisation. Repositories map SDK exceptions to typed failures. Avoid generic repositories that erase domain semantics. Use Freezed/json_serializable where justified, not for trivial types. Use immutable state and explicit cancellation/disposal for subscriptions.

### 6.1 Illustrative contracts (not final API)

``` dart
abstract interface class AuthRepository {
  Stream<AuthSession?> watchSession();
  Future<Result<AuthSession>> signIn(String email, String password);
  Future<Result<void>> signOut();
}
abstract interface class EntitlementRepository {
  Stream<EntitlementSnapshot> watchCurrent();
  Future<Result<EntitlementSnapshot>> refresh();
}
abstract interface class BillingRepository {
  Future<Result<List<Offer>>> listOffers();
  Future<Result<PurchaseInitiation>> startPurchase(String offerId);
  Future<Result<void>> restorePurchases();
}
```

Types are placeholders for feature specifications. Purchase initiation is not proof of entitlement. Stream errors and loading states must be represented explicitly. Failures carry stable codes, safe messages and optional correlation IDs; provider errors stay in adapters. Define cancellation, retryability and mapping in contract tests. Monetary amounts use integer minor units plus ISO currency and currency exponent, or exact decimal representation; never binary floating point for financial calculations.

## 7. Configuration and bootstrap

Public configuration includes product ID, display name, theme, supported locales, default currency, legal/support URLs, enabled modules, route registrations and environment. Firebase client options are public identifiers, not secrets. Server secrets reside in Secret Manager. Validate mandatory configuration and capability compatibility before enabling modules. Remote flags may disable functionality but cannot grant permissions or bypass checks. Use separate entrypoints or build flavors for dev/staging/prod; validate environment identity before deployment.

Bootstrap: initialise logging and configuration; initialise selected adapters; register dependencies; restore session; verify email where product policy requires; provision or recover profile; resolve onboarding state; load entitlement snapshot; navigate to home or safe fallback. Signed-out or disabled-auth products follow explicit routes. Route guards are UX only; protected data and operations enforce access independently. On sign-out clear user-scoped state, subscriptions and sensitive caches. Deep links must be validated and resumed only after required guards pass.

## 8. Authentication, profile and account lifecycle

Firebase Auth adapter exposes provider-neutral identity. Email/password, verification, recovery and supported Google/Apple sign-in use official provider flows. Do not persist passwords or raw tokens in custom storage. Account linking requires verified ownership and explicit handling of collisions. Profile provisioning is idempotent by UID; a missing profile is recoverable after registration, not grounds for duplicate accounts. Protected profile fields are server-managed. Reauthentication is required for sensitive operations.

Deletion workflow: authenticate and reauthenticate as appropriate; create idempotent deletion request; block further protected writes; remove product data, files and device registrations according to retention policy; handle subscription cancellation guidance separately (account deletion does not automatically cancel store subscriptions); retain only legally necessary restricted records; remove identity at the appropriate final step; record completion without unnecessary personal data. Retry partial failures and expose status safely. Export and deletion must include product-defined data handlers.

## 9. Billing and entitlement architecture

``` mermaid
sequenceDiagram
  participant C as Client
  participant B as Product backend
  participant P as Payment provider
  participant F as Firestore
  C->>B: Request eligible checkout / purchase verification
  B->>P: Create checkout or verify provider transaction
  P-->>B: Verified provider response / authenticated event
  B->>F: Deduplicate and update subscription + entitlements
  F-->>C: Authorised entitlement snapshot
  C->>B: Protected operation
  B->>F: Check entitlement and atomically enforce usage
  B-->>C: Result or safe denial
```

Native store purchase flows may initiate directly through store SDKs; backend verification remains mandatory. Stripe checkout is proposed for web and only permitted mobile contexts. Confirm regional and store rules at release. Provider offer IDs map to internal plan IDs on the server; client-supplied price, UID or plan cannot establish a grant. Bind purchases to authenticated accounts using provider-supported identifiers and prevent cross-account replay. Restore purchases must verify ownership and handle conflicts explicitly.

### 9.1 Canonical commercial model

Separate provider subscription status, renewal intent, paid-through time, grace deadline and effective entitlement. Cancellation at period end is not immediate revocation. Free/trial/active/past-due/expired labels are derived from verified facts and approved policy. Refunds, chargebacks and revocations trigger recalculation. Multiple valid purchases require a documented precedence/aggregation policy; no implicit double grants. Trial eligibility, grace duration, upgrade timing and lifetime grants remain product decisions.

### 9.2 Event processing and reconciliation

1. Verify webhook signature or authenticated provider notification; reject invalid requests.
2. Persist a durable event receipt keyed by provider and event ID (or provider-defined stable deduplication key); acknowledge only after durable acceptance.
3. Retrieve authoritative provider state where needed; do not assume event arrival order represents state order.
4. In a transaction, compare revision/state, update canonical subscription and entitlement snapshot, and mark event processed. External API calls occur outside retryable database transactions.
5. Retry transient failures with bounded backoff; quarantine persistent failures for authorised review. Recover abandoned processing leases.
6. Scheduled reconciliation detects missing events and drift, re-verifies provider state and repairs grants idempotently.

No raw card data is collected. Retain only required provider references and redacted event details. Client UI observes grants but cannot write them. Usage limits are enforced atomically on the server; client-only local features cannot be made tamper-proof and require explicit product risk acceptance. Offline access uses a bounded cache policy; sensitive server operations fail closed when verification is unavailable.

## 10. Persistence and data architecture

Proposed Firestore layout per product/environment (document IDs and indexes finalised in feature specs):

  -----------------------------------------------------------------------------------------------------------------------------;
  Path                     Purpose                                            Client access
  ------------------------ -------------------------------------------------- -------------------------------------------------;
  users/{uid}              Profile, schema version, timestamps                Owner read; allowlisted fields only

  subscriptions/{id}       Provider, owner UID, plan, status, paid-through    Owner read of safe projection; server write

  entitlements/{uid}       Feature grants, limits, revision, expiry           Owner read; server write

  billingEvents/{key}      Deduplication, processing status, retry metadata   None

  plans/{id}               Public plan descriptions and internal mapping      Public safe projection only

  devices/{id}             Owner, token, platform, last seen                  Owner-scoped registration via validated service

  consents/{id}            Owner, policy version, timestamp                   Owner read; validated append

  feedback/{id}            Feedback and approved diagnostics                  Validated create; restricted read

  auditLogs/{id}           Privileged action, actor, correlation ID           None

  appConfig/{id}           Public feature configuration                       Read-only public allowlist

deletionRequests/{uid}   Workflow state and retry metadata                  Owner safe status; server write
  -----------------------------------------------------------------------------------------------------------------------------;

Product collections define ownership and indexes explicitly. Firestore rules are not filters: queries must satisfy rules. Use deny-by-default rules, field allowlists, ownership immutability and emulator tests for cross-user access. Separate private provider metadata from client-readable projections. Use server timestamps, UTC, explicit schema versions and bounded queries. Migrations should be additive where possible, idempotent, resumable and tested on representative nonproduction data. Document backup/restore and retention. Local preferences use SharedPreferences; secure storage only for appropriate secrets; Drift optional. Define offline conflict handling per domain, not a universal last-write-wins policy.

## 11. Backend component design

``` text
backend/firebase/
  functions/src/
    index.ts
    composition/
    auth/
    profiles/
    billing/{domain,application,adapters,handlers}/
    entitlements/
    accounts/
    notifications/
    shared/{validation,errors,logging,idempotency}/
  functions/test/
  firestore.rules
  firestore.indexes.json
  storage.rules
  firebase.json
```

Use TypeScript strict mode, second-generation Functions, proposed Node 22, us-central1, 60s timeout, 256 MiB, min 0/max 10; verify supported runtime and region before deployment. Configure per function, not globally where workloads differ. Keep handler validation and auth separate from business services. Use least-privilege service accounts, secret bindings, structured logs and correlation IDs. Callable endpoints use standard Firebase error codes; HTTP endpoints use appropriate status codes and safe error envelopes. Never expose stack traces. Proposed operations: `ensureProfile`, `createCheckout`, `verifyPurchase`, `restorePurchases`, `requestAccountDeletion`, `registerDevice`, `submitFeedback`, provider webhook handlers and scheduled reconciliation. Exact payloads, auth requirements and idempotency contracts belong in feature specs. Product-specific protected operations invoke entitlement checks in the same transaction as quota consumption when possible.

## 12. Shared service design

  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;
  Service                             Architecture
  -----------------------------------; ------------------------------------------------------------------------------------------------------------------------------------------------
  UI                                  Material 3 tokens, product theme overrides, adaptive shell, semantic widgets, component catalogue

  Localisation                        ARB resources, generated translations, locale-aware formatting, English baseline; product translations separate

  Settings                            Device preferences local; selected account preferences synchronised with explicit conflict policy

  Onboarding                          Configurable ordered steps, versioned completion, consent records separate from tutorial progress

  Notifications                       Provider-neutral service; FCM adapter, permission gating, token rotation, logout cleanup, validated deep links

  Analytics                           Typed events, consent gating, no PII, no-op adapter where disabled; server-confirmed revenue events deduplicated

  Export                              Product supplies authorised records; CSV/JSON encoders, optional PDF/XLSX; protect against CSV formula injection; platform save/share adapters

  Support                             Configurable legal/help links and validated feedback; diagnostic attachment only with user approval

Monitoring                          Structured logging, crash adapters per platform, redaction and correlation IDs
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;

Unsupported capabilities must be explicitly disabled or use a documented alternative, not silently fail. Verify platform SDK support in a capability matrix. Accessibility targets WCAG 2.2 AA where applicable, with keyboard, semantics, contrast and scalable text tests.

## 13. Application generator and showcase

Mason templates plus Dart CLI wrapper generate a standalone application with selected modules, routes, branding placeholders, environment templates, backend configuration, tests and CI. Validate names, platform/module compatibility and destination paths; refuse overwriting existing files without explicit approval. Never generate production secrets or deploy automatically. Template versions must align with SDK versions. Generated applications own their business logic and deployment configuration; shared upgrades occur through dependencies, not regeneration over modified files. Template migrations are documented separately.

Showcase demonstrates each implemented capability with fakes/emulators and sandbox billing. Include an example feature with a protected quota to exercise server enforcement. Test both minimal and commercial generated applications outside the monorepo. No production data or live charges.

## 14. Deployment and operations

``` mermaid
flowchart LR
  PR[Pull request] --> CI[Format / analyse / test / scan / build]
  CI --> R[Versioned release]
  R --> DEV[Product development]
  R --> STG[Product staging]
  STG --> G[Explicit production approval]
  G --> PROD[Product production]
```

Separate Firebase projects and credentials per product and environment, pending ADR approval. Dev uses emulators and sandbox providers; staging validates integrations; production uses live services. CI checks Dart formatting, analysis, package tests, widget tests, backend lint/typecheck/tests, rules tests, generator smoke tests and supported platform builds. Use protected branches, immutable release tags, scoped credentials and workload identity where supported. iOS builds require appropriate macOS/signing infrastructure. Production deployments require approval and traceability. Deploy backward-compatible rules/functions before dependent clients; mobile rollback may require forward fixes because installed versions persist. Define recovery procedures, backup verification and incident ownership per product.

Monitor errors, latency, failed billing events, reconciliation drift, quota denials and cloud spend. Budget alerts are not hard spending caps. Bound queries, retries, concurrency and scaling; monitor actual cost per active customer. Availability target 99.9% monthly is a measurement goal, not a vendor guarantee. Define reference devices/network and measure startup target 3s and local interaction target 200ms before claiming compliance.

## 15. Security and privacy verification

  --------------------------------------------------------------------------------------------------------------------;
  Threat                               Control and verification
  ------------------------------------ -------------------------------------------------------------------------------;
  Cross-user data access               Ownership checks, rules tests, backend negative tests

  Forged payment or replay             Signature/API verification, account binding, duplicate and out-of-order tests

  Client entitlement tampering         Server-only writes and protected operation tests

  Concurrent quota bypass              Transactional quota enforcement and concurrency tests

  Secret exposure                      Secret Manager, scoped CI identity, secret scanning

  Account takeover                     Provider auth, reauthentication, abuse controls

  Sensitive telemetry                  Redaction, consent tests and event schema review

  Data leakage after logout/deletion   Cache clearing, lifecycle and retention tests

Supply chain compromise              Locked dependencies, review, vulnerability/licence scanning
  --------------------------------------------------------------------------------------------------------------------;

Privacy policies, retention periods, data residency and lawful processing are product-specific decisions. Support portability and deletion without assuming all records may legally be erased. No unresolved critical security defects at production release.

## 16. Testing and architecture fitness functions

Test-first for business behaviour; regression tests for defects. Pure Dart unit tests for domain logic; BLoC/widget tests for UI; adapter contract suites; emulator integration and security rules tests; sandbox billing verification; end-to-end journeys; generator smoke tests; accessibility and performance checks. Target at least 80% shared business logic coverage and all mandatory acceptance scenarios. CI checks forbidden imports, dependency cycles, public API compatibility and external consumer builds. Record actual test results, not assumed success. Use injected clocks and IDs, deterministic fixtures and no live payments.

## 17. Implementation slices and traceability

  --------------------------------------------------------------------------------------------------------------------------------;
  Slice                   SRS requirement families   Exit evidence
  ----------------------- -------------------------- -----------------------------------------------------------------------------;
  0 Foundation            ARC, DEV, SHW              Workspace, showcase build, CI, dependency checks

  1 Core/UI               CFG, COR, UI, LOC          Config validation, component catalogue, pure Dart tests

  2 Identity              AUT, PRF, BCK              Emulator registration, profile recovery, cross-user denial

  3 Shell                 APP, ONB, SET              Guarded routes, persisted preferences, optional modules

  4 Commercial            BIL, ENT, BCK              Verified sandbox purchase, duplicate/out-of-order events, quota enforcement

  5 Shared services       STO, NOT, ANA, EXP, SUP    Adapter contracts, consent, export, platform fallback

  6 Generator             GEN, DEV                   Minimal and commercial standalone generated builds

7 Release               NFR, AC, SHW               Security review, acceptance evidence, documentation and recovery plan
  --------------------------------------------------------------------------------------------------------------------------------;

Every feature specification must map individual SRS IDs to tests and tasks. The table is family-level traceability, not a substitute for a complete requirement-to-test matrix. Deliver Android/web first; iOS-specific commercial requirements remain mandatory before iOS release. Eight weeks is an indicative schedule only; acceptance evidence determines readiness.

## 18. Architecture decision register

All entries remain proposed unless ratified by the owner. Preserve the SRS identifiers.

  ----------------------------------------------------------------------------------------------------------------------------------;
  ADR                     Decision                  Proposed default / validation needed
  ----------------------- ------------------------- --------------------------------------------------------------------------------;
  001                     Repository                Private monorepo; verify workspace tooling

  002                     Distribution              Immutable private Git dependencies; prove external consumer or choose registry

  003                     Backend isolation         Product/environment Firebase projects; cost and residency review

  004                     Identity                  Independent accounts per product

  005                     Multi-tenancy             Deferred optional extension

  006                     Mobile billing            Native platform billing; verify current rules

  007                     Web billing               Stripe; verify merchant eligibility and settlement

  008                     Offline database          Drift only where required; define conflict policies

  009                     Generator                 Mason plus Dart CLI

  010                     Subscription management   Direct adapters and backend verification; evaluate operational burden

  011                     Admin portal              Deferred; secure operational tooling still required

  012                     Reference product         Owner selection pending

  013                     Licensing                 Proprietary internal; review third-party licences

  014                     Email                     Provider selection pending

  015                     Platforms                 Android/web first; iOS next; Windows conditional

  ----------------------------------------------------------------------------------------------------------------------------------;

Additional decisions required before dependent implementation: canonical billing state precedence and trial policy; retention/deletion and residency; SDK version matrix; package extraction thresholds; observability provider and budget; accessibility reference devices; release credential ownership. Record context, alternatives, decision, consequences, status and approval in individual ADR files.

## 19. Architecture acceptance and limitations

Architecture is accepted when a minimal and a commercial generated product build independently, optional modules can be removed, domain code has no SDK dependency, protected operations reject unauthorised clients, billing replay cannot duplicate grants, product deployments are isolated, and upgrades are reproducible. Full SRS acceptance remains mandatory for release.

This is a design document, not implemented code. No SDK compatibility, build, payment integration, performance or security testing has been executed. Provider policies, runtime availability and package distribution must be verified during implementation. Interfaces, schemas and endpoints are proposed and require feature-level contracts. The SRS and constitution remain drafts; ratify them and resolve relevant ADRs before starting dependent work.

## 20. References and next step

- MileSoft Starter Kit SRS v0.1.0 (`docs/requirements/SRS.md`).
- MileSoft Starter Kit Constitution v0.1.0 (`.specify/memory/constitution.md`).
- Next: approve baseline decisions, initialise repository and Spec Kit, then specify Phase 0 foundation with acceptance tests, technical plan and ordered implementation tasks.
