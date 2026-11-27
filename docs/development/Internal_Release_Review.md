# Consolidated internal release review and licence disposition

Prepared on 2026-11-27 for the MileSoft project owner under the [approved quality amendment](../adr/internal-release-quality.md). This is one review packet with a separate decision for each intended internal version. The MileSoft project owner approved the consolidated review and proposed internal licence disposition for both listed versions on 2026-11-27. The owner separately authorized both internal releases on 2026-11-27.

| Intended version | Reviewed source and scope | Technical assessment | Owner disposition |
| --- | --- | --- | --- |
| v0.1.0 | Phase 0 completion `697147ff650fca91e033c941cf435452abd638bf`. Phase 0 implementation and workflow match the CI source at `883d7bc755be5aaceefa26f5595ebad8378a60ae`. | SC-001, SC-002 and SC-004 pass. SC-003 CI and enforcement pass under the amended evidence rule. Consolidated review and internal licence disposition approved. | Approved on 2026-11-27 |
| v0.2.0 | Phase 1 candidate `71bc5b3c45b93ad60342a8c354db51c2989909c9`. Its tracked tree matches `main` at `8f9e1b7200a688e53986d6ce248e173684860981`. | SC-001 and SC-002 retain their passes. Amended SC-003/T034 and SC-004 technical evidence pass. Consolidated review and internal licence disposition approved. | Approved on 2026-11-27 |

## Evidence reviewed

- Phase 0 fresh checkout passed standard Dart and Flutter tests, the documented setup, both builds and Android and Chrome launches. The original primary-branch run passed with the same foundation runtime, tests and lockfile. [Phase 0 acceptance](../../specs/001-project-foundation/acceptance.md#phase-0-fresh-checkout-recheck--2026-11-27) · [Phase 0 CI](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45800249983)
- Phase 1 PR CI and subsequent main CI passed with the Phase 0 checks carried forward, plus the Phase 1 checks. The controlled PR failed the configured required check and was blocked. Removing the test restored passing CI and a clean merge state, after which the PR closed without merging. [PR #2 CI](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45973425649) · [Current main CI](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45975136460) · [Controlled verification](../../specs/001-project-foundation/acceptance.md#controlled-failed-check-evidence-and-review-preparation)
- Standard Phase 1 configuration tests passed across development, staging and production. Core coverage was 96.8%. The 17 showcase widget tests passed. The Android and Chrome evidence satisfies the representative internal accessibility scope. Exhaustive work stays open in the [quality backlog](Release_Quality_Backlog.md). [Phase 1 acceptance](../../specs/002-core-design-system/acceptance.md)

## Licence findings and proposed disposition

The Phase 0 and Phase 1 root lockfiles have identical content. Phase 1 adds the first-party UI workspace package and reuses the locked `material_ui` 1.11.1 and Flutter SDK. OSV-Scanner 2.7.1 reported no issues across 66 packages in the recorded checks. The vulnerability scan and the notice inventory provide separate evidence.

A local inventory of the 62 hosted packages in `pubspec.lock` found licence or copying files for all 62. Text matching detected 57 with BSD three-clause wording, three with Apache licence text and two with MIT or MIT-style text. This was a notice inventory, so review mixed notices and any separate files with additional terms before relying on the classification. The directly declared hosted packages `intl` 0.20.3, `material_ui` 1.11.1, `lints` 6.1.0 and `test` 1.32.0 contain BSD three-clause terms. Preserve copyright and licence notices and applicable attribution on covered reuse or redistribution.

For the internal scope, the approved disposition is to retain the pinned dependencies, preserve the notices and record any unknown, incompatible or additional terms before approval. External publishing remains subject to ADR-002, ADR-013, clean-consumer verification and applicable licence and notice checks. All current package manifests use `publish_to: none`.

## Owner record

For each version, record the reviewer name and date, evidence reviewed, licence disposition (including any unresolved terms), deferred work accepted under the ADR, and approve or hold with rationale. Confirm the source revision that represents the release and reassess material changes before proceeding. Record explicit authorization separately for any release, tag, publication or deployment.

**Decision — GO for internal v0.1.0 and v0.2.0.** The owner authorized release of the reviewed internal versions on 2026-11-27. The implementation evidence applies to the source revisions above. The approval covers internal release scope.

## Internal release checklist

- [x] Verify the mandatory technical gates, including passing required CI and the controlled merge-enforcement result.
- [x] Record the approved consolidated owner review and internal licence disposition for both versions.
- [x] Record internal release authorization and the reviewed source revisions.
- [ ] Create version tags after the owner separately authorizes tagging. Verify each tag resolves to its reviewed source. Use the Phase 0 completion commit for v0.1.0 and the matching tested `main` revision for v0.2.0.
- [ ] Record completed release actions and their resulting identifiers here.

## Next phase transition

Use the v0.2.0 reviewed tree as the Phase 2 planning baseline. The [SRS roadmap](../requirements/SRS.md#14-release-strategy) assigns authentication and profiles to v0.3.0. Obtain owner approval of Phase 2 scope and applicable identity and backend isolation decisions under ADR-003 and ADR-004 before dependent implementation. Trace authentication and profile requirements to acceptance, verification and security controls. Carry the [quality improvement backlog](Release_Quality_Backlog.md) forward and apply the release class in the [quality ADR](../adr/internal-release-quality.md). ADR-002 and ADR-013 remain gates for external distribution.
