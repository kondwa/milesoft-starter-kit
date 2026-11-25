# MileSoft Starter Kit — Software Requirements Specification

| Property | Value |
| --- | --- |
| Version | 0.1.0 |
| Status | Draft for review |
| Date | 25 November 2026 |
| Organisation | MileSoft |
| Repository | `milesoft-starter-kit` |
| Methodology | Specification-Driven Development |
| Classification | Internal |

## 1. Introduction

### 1.1 Purpose

Define the functional, non-functional, architectural, security and operational requirements for a reusable foundation for developing, deploying, maintaining and commercialising MileSoft applications.

### 1.2 Background and objectives

Reduce repeated implementation, maintenance costs and time to market; standardise architecture, branding and engineering practices; maximise reuse; simplify authentication and commercialisation; support global and local markets, independent product deployments and AI-assisted development.

### 1.3 Guiding principles

SIMPEL: Simplicity (avoid unnecessary complexity), Impact (measurable value), Meaningful (genuine needs), Practical (proven technologies), Evolving (incremental extensibility), Lean (minimise waste and cost).

### 1.4 Audience

Developers, architects, product managers, designers, QA, DevOps and AI-assisted development agents.

## 2. Scope

Deliverables: shared Dart/Flutter SDK, configurable application template, Firebase backend template, developer CLI and showcase reference application.

Supported categories: consumer, micro-SaaS, business productivity, financial management, educational and professional utility applications. Multi-tenancy and AI are optional extensions; games may reuse shared services.

Excluded: product-specific business logic, centralised cross-product customer database, proprietary payment network, ERP, mandatory AI and custom hosting platform.

## 3. Architecture

Clean Architecture: presentation and infrastructure depend on application/domain abstractions; product composition roots wire adapters. Product-specific functionality remains separate.

| ID | Requirement |
| --- | --- |
| ARC-001 | Adopt Clean Architecture. |
| ARC-002 | Independently version shared packages. |
| ARC-003 | Separate product-specific logic. |
| ARC-004 | Access external services through replaceable adapters. |
| ARC-005 | Use dependency injection. |
| ARC-006 | Shared packages shall not depend on products. |
| ARC-007 | Prohibit circular dependencies. |
| ARC-008 | Domain logic shall not depend directly on Firebase, Flutter UI or payment SDKs. |
| ARC-009 | Optional modules shall be independently configurable. |
| ARC-010 | Products shall deploy and release independently. |
| ARC-011 | Pin compatible shared package versions. |
| ARC-012 | Support mocks and fakes for automated tests. |

### 3.1 Technology stack

Flutter/Dart; BLoC/Cubit; GetIt; GoRouter; Freezed and json_serializable; Firebase Auth, Firestore, Cloud Functions (TypeScript), FCM, Analytics, Crashlytics and Remote Config; SharedPreferences, Flutter Secure Storage and optional Drift; Stripe for web, Google Play Billing and Apple StoreKit for mobile; Mason; Dart Pub Workspaces; GitHub Actions; GitHub Spec Kit and Codex. Unsupported platform services shall be conditionally disabled or replaced.

## 4. Functional requirements

Priority: **M** = Must (initial production release); **S** = Should (may be deferred); **C** = Could (optional subsequent release). Each entry is a requirement of the system.

### 4.1 Application configuration

Module: `milesoft_core`

| ID | Requirement | Priority |
| --- | --- | --- |
| CFG-001 | Configurable application names and identifiers | M |
| CFG-002 | Product logos, colours and branding | M |
| CFG-003 | Development, staging and production environments | M |
| CFG-004 | Enable or disable optional modules | M |
| CFG-005 | Default language, currency and region | M |
| CFG-006 | Legal and support URLs | M |
| CFG-007 | Validate mandatory configuration at startup | M |
| CFG-008 | Remote feature flags | S |
| CFG-009 | Minimum version enforcement | S |
| CFG-010 | Maintenance mode | S |

### 4.2 Shared application core

Module: `milesoft_core`

