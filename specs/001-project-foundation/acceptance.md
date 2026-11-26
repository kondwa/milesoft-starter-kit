# Phase 0 acceptance evidence

## SC-003 — Quality checks and merge enforcement

**Status** — NOT VERIFIED · 2026-11-26

GitHub confirmed [kondwa/milesoft-starter-kit](https://github.com/kondwa/milesoft-starter-kit) is private and uses `main` as its default branch. The local `origin` matches that repository.

**Local CI equivalents** — Workflow lint, locked dependency resolution, generation, format, analysis, dependency boundaries, four core tests, three widget tests, Android debug build and web build passed. OSV-Scanner 2.7.1 scanned 66 packages from `pubspec.lock` and reported no issues. See [T016 verification](tasks.md#github-actions--0012--us2).

| Evidence | Result |
| --- | --- |
| Phase 0 workflow on `main` | GitHub returned HTTP 404 for `.github/workflows/quality.yml` and listed zero workflows. The workflow is configured locally. |
| Compliant pull request and primary-branch runs | GitHub search returned no pull requests, and the Actions API listed zero runs on `main`. |
| Required checks and controlled merge failure | The branch-rules API returned HTTP 403 and reported that this private repository needs GitHub Pro to enable the feature. No controlled blocked merge was verified. |
| Remote lockfile scan and licence review | Awaiting GitHub Actions and pull request review evidence. |

T017 remains unchecked. Once the workflow is available on GitHub and the repository supports private branch protection, the administrator must require **Phase 0 quality** for `main` and require pull request review. Reviewers verify licences for added or changed third-party dependencies and record the outcome on the pull request. Refer unknown or incompatible terms to the project owner. Acceptance requires passing PR and primary-branch runs and evidence that a controlled failing PR is blocked from a normal merge. [GitHub protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
