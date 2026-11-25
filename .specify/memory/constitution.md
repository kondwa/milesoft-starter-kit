# MileSoft Starter Kit Constitution

## Core Principles

### I. SIMPEL and Lean Engineering

Every change MUST serve a documented user, business or engineering need. Apply Simplicity, Impact, Meaningful, Practical, Evolving and Lean as decision criteria. Prefer the smallest maintainable solution. MUST NOT introduce speculative abstractions, dependencies or services without a demonstrated need. Record justification for material complexity in an architecture decision record (ADR).

### II. Reusability Without Product Coupling

Shared packages MUST NOT depend on individual products or embed product-specific branding, pricing, schemas or business rules. Products MUST configure and compose shared capabilities through documented public interfaces. Extract packages only when a cohesive boundary and reuse or independent testing need exist. The showcase MUST demonstrate each implemented shared capability. Products MUST remain independently deployable.

### III. Clean Architecture and Dependency Inversion

Domain and application logic MUST be independent of Flutter widgets, Firebase and payment SDKs. Presentation and infrastructure depend on inward-facing contracts; infrastructure implements those contracts. Composition roots MUST wire implementations through dependency injection. BLoC/Cubit MUST manage nontrivial presentation state; widgets MUST NOT contain business rules. Circular dependencies are prohibited. GetIt MUST NOT be used as a hidden dependency inside domain logic.

### IV. Modular and Evolvable Design

Modules MUST expose minimal documented contracts and declare dependencies explicitly. Optional modules MUST be disableable without breaking unrelated functionality. Shared packages MUST follow Semantic Versioning, with compatibility tests and migration guidance for breaking changes. Consumers MUST use reproducible, compatible dependency versions. Private package distribution remains subject to ADR-002 approval.

### V. Specification-Driven Development

Every feature MUST trace to approved SRS requirements or an approved amendment. Before implementation, establish a feature specification with user scenarios, acceptance criteria, constraints and unresolved questions; then produce a technical plan and ordered tasks. Spec Kit and Codex MUST follow this constitution. Agents MUST NOT silently invent requirements, resolve material business decisions, or expand scope. Material ambiguities MUST be escalated to the project owner. Architectural decisions MUST be recorded before dependent implementation.

### VI. Test-First and Evidence-Based Quality

For new or changed business behavior, write failing automated tests before production implementation, then implement and refactor. Defect fixes MUST include regression tests. Use unit, widget, BLoC, contract, integration, security-rule and end-to-end tests as appropriate. Shared business logic MUST target at least 80% coverage; all mandatory acceptance tests MUST pass. Coverage alone is not evidence of correctness. Tests MUST be deterministic where feasible and MUST NOT require live payments or production data. Any justified exception to test-first sequencing MUST be documented and approved; tests remain mandatory before merge.

### VII. Security, Privacy and Data Isolation

Apply least privilege, deny-by-default access rules, server-side authentication and authorisation, and input validation at trust boundaries. Client input and client-side state MUST NOT be trusted for privileged operations. Products and environments MUST have isolated data and credentials under the proposed isolation model, pending ADR approval. Secrets MUST NOT be committed or embedded in distributed clients. Sensitive data MUST NOT enter logs or analytics. Support consent, data export, deletion and retention workflows; preserve legally required records under documented policies. Use secure transport, appropriate abuse controls, dependency scanning and applicable App Check protections. No unresolved critical security defect may enter production.

### VIII. Commercial Integrity and Entitlements

Billing MUST be separated from feature authorisation. Payment provider events MUST be authenticated and purchases verified server-side. Processing MUST be idempotent and robust to retries, duplicate and out-of-order events; reconciliation MUST correct missed events. Clients MUST NOT write trusted subscription or entitlement records. Protected operations and usage limits MUST be enforced server-side, with atomic updates where concurrency matters. Handle refunds, revocations, renewals, expiry and cancellation according to provider rules and approved product policy. Store billing and checkout MUST comply with applicable platform and regional rules. Never embed payment secrets or assume client-reported purchase success grants access.

### IX. Platform and Provider Independence

External services MUST be accessed through replaceable adapters where they cross domain boundaries. Use the approved Flutter/Dart and Firebase baseline; deviations require an ADR. Android and web are the proposed first milestone, with iOS commercial readiness following; platform capabilities MUST be verified before claiming support. Unsupported optional services MUST degrade gracefully or be disabled explicitly. Do not claim that an abstraction guarantees effortless vendor migration.

### X. Consistent and Accessible User Experience