| ID | Requirement | Priority |
| --- | --- | --- |
| COR-001 | Standard result and failure types | M |
| COR-002 | Exception handling | M |
| COR-003 | Input validation abstractions | M |
| COR-004 | Pagination and filtering | M |
| COR-005 | Date, time and identifier utilities | M |
| COR-006 | Structured logging | M |
| COR-007 | Connectivity monitoring | S |
| COR-008 | Configurable transient failure retries | S |
| COR-009 | Injectable clock and identifier generation | M |

### 4.3 Design system

Module: `milesoft_ui`

| ID | Requirement | Priority |
| --- | --- | --- |
| UI-001 | Material Design 3 themes | M |
| UI-002 | Light, dark and system modes | M |
| UI-003 | Colour and typography tokens | M |
| UI-004 | Spacing, elevation and radius tokens | M |
| UI-005 | Reusable forms and validation messages | M |
| UI-006 | Buttons, cards, dialogs and notifications | M |
| UI-007 | Loading, empty, success and error states | M |
| UI-008 | Responsive adaptive layouts | M |
| UI-009 | Accessible navigation | M |
| UI-010 | Powered by MileSoft component | S |
| UI-011 | Showcase component catalogue | M |
| UI-012 | Dashboard and reporting components | S |

### 4.4 Authentication

Module: `milesoft_auth`

| ID | Requirement | Priority |
| --- | --- | --- |
| AUT-001 | Email/password registration | M |
| AUT-002 | Email/password login | M |
| AUT-003 | Email verification | M |
| AUT-004 | Password recovery | M |
| AUT-005 | Secure session persistence | M |
| AUT-006 | Sign-out | M |
| AUT-007 | Google authentication on applicable platforms | M |
| AUT-008 | Sign in with Apple where required | M |
| AUT-009 | Authentication state monitoring | M |
| AUT-010 | Protected routes | M |
| AUT-011 | Account deletion and data lifecycle | M |
| AUT-012 | Reauthentication for sensitive operations | M |
| AUT-013 | Account linking | S |
| AUT-014 | Multi-factor authentication | C |
| AUT-015 | Alternative identity adapters | C |

### 4.5 User profiles

Module: `milesoft_profile`

| ID | Requirement | Priority |
| --- | --- | --- |
| PRF-001 | Provision profile after registration | M |
| PRF-002 | Edit profile | M |
| PRF-003 | Profile pictures | S |
| PRF-004 | Creation and modification timestamps | M |
| PRF-005 | User preferences | M |
| PRF-006 | Product-specific extensions | S |
| PRF-007 | Protect privileged profile attributes | M |

### 4.6 Onboarding

Module: `milesoft_onboarding`

| ID | Requirement | Priority |
| --- | --- | --- |
| ONB-001 | Configurable welcome screens | M |
| ONB-002 | Product feature introduction | M |
| ONB-003 | Initial configuration | M |
| ONB-004 | Persist completion | M |
| ONB-005 | Optional steps | M |
| ONB-006 | Terms acceptance and applicable privacy notices | M |
| ONB-007 | Completion events | S |
| ONB-008 | Contextual tutorials | C |

### 4.7 Application shell

Module: `milesoft_app`

| ID | Requirement | Priority |
| --- | --- | --- |
| APP-001 | Standard initialisation | M |
| APP-002 | Dependency composition | M |
| APP-003 | Configurable routing | M |
| APP-004 | Authentication route guards | M |
| APP-005 | Entitlement route guards | M |
| APP-006 | Product navigation destinations | M |
| APP-007 | Bottom navigation, rails and drawers | M |
| APP-008 | Deep links | S |
| APP-009 | Account, settings and subscription screens | M |
| APP-010 | Initialisation failure recovery | M |

Lifecycle: launch → initialise → authenticate if required → onboard if required → load entitlements → home. Disabled modules are bypassed.

### 4.8 Billing

Module: `milesoft_billing`

