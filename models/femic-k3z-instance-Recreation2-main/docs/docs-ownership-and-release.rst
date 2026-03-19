Docs Ownership and Release
==========================

Purpose
-------

This page defines who owns the K3Z docs set, how often it must be refreshed,
how docs changes are reviewed, and how docs versions align to model snapshots.

Ownership Matrix
----------------

+----------------------+----------------------------+-----------------------------+
| Area                 | Primary Owner              | Backup Owner                |
+======================+============================+=============================+
| Data-package content | Case maintainer            | FEMIC maintainer            |
+----------------------+----------------------------+-----------------------------+
| Rebuild/runbook      | Case maintainer            | FEMIC maintainer            |
+----------------------+----------------------------+-----------------------------+
| Sphinx template/CI   | FEMIC maintainer           | Case maintainer             |
+----------------------+----------------------------+-----------------------------+
| Publication checks   | FEMIC maintainer + reviewer| Case maintainer             |
+----------------------+----------------------------+-----------------------------+

Update Cadence
--------------

- Per model rebuild release: update run IDs, invariant outcomes, and any
  changed assumptions before tagging.
- Monthly minimum: review known limitations and troubleshooting sections for
  stale guidance.
- Quarterly minimum: rerun docs contract checks and verify section parity
  against TSR-grade page requirements.
- Event-driven: update immediately after any change to data lineage,
  assumptions, account/target logic, or rebuild sequence.

Release Tagging and Versioning Policy
-------------------------------------

- Tag each published model snapshot with a SemVer-style tag in this repo, such
  as ``v0.2.0``.
- Treat docs changes that alter interpretation or operator procedure as release
  changes tied to the same tag as model artifacts.
- Include in each release note:

  - scope of model/data changes,
  - impacted docs pages,
  - validation evidence (docs ``-W`` build + rebuild report reference).

- Never publish a model snapshot without matching docs updates when assumptions,
  lineage, or operating steps changed.

Contributor Onboarding and Review Workflow
------------------------------------------

- New contributors start with:

  - ``getting-started.rst``,
  - ``model-anatomy.rst``,
  - ``operator-runbook.rst``,
  - this page.

- Every docs PR must include:

  - a short rationale and impacted sections,
  - explicit statement of what is editable vs generated if workflow changed,
  - updated provenance entries when source artifacts changed.

- Required checks before merge:

  - ``python -m sphinx -b html docs docs/_build/html -W``,
  - parent-repo docs contract tests that validate K3Z required sections.

- Reviewer checklist:

  - section completeness preserved (TSR-style headings still present),
  - standalone-path independence preserved (no parent-repo file assumptions),
  - release-note entry prepared when user-facing behavior changed.