Use the shared Material 3 design system with configurable product branding. Provide loading, empty, error and success states; responsive layouts; accessible semantics; scalable text; and keyboard navigation where applicable. Target WCAG 2.2 AA where applicable. User-facing strings MUST be externalised for localisation; dates, numbers and currencies MUST respect locale and product policy. Monetary values MUST use an exact representation appropriate to the currency, not binary floating-point arithmetic for financial calculations. User-facing errors MUST be actionable and MUST NOT expose internal secrets.

### XI. Operational Efficiency and Reliability

Cloud resources MUST use bounded queries, appropriate caching and configurable scaling. Expensive services, including AI, MUST remain optional. Establish cost monitoring, documented resource limits and environment-specific configuration. Critical workflows MUST support recovery and safe retries; production deployments MUST have documented backup, restoration and rollback or forward-recovery procedures. Logs MUST be structured and privacy-safe. Performance and availability targets MUST be measured against documented conditions; they are not guarantees of third-party service uptime.

### XII. Quality Gates and Responsible Evolution

All changes MUST pass formatting, static analysis, relevant automated tests and applicable build/security checks before merge. Public APIs, configuration and integration instructions MUST be documented. Releases MUST be traceable to source commits and version tags. Production deployments require explicit approval. AI-generated code is subject to the same review, licensing, security and test standards as human-written code. Do not claim tests or builds passed unless actually executed; record blockers and incomplete verification.

## Technical Standards and Constraints

- Baseline: Flutter/Dart, BLoC/Cubit, GetIt at composition roots, GoRouter, Firebase adapters, TypeScript Cloud Functions, Dart Pub Workspaces, Mason and GitHub Actions, as proposed in SRS v0.1.0. Confirm versions and platform compatibility during planning.
- Use Freezed and json_serializable where justified; do not mandate generation for trivial models.
- Use local emulators, fakes and sandbox payment accounts for development and automated tests. Production credentials and customer data MUST NOT be used in tests.
- Configuration MUST be validated at startup. Feature flags MUST NOT bypass security or entitlement enforcement.
- Persist timestamps in UTC where appropriate and convert for presentation; define schema versions and migration strategies.
- Keep the repository private under the proposed ownership model; review third-party licences before adoption. Final package licensing and distribution require owner approval.

## Development Workflow and Quality Gates

1. **Specify:** identify SRS IDs, user scenarios, measurable acceptance criteria and out-of-scope behavior.
2. **Plan:** define boundaries, dependencies, data contracts, security/privacy implications, platform support, cost implications and test strategy. Complete a constitution check; document justified complexity and unresolved ADRs.
3. **Task:** break work into independently verifiable increments, including tests and documentation.
4. **Implement:** follow red-green-refactor for business behavior; keep changes within approved scope.
5. **Verify:** run applicable formatting, analysis, tests, builds, security rules and showcase checks. Record commands and results; distinguish unexecuted checks from passed checks.
6. **Review and release:** review requirements traceability, compatibility, security, documentation and migration/recovery instructions. Obtain production deployment approval.

### Definition of Done

A module is complete only when approved requirements and acceptance criteria are satisfied; applicable tests and quality gates pass; public contracts and configuration are documented; the showcase demonstrates the capability; and security, compatibility and operational concerns are addressed. Deferred work and failed or unexecuted checks MUST be explicitly recorded. A partial implementation MUST NOT be represented as production-ready.

## Governance

This constitution governs all starter kit code, templates, backend services, documentation and AI-assisted changes. Applicable law and distribution platform obligations take precedence; within the project, the constitution governs engineering practice and the approved SRS governs functional scope. Conflicts MUST be resolved by the project owner before implementation proceeds.

The MileSoft project owner is the proposed ratifying and amendment authority. Amendments MUST include rationale, impact assessment, affected requirements and artifacts, migration steps where necessary, and explicit approval. Update the constitution version and amendment date upon approval. Use MAJOR for incompatible governance changes or removal/redefinition of principles, MINOR for new principles or substantive expansions, and PATCH for clarifications without normative changes.

Exceptions MUST be narrow, time-bound, documented with risk and mitigation, and explicitly approved. Exceptions cannot waive applicable legal obligations or mandatory production security and payment integrity gates. Review compliance during specification, planning, pull request review and release readiness. Pending SRS architectural decisions remain pending; this constitution does not ratify them implicitly.

**Version**: 0.1.0 \| **Status**: Draft for approval \| **Ratified**: Pending \| **Last Amended**: 2026-11-25 (draft)
