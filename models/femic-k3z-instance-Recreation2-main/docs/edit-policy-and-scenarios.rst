Edit Policy and Scenarios
=========================

Edit Policy Matrix
------------------

.. list-table::
   :header-rows: 1

   * - Asset Class
     - Policy
     - Rationale
   * - ``config/*.yaml``
     - Safe to edit
     - Scenario and runtime controls are intentional operator inputs.
   * - ``docs/*.rst``
     - Safe to edit
     - Narrative/metadata documentation evolves with model understanding.
   * - ``data/model_input_bundle/*.csv``
     - Regenerate preferred
     - Generated from upstream logic; direct edits are fragile.
   * - ``models/k3z_patchworks_model/tracks/*.csv``
     - Regenerate preferred
     - Matrix builder outputs; hand edits can break joins/targets.
   * - ``models/k3z_patchworks_model/yield/forestmodel.xml``
     - Regenerate preferred
     - Export product tied to source assumptions and curve logic.

Scenario Comparison Guidance
----------------------------

Compare scenarios using consistent metrics and reporting windows:

- managed total/product yields,
- species-wise managed products,
- seral-stage area and treatment-shift trajectories,
- key constraints/targets and infeasibility indicators.

Interpretation Workflow
-----------------------

1. Run baseline and variant scenarios with explicit run-ids.
2. Compare account trajectories period-by-period.
3. Flag differences caused by assumption changes vs data/build drift.

Classroom Use Guidance
----------------------

- Start from reproducible baseline before exploring policy changes.
- Change one assumption family at a time when teaching sensitivity.
- Preserve run manifests/reports for each scenario to support auditability.

How to Validate Reruns
----------------------

1. Confirm matrix-build manifest success.
2. Confirm rebuild report invariants pass.
3. Confirm scenario deltas are explainable by intentional config edits.
