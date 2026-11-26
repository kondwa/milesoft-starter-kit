# MileSoft Starter Kit agent guidance

- Read the [constitution](.specify/memory/constitution.md), [SRS](docs/requirements/SRS.md) and [SAD](docs/architecture/SAD.md) before preparing feature artifacts or implementing changes.
- Follow the constitution for engineering practice and the approved SRS for functional scope. Use the SAD for architecture within those constraints. Escalate conflicts, material ambiguities and unapproved ADR dependencies to the owner before dependent work. Drafts and proposed defaults require approval.
- For Phase 0, use the [prompt sequence](docs/development/Phase_0_Prompts.md). Run the requested prompt only and stop at its review gate. See the [constitution review](docs/development/Phase_0_Constitution_Review.md) for open baseline decisions.
- Trace each in-scope SRS ID through measurable acceptance criteria, tests and tasks. Record exclusions and later milestones while preserving applicable release requirements.
- Apply Constitution VI when generating tasks. The generic Spec Kit guidance on optional tests does not waive test-first sequencing for business behavior, regression tests for defects or other applicable mandatory tests. Record any approved sequencing exception and include the required tests before merge.
- Keep shared dependencies inward and explicit. Demonstrate implemented shared capabilities in the showcase. Record applicable verification commands and actual results, including failed or unexecuted checks. Mark tasks complete after verification.