| ID | Requirement | Priority |
| --- | --- | --- |
| BIL-001 | Provider-independent contracts | M |
| BIL-002 | Free and paid plans | M |
| BIL-003 | Monthly and annual subscriptions | M |
| BIL-004 | Configurable trials | M |
| BIL-005 | Stripe on eligible platforms | M |
| BIL-006 | Google Play Billing | M |
| BIL-007 | Apple StoreKit for iOS commercial releases | M |
| BIL-008 | Upgrades and downgrades | M |
| BIL-009 | Cancellation | M |
| BIL-010 | Renewal monitoring | M |
| BIL-011 | Expiry handling | M |
| BIL-012 | Grace periods | S |
| BIL-013 | Lifetime purchases | S |
| BIL-014 | Restore eligible purchases | M |
| BIL-015 | Provider regional prices and currencies | M |
| BIL-016 | Backend verification | M |
| BIL-017 | Idempotent event processing | M |
| BIL-018 | Provider-appropriate management interfaces | M |
| BIL-019 | Additional provider adapters | S |
| BIL-020 | Refunds, revocations and payment failures | M |

Lifecycle: free/trial/active/past due/grace period/expired/cancelled. Cancellation may retain access until the paid period ends. Provider events and product policy determine transitions.

### 4.9 Entitlements

Module: `milesoft_entitlements`

| ID | Requirement | Priority |
| --- | --- | --- |
| ENT-001 | Named feature entitlements | M |
| ENT-002 | Plan-to-entitlement mappings | M |
| ENT-003 | Feature access checks | M |
| ENT-004 | Numeric usage limits | M |
| ENT-005 | Expiration dates | M |
| ENT-006 | Trusted backend records | M |
| ENT-007 | Change notifications | M |
| ENT-008 | Upgrade prompts | M |
| ENT-009 | Promotional grants | S |
| ENT-010 | Administrative grants | S |
| ENT-011 | Backend enforcement of access and usage limits | M |
| ENT-012 | Offline caching policies | S |

Subscriptions describe commercial arrangements; entitlements determine access. Example: free plan allows three projects and no PDF export; pro allows unlimited projects and PDF export. Null limits represent unlimited usage. Product definitions remain outside shared packages.

### 4.10 Settings

Module: `milesoft_settings`

| ID | Requirement | Priority |
| --- | --- | --- |
| SET-001 | Appearance | M |
| SET-002 | Language | M |
| SET-003 | Currency and region | M |
| SET-004 | Notification preferences | M |
| SET-005 | Local device preferences | M |
| SET-006 | Cloud synchronisation of selected preferences | S |
| SET-007 | Product extensions | M |
| SET-008 | Legal and privacy settings | M |
| SET-009 | Version and build information | M |
| SET-010 | Reset defaults | S |

### 4.11 Persistence

Module: `milesoft_storage`

| ID | Requirement | Priority |
| --- | --- | --- |
| STO-001 | Repository abstractions | M |
| STO-002 | Firestore | M |
| STO-003 | Local key-value storage | M |
| STO-004 | Secure storage | M |
| STO-005 | Structured local database | S |
| STO-006 | Offline access | S |
| STO-007 | Synchronisation strategies | S |
| STO-008 | Schema versioning and migration | M |
| STO-009 | Pagination | M |
| STO-010 | Prevent cross-user access | M |
| STO-011 | File storage adapters | S |

### 4.12 Notifications

Module: `milesoft_notifications`

| ID | Requirement | Priority |
| --- | --- | --- |
| NOT-001 | Push notifications where applicable | M |
| NOT-002 | Local notifications | S |
| NOT-003 | Permission management | M |
| NOT-004 | Preferences | M |
| NOT-005 | Device registration and token refresh | M |
| NOT-006 | Product categories | M |
| NOT-007 | Notification navigation | S |
| NOT-008 | Scheduled reminders | S |
| NOT-009 | In-app history | C |
| NOT-010 | Transactional email adapter | S |

### 4.13 Analytics

Module: `milesoft_analytics`

| ID | Requirement | Priority |
| --- | --- | --- |
| ANA-001 | Provider-independent contracts | M |
| ANA-002 | Usage tracking | M |
| ANA-003 | Commercial conversion events | M |
| ANA-004 | Product events | M |
| ANA-005 | Crash reporting | M |
| ANA-006 | Non-fatal errors | M |
| ANA-007 | Consent and opt-out | M |
| ANA-008 | Exclude sensitive personal data | M |
| ANA-009 | Performance monitoring | S |
| ANA-010 | Multiple providers | C |

