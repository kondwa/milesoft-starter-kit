# Phase 0 acceptance evidence

## Amended internal v0.1.0 assessment — 2026-11-27

**GO for internal v0.1.0.** The owner authorized internal release on 2026-11-27. The owner approved the consolidated review and internal licence disposition on 2026-11-27. SC-001, SC-002 and SC-004 retain their passes. **SC-003 CI and merge enforcement pass under the [approved amendment](../../docs/adr/internal-release-quality.md).** The [Phase 0 primary run](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45800249983) and [clean checkout](#phase-0-fresh-checkout-recheck--2026-11-27) establish the foundation scope, including both builds, standard runners and the pinned scan. The [merged Phase 1 PR](https://github.com/kondwa/milesoft-starter-kit/pull/2) and [current main CI](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45975136460) exercise those quality controls and the added Phase 1 checks. The [controlled gate proof](#controlled-failed-check-evidence-and-review-preparation) verifies the mandatory check blocked a normal merge, and the cleanup run passed. The root lockfile matches across both phases. This is the approved equivalent evidence for the historical Phase 0-only PR gap. No reproduction PR is needed.

SC-003 and T017 pass under the amended criteria. The approved version-bound owner review and licence disposition are recorded in the [review packet](../../docs/development/Internal_Release_Review.md). The Phase 0 candidate remains `697147ff650fca91e033c941cf435452abd638bf`.

The sections below preserve the original criteria, including the previous Phase 0-only PR gap and PR-specific review expectations. Use the amended assessment above for current decisions.

## Current release disposition — 2026-11-27

### Phase 0-only compliant PR evidence gap

GitHub's Actions REST query with `event=pull_request` returned zero runs for both `883d7bc755be5aaceefa26f5595ebad8378a60ae` and `697147ff650fca91e033c941cf435452abd638bf`. The repository PR list showed #1 and #2 merged with Phase 1 content and #3 closed after the controlled gate check against Phase 1 `main`. The Phase 0 push run, successful local acceptance, and controlled required-check proof retain their scope.

SC-003/T017 still needs a successful `pull_request` Quality run attributable to the Phase 0-only tree, with the PR URL, base/head and checked SHA, pinned toolchain and actual runner image, command/job results, both builds and root-lockfile scan output. It also needs the owner's SHA-bound review and actual licence findings under the approved solo-maintainer policy. The primary-branch run and Phase 1 PR runs cover different events or trees.

If no archived Phase 0 PR run can be recovered, propose one temporary PR inside the approved repository, from the Phase 0 completion tree into an isolated Phase 0 base at `883d7bc`. The minimal PR change outside the original Phase 0 documentation is to add that exact temporary base name to the Phase 0 workflow's `pull_request.branches` filter. Verify by diff that the runtime, tests, lockfile, workflow jobs and check name match Phase 0. Capture the run and owner review, then close the PR without merging. Obtain owner agreement first on whether this isolated-base evidence satisfies SC-003/T017. If the owner requires a PR targeting `main`, the evidence remains open because today's `main` contains Phase 1. No verification PR was opened for this proposal.

### Controlled failed-check evidence and review preparation

[Quality on main](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45975136460) completed successfully on push to `8f9e1b7200a688e53986d6ce248e173684860981`. The separate, non-draft [verification PR #3](https://github.com/kondwa/milesoft-starter-kit/pull/3) targeted that base. Its red head `bb8a3f472e203e676ed565f0a0ea0813dff58290` added one deterministic failing Dart test. The [red job](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45976022842/job/140427828071) failed in **Test core** with the expected assertion. `gh pr checks 3 --required` identified **Phase 0 quality** as failed. `gh pr view 3` reported an open, non-draft, conflict-free PR (`mergeable: MERGEABLE`) with `mergeStateStatus: BLOCKED`. Classic protection required that check from GitHub Actions app `15368`, strict base freshness and administrator enforcement, with zero required approvals. The active branch rules and ruleset inventory were empty. No merge attempt or bypass was used. Raw evidence is in `apps/showcase/build/merge-gate-8f9e1b7`.

The test was removed at `08ed9d10b859b4d70064c8ed3f1474abcbacf743`. A temporary Markdown marker kept the comparison open. [Cleanup CI](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45976587269) passed on that exact SHA, and GitHub changed PR #3 to `mergeStateStatus: CLEAN` against the same base. The PR was closed and GitHub returned `mergedAt: null` and `mergeCommit: null`. `main` stayed at `8f9e1b7200a688e53986d6ce248e173684860981`. See `green-run.json`, `green-pr.json` and `closed-pr.json` in the local evidence directory. This resolves the controlled failure evidence for DEV-004. The [Phase 1 acceptance record](../002-core-design-system/acceptance.md) captures the shared evidence.

**T017 and SC-003 remain open.** PR #1 passed Phase 1 CI and included the Phase 0 completion commit in its history. Its reviewed head also contained Phase 1 behavior. PR #2 exercised the same Phase 1 release content, and PR #3 exercises DEV-004 against current `main`. The original Phase 0 main push and passing scan remain valid. The merged PRs do not provide a compliant PR run tied to the Phase 0-only candidate.

**Prepared for owner self-review.** On PR #1 at `71bc5b3c45b93ad60342a8c354db51c2989909c9`, the prior owner comments do not record the scope, evidence, licence findings or disposition required by the solo-maintainer ADR. Review the exact diff, [passing PR CI](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45957113272), the Phase 0 fresh-checkout evidence and the open Phase 0-specific PR gap. Record the owner's actual findings against the applicable final candidate SHA. The Phase 0 scan found no issues across 66 locked packages, and the earlier local review found licence notices for all 62 hosted packages. Notice presence and scan results provide inputs to the owner's dependency licence review.

The owner approved the [Solo Maintainer Release Governance ADR](../../docs/adr/solo-maintainer-release-governance.md) for eligible internal Phase 0 and Phase 1 releases. It permits a documented owner self-review when an independent reviewer is unavailable. GitHub configuration and an actual review record remain pending. The required status check, compliant PR evidence and controlled failure proof remain mandatory. Earlier references to independent approval below reflect the policy at the time.

### Required-check configuration recheck

Live `gh api repos/kondwa/milesoft-starter-kit/branches/main/protection` now lists **Phase 0 quality** from app ID `15368` as a required check, with strict base freshness, one approving review, stale-review dismissal and administrator enforcement. The check-runs endpoint for the candidate identifies app ID `15368` as `github-actions`. The branch rules and ruleset inventory both returned `[]`, so the required check comes from classic protection. This supersedes the earlier empty-check snapshot below.

T017 and SC-003 remain open. The [verification branch run](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45961861654) passed on the Phase 1 candidate. There is no recorded controlled failing check on that branch, and neither candidate PR has an independent approval. Compliant Phase 0 PR and licence evidence remain outstanding. [Updated readiness assessment](../002-core-design-system/acceptance.md#required-check-configuration-recheck)

**Hold internal v0.1.0.** SC-001 remains passed. SC-002 passes with the existing successful CI builds, the standard Flutter test rerun and the two platform launches below. SC-003 remains blocked on required-check enforcement and compliant PR review evidence. The owner approved public repository visibility on 2026-11-27. SC-004 passes with the completed fresh-checkout walkthrough. Release authorization remains outstanding.

### Phase 0 fresh-checkout recheck — 2026-11-27

The recheck used a fresh local clone at the Phase 0 completion commit `697147ff650fca91e033c941cf435452abd638bf`. The runtime, tests, workflow and lockfile match the passing Phase 0 CI commit `883d7bc755be5aaceefa26f5595ebad8378a60ae`. The local evidence directory is `apps/showcase/build/phase0-release-evidence` in the parent checkout. It contains the command logs and elapsed results.

| Requirement and remediation | Verification command and working directory | Result and evidence |
| --- | --- | --- |
| SC-001, SC-004, T020 · Reproduce the workspace setup | Root: `flutter --version`, `flutter doctor -v`, `flutter pub get --enforce-lockfile`, `dart pub workspace list` | Flutter 3.50.0 and Dart 3.14.0. Doctor, online locked resolution and the two-member workspace check passed in 16.8 s, 8.5 s and 4.9 s. See `versions.log`, `doctor.log`, `resolve.log` and `workspace.log`. The first doctor selected bundled Java 25. The isolated Flutter settings used for the Android rerun selected Temurin 17.0.21+9. That doctor verified the SDK and devices and reported an intermittent GitHub DNS error. See `doctor-pinned.log` and `devices.log`. |
| SC-001, SC-004, T015/T020 · Reproduce local quality checks | Showcase: `flutter gen-l10n`. Root: `dart format --output=none --set-exit-if-changed packages/milesoft_core apps/showcase tool`, `dart analyze --fatal-infos`, `dart run tool/check_workspace_dependencies.dart` | All passed. Elapsed 8.6 s, 3.2 s, 21.2 s and 6.8 s respectively. See `l10n.log`, `format.log`, `analyze.log` and `boundary.log`. |
| SC-002, SC-004, T008/T011/T020 · Confirm the test evidence with the standard runners | Core: `dart test`. Showcase: `flutter test --no-pub`. | All four core and three showcase cases passed in 19.2 s and 31.8 s. The showcase asserts the accessible core-derived label and in-bounds scaled layout at 320 and 1280 logical pixels. See `core.log` and `showcase.log`. Phase 0 contains no shared business logic subject to the 80% threshold. |
| NFR-SEC-009, SC-003, SC-004, T016/T020 · Recheck the approved root lockfile | Root: OSV-Scanner 2.7.1 `scan source --lockfile=pubspec.lock` | Exit 0 in 6.8 s, 66 packages, no issues. The Windows binary matched SHA-256 `7121dcf420aefbbf89a7f0050c4d3094e079ff93afd334dfc96f16b02ec85800`. See `osv.log`. The separate PR licence review remains open. |
| SC-002, SC-004, T010/T020 · Build and launch Android | Showcase: `flutter build apk --debug --no-pub`, then `flutter run --no-pub --no-resident -d emulator-5580 --use-application-binary=build/app/outputs/flutter-apk/app-debug.apk` | Standard debug build passed with pinned Temurin in 241.8 s. The API 36 x64 emulator launch exited 0 in 60.9 s. Visual inspection and UI Automator both confirmed “MileSoft Starter Kit”. See `build-android-pinned.log`, `launch-android.log`, `apk-hash.txt`, `android.png` and `android.xml`. The initial build with bundled Java was stopped before recording a result. |
| SC-002, SC-004, T010/T020 · Launch Chrome | Showcase: `flutter run --no-pub -d chrome --web-port=18740 --web-browser-flag=--headless` | Chrome 148.0.7778.168 connected to the Flutter debug service after 113.9 s. Visual inspection of the runner's browser and its accessibility tree confirmed “MileSoft Starter Kit”. See `launch-chrome.log`, `chrome-flutter.png` and `chrome-flutter-ax.json`. An early capture from a second browser showed the loading screen. The accepted capture is from Flutter's own Chrome instance before stopping the interactive runner. |
| SC-002, SC-004, T010/T020 · Build the standalone web target | Showcase: `flutter build web --no-pub` | Exit 0 in 117.5 s, including a successful Wasm dry run. See `build-web.log` and the fresh checkout’s `apps/showcase/build/web`. |

T010 and T020 are complete. The fresh checkout remained clean. The approved setup guide and ADR links were reviewed against the commands above. The platform gaps required verification and evidence updates, and no implementation defect was found.

### Live GitHub reconciliation — 2026-11-27

Authenticated read-only GitHub queries succeeded. See the `github-*.json` captures and `github-snapshot-utc.txt` in the local evidence directory. Repository `kondwa/milesoft-starter-kit` (REST repository ID `1472543315`) is public. The default branch `main` was at `883d7bc755be5aaceefa26f5595ebad8378a60ae` and reported `protected: true`.

| Requirement | Verification command | Current result and evidence |
| --- | --- | --- |
| ADR-001, SC-003, T017 · Approved repository visibility | `gh repo view --json id,nameWithOwner,visibility,defaultBranchRef` | Public. The owner approved this visibility on 2026-11-27 in [ADR-001](../../docs/adr/ADR-001-workspace.md). |
| DEV-004, SC-003, T017 · Classic protection | `gh api repos/kondwa/milesoft-starter-kit/branches/main/protection` | One approving review, stale-review dismissal and admin enforcement are enabled. The strict status-check setting has empty `contexts` and `checks`. **Phase 0 quality** is absent from the required list. |
| DEV-004, SC-003, T017 · Active rulesets | `gh api repos/kondwa/milesoft-starter-kit/rules/branches/main` and `gh api 'repos/kondwa/milesoft-starter-kit/rulesets?includes_parents=true'` | Both returned `[]`. The snapshot provides no active ruleset that requires a status check on `main`. |
| DEV-001/002/004, AC-018, SC-003, T017 · Phase 0 compliant PR and blocked merge | `gh pr view 2 --json headRefOid,baseRefName,isDraft,reviewDecision,statusCheckRollup` | [PR #2](https://github.com/kondwa/milesoft-starter-kit/pull/2) targets `main` and remains draft with review required. Its [baseline run](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45961861654) passed **Phase 0 quality** on the Phase 1 head `71bc5b3c45b93ad60342a8c354db51c2989909c9`. The Phase 0 compliant PR, independent licence review and controlled failing-check evidence remain outstanding. The existing [Phase 0 primary-branch run](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45800249983) remains valid. |

The current snapshot confirms the classic review-only report. It supersedes the earlier HTTP 403, HTTP 404 and connection errors as descriptions of the current state. DEV-004 remains open. The owner must authorize the administrator to add **Phase 0 quality** from GitHub Actions to the required checks on `main`, preserving the existing safeguards. Independent review and the authorized controlled check failure with a non-bypass actor are still required. No release authorization or exception is recorded.

### Controlled merge-gate verification — 2026-11-27

The [live reconciliation above](#live-github-reconciliation--2026-11-27) supersedes the initial settings lookup failure and records the passing baseline run.

The only Actions workflow, `Quality`, targets pull requests to `main` and runs one mandatory job named **Phase 0 quality** (workflow job ID `phase-0-quality`). The trigger already exists on the Phase 0 base and the Phase 1 candidate. No workflow change was needed. The observed job name is the exact check context to require. The current list of configured required checks remains unverified because the live classic protection, active rules and ruleset inventory requests could not connect.

Opened [draft PR #2](https://github.com/kondwa/milesoft-starter-kit/pull/2) from `codex/verify-release-merge-gate` to `main` in repository ID `1472543315`. The base is `883d7bc755be5aaceefa26f5595ebad8378a60ae` and the candidate head is `71bc5b3c45b93ad60342a8c354db51c2989909c9`. GitHub started [Quality run 45961861654](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45961861654) on the candidate. Draft status prevents merging at this stage and provides no evidence that a failed check enforces the gate.

**Owner/admin action.** Use the approved public repository and verify effective protection on `main`. In **Settings → Rules → Rulesets** and **Settings → Branches**, inspect all rules applying to `main`. If the effective settings lack either requirement, edit the existing active rule or create an active branch ruleset for `refs/heads/main`. Require a pull request with at least one independent approval and require **Phase 0 quality** from GitHub Actions. Retain other mandatory protections and ensure the verification actor has no applicable bypass. Supply a dated settings export or screenshots of classic protection and all matching active rulesets, with required contexts, sources and bypass settings. Name an eligible independent reviewer with access to PR #2. [GitHub ruleset setup](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/creating-rulesets-for-a-repository)

The temporary failing test is pending that confirmation. To finish, commit a deterministic failing core test on the verification branch, observe **Test core** and **Phase 0 quality** fail, and capture the red SHA, run and GitHub's required-check merge-block reason with the PR ready for review and other merge conditions satisfied. Use the mergeability signal without submitting a merge. Remove the temporary test in a follow-up commit, capture the green SHA and run, and request independent review of the evidence and applicable licences. Keep T017 and DEV-004 open until those results are recorded.

### GitHub identity and merge enforcement

This section records the earlier connector and API observations. Use the live reconciliation above for the current settings.

The GitHub connector confirmed `kondwa/milesoft-starter-kit` (repository ID `1472543315`), matching the local `origin`. It reported public visibility, default branch `main`, and admin access for the connected viewer. At the time of that check, public visibility conflicted with the earlier private-repository decision. The owner subsequently approved public visibility in [ADR-001](../../docs/adr/ADR-001-workspace.md).

| Check for `refs/heads/main` | Historical evidence | 2026-11-27 recheck |
| --- | --- | --- |
| Branch summary and classic protection | The private-repository required-check query returned HTTP 403. A later report showed classic PR reviews with no required status checks. A subsequent report recorded `protected: false` and classic HTTP 404 `Branch not protected`. | `branches/main` and `branches/main/protection` could not connect to the GitHub API. Current classic settings are unavailable. |
| Active rules and ruleset inventory | The last recorded `rules/branches/main` response was empty. | `rules/branches/main` and `rulesets?includes_parents=true` could not connect. Current matching rulesets, check sources and bypass settings are unavailable. |

The records do not establish when settings changed. Classic protection and active rulesets can both apply, so evaluate them together. Capture all four endpoint results in one timestamped snapshot using authorized read access. For each matching ruleset, record its source, enforcement mode, branch conditions, required check name and source, PR review requirements and bypass actors. A protected branch flag or a passing workflow alone cannot establish DEV-004. T017 still requires proof that **Phase 0 quality** is required and that its failure blocks a normal merge with the other merge conditions satisfied. [GitHub rules API](https://docs.github.com/en/rest/repos/rules) · [GitHub rule layering](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets#about-rule-layering)

[Phase 0 run 45800249983](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45800249983) remains the Phase 0 primary-branch evidence. [Phase 1 run 45957113272](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45957113272) adds passing PR workflow execution for the Phase 1 revision. The Phase 0 compliant PR record, applicable licence review and controlled merge failure remain open.

## 00.14 release review — 2026-11-26

**Release recommendation** — Hold internal v0.1.0. SC-002, SC-003 and SC-004 still require evidence. Release approval has not been recorded.

Reviewed the ratified [constitution](../../.specify/memory/constitution.md), [SRS](../../docs/requirements/SRS.md), [SAD](../../docs/architecture/SAD.md), [approved Phase 0 scope and requirement mappings](spec.md#scope-and-traceability-mandatory), [plan](plan.md), [owner decisions](research.md) and [tasks](tasks.md). All 15 specification-quality items were checked. The project has no separately recorded Phase 0 starting SHA, so the review used the docs-only repository commit `dee6886a169f46df5b76793399279d22c30fa2a0` as the comparison baseline. The application, workspace, lockfile, lints, dependency checker and workflow match the passing `main` commit `883d7bc755be5aaceefa26f5595ebad8378a60ae`.

| Criterion | Status | Requirements and tasks | Evidence |
| --- | --- | --- | --- |
| SC-001 — Workspace and core boundaries | **PASS** | FR-001, FR-002, FR-004, ARC-002, ARC-011 · T003–T006, T011–T015, T020 | The fresh checkout resolved the two workspace members with the enforced root lockfile. Core declares its own SemVer version `0.1.0` and the showcase uses its public API. The standalone core suite and resolved dependency check passed. |
| SC-002 — Platform builds and launches | **NOT VERIFIED** | FR-002, FR-003, FR-004, DEV-003, SHW-001, SHW-007, SHW-008 · T007–T011, T016, T020 | The passing `main` run produced both builds. The local web rebuild and three showcase tests passed, and the unchanged implementation rendered the expected label in Chrome during T020. Android manual launch is unverified. |
| SC-003 — CI and merge enforcement | **NOT VERIFIED** | FR-004, FR-005, DEV-001–DEV-004, DEV-007, NFR-SEC-009, AC-018 · T011–T017 | Local checks and the primary-branch workflow passed. The PR list is empty, required-check settings return HTTP 403, and the controlled failing PR and reviewer licence evidence are pending. |
| SC-004 — Fresh contributor walkthrough | **NOT VERIFIED** | FR-006, DEV-003, NFR-MNT-002 · T018–T020 | Guide and ADR links resolve. Fresh setup, local checks, web build and Chrome launch passed. The standard Android build ran out of disk space in the disposable checkout. Android x64 built, and the emulator failed its disk-space preflight. |

### Local rerun

- From repository root, `flutter pub get --offline --enforce-lockfile`, `dart pub workspace list`, `dart format --output=none --set-exit-if-changed packages/milesoft_core apps/showcase tool`, `dart analyze --fatal-infos`, and `dart run tool/check_workspace_dependencies.dart` passed. `flutter gen-l10n` ran first from `apps/showcase`.
- In core, `dart test` passed all four cases. In showcase, `flutter test --no-pub` passed all three cases and `flutter build web --no-pub` passed. The core utility normalises display text and contains no shared business logic subject to the 80% coverage target.
- `flutter devices` listed Chrome, Edge and Windows. `adb devices -l` returned no Android devices. The host had about 0.27 GB free after the web build. The review used the successful standard Android build on the same CI commit and the existing local APK as build evidence. A local rebuild and emulator launch require sufficient disk space or another verification host.

### Scope and security review

- The implementation diff stays within the two-member workspace, one core API, minimal Material 3 showcase, tests, quality checks and documentation. Core has no runtime package dependencies. The showcase's Flutter and localisation dependencies support the approved UI. The dependency checker adds no package dependencies.
- `git diff --check dee6886` passed. The tracked credential-file and token-pattern checks returned zero matches in the reviewed scope. CI uses `contents: read`, disables checkout credential persistence and pins actions and downloaded tools. Android evidence covers the debug build.
- OSV-Scanner 2.7.1 rescanned `pubspec.lock` and reported no issues across 66 packages. All 62 hosted packages had local licence notices. PR reviewer licence verification and any owner dispositions remain pending. There are no recorded scan exceptions.
- T010, T017 and T020 remain open. The remaining evidence is the manual Android launch, the complete fresh Android walkthrough, a passing PR with licence review and a controlled failing PR blocked from merge. The distribution and licensing approvals under ADR-002 and ADR-013 remain deferred.

## SC-003 — Quality checks and merge enforcement

**Status** — NOT VERIFIED · 2026-11-26

GitHub confirmed [kondwa/milesoft-starter-kit](https://github.com/kondwa/milesoft-starter-kit) is private and uses `main` as its default branch. The local `origin` matches that repository.

**Local CI equivalents** — Workflow lint, locked dependency resolution, generation, format, analysis, dependency boundaries, four core tests, three widget tests, Android debug build and web build passed. OSV-Scanner 2.7.1 scanned 66 packages from `pubspec.lock` and reported no issues. See [T016 verification](tasks.md#github-actions--0012--us2).

| Evidence | Result |
| --- | --- |
| Primary-branch run | [Quality run 45800249983](https://github.com/kondwa/milesoft-starter-kit/actions/runs/45800249983) passed on push to `main` at `883d7bc755be5aaceefa26f5595ebad8378a60ae`. Runner image was `ubuntu-24.04` version `20261122.23.1`. Lockfile enforcement, formatting, analysis, dependency boundaries, both test suites, Android debug and web builds passed. |
| Compliant pull request run and licence review | The pull request list was empty. Passing PR checks and reviewer evidence are pending. |
| Required checks and controlled merge failure | The required-status-checks endpoint returned HTTP 403 and reported that this private repository needs GitHub Pro to enable the feature. No controlled blocked merge was verified. |
| Remote lockfile scan | OSV-Scanner checked 66 packages from the root lockfile and reported no issues in the passing `main` run. |

T017 remains unchecked. The passing `main` run satisfies the primary-branch evidence. Once the repository supports private branch protection, the administrator must require **Phase 0 quality** and pull request review for `main`. Reviewers verify licences for added or changed third-party dependencies, record the outcome on the pull request and refer unknown or incompatible terms to the project owner. Remaining evidence is a passing PR and a controlled failing PR blocked from a normal merge. [GitHub protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)

## SC-004 — Fresh-checkout developer walkthrough

**Status** — NOT VERIFIED · 2026-11-26

Followed the [developer setup guide](../../docs/development/Phase_0_Setup.md) against a clean local clone of `main` at `883d7bc755be5aaceefa26f5595ebad8378a60ae`. The host used Flutter 3.50.0, Dart 3.14.0 and Temurin 17.0.21+9.

| Step | Result | Elapsed |
| --- | --- | --- |
| Clone and setup | `flutter doctor -v`, `flutter pub get --enforce-lockfile` and `dart pub workspace list` passed. Pub listed core and showcase under the workspace root. | 70.9 s |
| Local checks | Localisation generation, format, analysis, dependency boundaries, four core tests and three showcase tests passed. OSV-Scanner 2.7.1 checked 66 packages and found no issues. | 80.9 s |
| Web build and launch | `flutter build web --no-pub` passed. Served the generated output on localhost and verified that Chrome 148 rendered “MileSoft Starter Kit”. | 81.4 s build |
| Android debug build | `flutter build apk --debug --no-pub` failed during `mergeDebugNativeLibs` because the host ran out of disk space. | 128.9 s |
| Android x64 debug build | `flutter build apk --debug --no-pub --target-platform=android-x64` passed after the disposable checkout's failed build output was cleared. | 80.7 s |
| Android launch | The Pixel9a emulator exited at its disk-space check. The host had 1.98 GB free after clearing regenerable checkout caches. No physical Android device was connected. | Not verified |

T020 remains unchecked. The standard Android build from this checkout and the Android launch still need verification. The standard Android build previously passed in the linked `main` workflow.
