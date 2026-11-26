# Phase 0 acceptance evidence

## SC-003 — Quality checks and merge enforcement

**Status** — NOT VERIFIED · 2026-11-26

GitHub confirmed [kondwa/milesoft-starter-kit](https://github.com/kondwa/milesoft-starter-kit) is private and uses `main` as its default branch. The local `origin` matches that repository.

| Evidence | Result |
| --- | --- |
| Phase 0 workflow on `main` | GitHub returned HTTP 404 for `.github/workflows/quality.yml`. |
| Compliant pull request and primary-branch runs | GitHub search returned no pull requests. No compliant run evidence was obtained. |
| Required checks and controlled merge failure | No settings or blocked merge evidence was obtained. |
| Lockfile scan, licence review and applicable coverage | Evidence pending implementation. |

T017 remains unchecked. The repository administrator must enable the required checks when the workflow is available. Acceptance requires passing PR and primary-branch runs and evidence that a controlled failing PR is blocked from a normal merge.