Standard events: `onboarding_started`, `onboarding_completed`, `sign_up`, `login`, `paywall_viewed`, `checkout_started`, `purchase`, `trial_started`, `subscription_renewed`, `subscription_cancelled`, `feature_used`, `export_completed`, `account_deleted`. Revenue events must be deduplicated and reconciled with verified transactions.

### 4.14 Localisation

Module: `milesoft_localization`

| ID | Requirement | Priority |
| --- | --- | --- |
| LOC-001 | Multiple languages | M |
| LOC-002 | Locale-aware dates and times | M |
| LOC-003 | Locale-aware numbers | M |
| LOC-004 | Multiple currencies | M |
| LOC-005 | Externalised user-facing text | M |
| LOC-006 | Device locale detection | M |
| LOC-007 | Manual language selection | M |
| LOC-008 | Right-to-left layouts | S |
| LOC-009 | Product translations | M |
| LOC-010 | UTC timestamps and local conversion | M |

English is the initial default language.

### 4.15 Export

Module: `milesoft_export`

| ID | Requirement | Priority |
| --- | --- | --- |
| EXP-001 | CSV | M |
| EXP-002 | JSON | M |
| EXP-003 | PDF | S |
| EXP-004 | Excel-compatible spreadsheets | S |
| EXP-005 | Document branding | S |
| EXP-006 | Platform file saving and sharing | M |
| EXP-007 | Data portability | M |
| EXP-008 | Product templates | S |

### 4.16 Support

Module: `milesoft_support`

| ID | Requirement | Priority |
| --- | --- | --- |
| SUP-001 | Configurable support contacts | M |
| SUP-002 | Documentation access | M |
| SUP-003 | Feedback submission | S |
| SUP-004 | User-approved diagnostics | S |
| SUP-005 | Platform-compliant review prompts | S |
| SUP-006 | FAQ | C |

## 5. Backend requirements

Each product and environment shall have independently deployable Firebase infrastructure. Authentication and App Check protect applicable services; Cloud Functions perform trusted operations; Firestore and Cloud Storage enforce access rules; payment providers supply verified events.

| ID | Requirement | Priority |
| --- | --- | --- |
| BCK-001 | Reusable Functions templates | M |
| BCK-002 | Authenticated callable functions | M |
| BCK-003 | HTTP integration endpoints | M |
| BCK-004 | Scheduled background operations | S |
| BCK-005 | Verified payment webhooks | M |
| BCK-006 | Subscription reconciliation | M |
| BCK-007 | Profile provisioning | M |
| BCK-008 | Account deletion workflows | M |
| BCK-009 | Structured errors | M |
| BCK-010 | Idempotent event processing | M |
| BCK-011 | Server-side validation | M |
| BCK-012 | Secret management | M |
| BCK-013 | Firebase Emulator Suite | M |
| BCK-014 | Configurable scaling and resource limits | M |
| BCK-015 | Auditable administration | M |
| BCK-016 | Background retry and recovery | S |

Defaults: second-generation Functions, TypeScript, Node.js 22 (subject to support), `us-central1`, 60-second timeout, 256 MiB memory, zero minimum and ten maximum instances, configurable per function; Google Cloud Secret Manager and Emulator Suite.

Standard collections: `users`, `subscriptions`, `entitlements`, `billingEvents`, `plans`, `devices`, `consents`, `feedback`, `auditLogs`, `appConfig`, `deletionRequests`. Users may have multiple subscriptions and entitlements; subscriptions reference plans and billing events. Product collections remain product-specific.

## 6. Application generation

Module: `milesoft_cli`.

| ID | Requirement | Priority |
| --- | --- | --- |
| GEN-001 | Generate Flutter application | M |
| GEN-002 | Configurable names and identifiers | M |
| GEN-003 | Selectable platforms | M |
| GEN-004 | Optional modules | M |
| GEN-005 | Clean Architecture directories | M |
| GEN-006 | Compatible dependencies | M |
| GEN-007 | Environment templates | M |
| GEN-008 | Firebase backend templates | M |
| GEN-009 | Testing infrastructure | M |
| GEN-010 | GitHub Actions workflows | M |
| GEN-011 | Documentation | M |
| GEN-012 | Placeholder legal and support configuration | M |
| GEN-013 | Validate development tools | S |
| GEN-014 | Generate product feature modules | S |
| GEN-015 | Dependency upgrade assistance | S |

Proposed commands (not implemented):

```bash
milesoft create thesisflow
milesoft create thesisflow --platforms android,ios,web --modules auth,billing,analytics
milesoft generate feature research_projects
milesoft doctor
milesoft dependencies check
milesoft config validate
```

Generated products contain `lib/app/{configuration,dependency_injection,routing}`, `lib/features/<feature>/{domain,application,infrastructure,presentation}`, `lib/l10n`, environment-specific entry points, assets, tests, integration tests, Firebase configuration, docs, CI and README.

## 7. Showcase application

All requirements below are Must.

| ID | Requirement |
| --- | --- |
| SHW-001 | Demonstrate all implemented modules |
| SHW-002 | UI component catalogue |
| SHW-003 | Authentication workflows |
| SHW-004 | Billing and entitlement workflows |
| SHW-005 | Simulated payments |
| SHW-006 | Loading, error and empty states |
| SHW-007 | Responsive layouts |
| SHW-008 | Integration and regression tests |
| SHW-009 | Localisation and theme switching |
| SHW-010 | Example product-specific functionality |

Use sandbox payments and development data only.

## 8. Non-functional requirements

### 8.1 Performance

| ID | Requirement |
| --- | --- |
| NFR-PER-001 | Responsive initial interface within 3 seconds under defined reference conditions |
| NFR-PER-002 | Local UI interactions should respond within 200 ms |
| NFR-PER-003 | Bounded queries or pagination |
| NFR-PER-004 | Non-blocking long operations |
| NFR-PER-005 | Progress and timeout handling |

### 8.2 Security

| ID | Requirement |
| --- | --- |
| NFR-SEC-001 | Secure transport |
| NFR-SEC-002 | No embedded or committed secrets |
| NFR-SEC-003 | Tested Firestore and Storage rules |
| NFR-SEC-004 | Backend authentication and authorisation |
| NFR-SEC-005 | Verify webhook authenticity |
| NFR-SEC-006 | Prevent untrusted writes to subscription and entitlement records |
| NFR-SEC-007 | Exclude sensitive data from logs |
| NFR-SEC-008 | Audit privileged operations |
| NFR-SEC-009 | Monitor dependency vulnerabilities |
| NFR-SEC-010 | Public endpoint abuse prevention |
| NFR-SEC-011 | App Check where applicable |
| NFR-SEC-012 | Isolate security configuration by environment |

### 8.3 Privacy

| ID | Requirement |
| --- | --- |
| NFR-PRI-001 | Configurable privacy policies and terms |
| NFR-PRI-002 | Data minimisation |
| NFR-PRI-003 | Account deletion and applicable erasure |
| NFR-PRI-004 | Data portability |
| NFR-PRI-005 | Consent-aware tracking |
| NFR-PRI-006 | Configurable retention |
| NFR-PRI-007 | Distribution platform compliance |
| NFR-PRI-008 | Jurisdiction-specific compliance |

### 8.4 Reliability

| ID | Requirement |
| --- | --- |
| NFR-REL-001 | Recoverable failures shall not terminate the app |
| NFR-REL-002 | Safe retry or recovery |
| NFR-REL-003 | No duplicate commercial effects from duplicate events |
| NFR-REL-004 | Recover interrupted provisioning |
| NFR-REL-005 | Backup and restoration procedures |
| NFR-REL-006 | Meaningful user errors |
| NFR-REL-007 | Target 99.9% monthly backend availability subject to infrastructure and product requirements |

### 8.5 Maintainability

| ID | Requirement |
| --- | --- |
| NFR-MNT-001 | Semantic Versioning |
| NFR-MNT-002 | Document public APIs |
| NFR-MNT-003 | Migration guidance for breaking changes |
| NFR-MNT-004 | Explicit dependencies |
| NFR-MNT-005 | Standard linting |
| NFR-MNT-006 | Target 80% shared business logic coverage |
| NFR-MNT-007 | Architecture Decision Records |

### 8.6 Accessibility

| ID | Requirement |
| --- | --- |
| NFR-ACC-001 | Target WCAG 2.2 AA where applicable |
| NFR-ACC-002 | Semantic labels |
| NFR-ACC-003 | Scalable text |
| NFR-ACC-004 | Do not rely on colour alone |
| NFR-ACC-005 | Keyboard navigation on web and desktop |
| NFR-ACC-006 | Adequate contrast and touch targets |

### 8.7 Cost efficiency

| ID | Requirement |
| --- | --- |
| NFR-CST-001 | Minimise unnecessary cloud operations |
| NFR-CST-002 | Configurable scaling limits |
| NFR-CST-003 | Expenditure monitoring |
| NFR-CST-004 | Optional expensive external services |
| NFR-CST-005 | Cache frequently accessed configuration where appropriate |
| NFR-CST-006 | No mandatory paid AI services |

The kit facilitates compliance, including GDPR where relevant, but does not guarantee legal compliance of individual products.

## 9. Platform compatibility

Android and web are the first implementation milestone; iOS commercial readiness follows. Windows is planned. All three primary platforms require shell, authentication, Firestore, export, analytics and responsive layouts. Stripe is required for web and policy-dependent on mobile; native store billing is required for the corresponding commercial mobile releases. Push notifications are required on mobile and conditional on web. Local notifications are supported where available. Crash reporting uses native SDKs or alternative adapters on web and desktop. SDK compatibility shall be verified during implementation.

## 10. Development and deployment

Development, staging and production shall isolate credentials, databases, payment settings and permissions. Development uses emulators and sandbox payments; staging validates releases; production serves live customers.

| ID | Requirement |
| --- | --- |
| DEV-001 | PRs trigger analysis |
| DEV-002 | PRs trigger tests |
| DEV-003 | Validate packages against showcase |
| DEV-004 | Failed mandatory checks prevent merging |
| DEV-005 | Version-tagged releases |
| DEV-006 | Explicit production deployment approval |
| DEV-007 | Secure build and deployment credentials |
| DEV-008 | Artifacts traceable to commits |
| DEV-009 | Version-controlled database and backend configuration |
| DEV-010 | Documented recovery or rollback strategy |

### Repository structure

```text
milesoft-starter-kit/
├── apps/showcase/
├── packages/
│   ├── milesoft_core/
│   ├── milesoft_app/
│   ├── milesoft_ui/
│   ├── milesoft_auth/
│   ├── milesoft_profile/
│   ├── milesoft_onboarding/
│   ├── milesoft_billing/
│   ├── milesoft_entitlements/
│   ├── milesoft_settings/
│   ├── milesoft_storage/
│   ├── milesoft_notifications/
│   ├── milesoft_analytics/
│   ├── milesoft_localization/
│   ├── milesoft_export/
│   ├── milesoft_support/
│   ├── milesoft_firebase/
│   └── milesoft_testing/
├── templates/flutter_saas/
├── backend/firebase/
├── tools/milesoft_cli/
├── docs/{architecture,adr,development,deployment}/
├── specs/
├── .specify/
├── .github/workflows/
├── analysis_options.yaml
├── pubspec.yaml
├── CHANGELOG.md
└── README.md
```

These are logical module boundaries; related modules may initially be combined.

## 11. Testing

Required categories: unit, widget, BLoC, contract, integration, security rules and authorisation, backend, end-to-end, regression, accessibility, performance and generation testing. All mandatory acceptance scenarios must pass before production release.

## 12. Acceptance criteria

| ID | Scenario | Expected result |
| --- | --- | --- |
| AC-001 | Generate application | Compiles and launches |
| AC-002 | Register | Account and profile provisioned |
| AC-003 | Authenticate | Protected routes accessible |
| AC-004 | Onboard | Completion persisted |
| AC-005 | Change theme | Persists after restart |
| AC-006 | Change language | Supported text updates |
| AC-007 | Purchase | Backend verifies and grants entitlements |
| AC-008 | Duplicate payment event | No duplicate commercial effect |
| AC-009 | Expiry | Access adjusted according to policy |
| AC-010 | Restricted feature | Unauthorised access denied with message |
| AC-011 | Export | Valid file generated |
| AC-012 | Delete account | Configured deletion and retention workflow completes |
| AC-013 | Cross-user access | Denied |
| AC-014 | Disable module | Application remains functional |
| AC-015 | Network failure | Recoverable error handling |
| AC-016 | Upgrade package | Compatible functionality continues |
| AC-017 | Generate independent product | Deploys without modifying kit source |
| AC-018 | CI pipeline | Mandatory analysis, tests and builds pass |

## 13. Implementation roadmap

| Phase | Indicative week | Deliverables |
| --- | --- | --- |
| 0 Foundation | 1 | Constitution, repository, workspace, CI, showcase |
| 1 Core and UI | 1–2 | Contracts, configuration, themes and components |
| 2 Authentication | 2–3 | Identity and profiles |
| 3 App shell | 3–4 | Routing, onboarding, settings, localisation |
| 4 Commercial infrastructure | 4–5 | Billing, verification, entitlements |
| 5 Shared services | 5–6 | Storage, notifications, analytics, export, support |
| 6 Tooling | 7 | Templates and CLI |
| 7 Production readiness | 8 | Security, testing, documentation and release |

Completion depends on acceptance criteria, not elapsed time.

## 14. Release strategy

| Version | Scope |
| --- | --- |
| 0.1.0 | Foundation and core |
| 0.2.0 | Design system and configuration |
| 0.3.0 | Authentication and profiles |
| 0.4.0 | Shell and onboarding |
| 0.5.0 | Billing and entitlements |
| 0.6.0 | Shared services |
| 0.7.0 | CLI |
| 0.9.0 | Release candidate |
| 1.0.0 | Production-ready kit |

## 15. Risks and mitigation

| Risk | Mitigation |
| --- | --- |
| Overengineering | Incremental implementation against real requirements |
| Package fragmentation | Extract only justified packages |
| Vendor lock-in | Contracts and adapters |
| Cloud costs | Monitoring, caching and scaling controls |
| Payment restrictions | Platform-compliant billing |
| Breaking changes | Versioning, compatibility tests and migration guidance |
| Security vulnerabilities | Security testing and dependency reviews |
| Delayed products | Validate against a real product early |
| Inconsistent AI code | Constitution, specifications and quality gates |
| Unauthorised data access | Database isolation and backend authorisation |

## 16. Success indicators

Targets: new application setup within 10 minutes after prerequisites; at least 60% reuse of common functionality in simple SaaS apps; at least 80% shared business logic coverage; small validated product MVP in 2–4 weeks; 100% mandatory acceptance tests passing; zero unresolved critical security defects. Refine after the first reference product.

## 17. Outstanding architectural decisions

| ID | Decision | Proposed default |
| --- | --- | --- |
| ADR-001 | Repository | Private GitHub monorepo |
| ADR-002 | Distribution | Version-tagged private Git dependencies |
| ADR-003 | Backend isolation | Independent Firebase projects per product and environment |
| ADR-004 | Identity | Independent product accounts |
| ADR-005 | Multi-tenancy | Optional extension |
| ADR-006 | Mobile billing | Native platform billing |
| ADR-007 | Web billing | Stripe |
| ADR-008 | Offline database | Drift where required |
| ADR-009 | Generator | Mason with Dart CLI wrapper |
| ADR-010 | Subscription management | Direct adapters and backend verification |
| ADR-011 | Admin portal | Deferred |
| ADR-012 | Reference commercial product | To be selected |
| ADR-013 | Licensing | Proprietary internal MileSoft licence |
| ADR-014 | Email provider | To be selected |
| ADR-015 | Platforms | Android and web, then iOS |

## 18. Definition of done

Approved requirements implemented; public interfaces documented; automated tests passing; security requirements satisfied; showcase demonstration available; integration instructions, dependencies and configuration documented; acceptance criteria satisfied.

## 19. Deliverables

SRS; project constitution; architecture documentation and ADRs; shared SDK; backend starter kit; design system; showcase; application templates; developer CLI; automated tests; developer and deployment documentation.

## 20. Conclusion and next steps

The starter kit shall establish a repeatable, secure, commercially oriented development capability for MileSoft, evolving with actual product requirements. This is a draft; architecture, targets, package boundaries and schedule require approval. No implementation or technical compatibility testing has been performed.

Next: project constitution, software architecture document, GitHub repository initialisation, Spec Kit initialisation, Phase 0 specification and Codex prompts, incremental implementation.
