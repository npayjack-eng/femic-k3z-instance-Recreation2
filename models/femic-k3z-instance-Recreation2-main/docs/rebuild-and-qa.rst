Rebuild and QA
==============

Deterministic Rebuild Script
----------------------------

Primary source of truth for K3Z rebuild sequence and invariants:

- ``config/rebuild.spec.yaml``

Use instance-local FEMIC rebuild orchestration for reproducible K3Z checks:

.. code-block:: bash

   femic instance rebuild \
     --run-config config/run_profile.k3z.yaml \
     --patchworks-config config/patchworks.runtime.windows.yaml \
     --with-patchworks \
     --run-id k3z_rebuild_check

Preview planned step order without mutation:

.. code-block:: bash

   femic instance rebuild \
     --run-config config/run_profile.k3z.yaml \
     --patchworks-config config/patchworks.runtime.windows.yaml \
     --with-patchworks \
     --dry-run \
     --run-id k3z_rebuild_plan

Manual equivalent command sequence (mirrors rebuild spec):

.. code-block:: bash

   femic prep validate-case --run-config config/run_profile.k3z.yaml --tipsy-config-dir config/tipsy
   femic prep geospatial-preflight
   femic run --run-config config/run_profile.k3z.yaml --run-id k3z_rebuild_check
   femic tsa post-tipsy --run-config config/run_profile.k3z.yaml --tsa k3z --run-id k3z_rebuild_check
   femic patchworks preflight --config config/patchworks.runtime.windows.yaml
   femic patchworks build-blocks --config config/patchworks.runtime.windows.yaml
   femic patchworks matrix-build --config config/patchworks.runtime.windows.yaml --run-id k3z_rebuild_check

Outputs
-------

- Rebuild report:
  ``vdyp_io/logs/instance_rebuild_report-<run_id>.json``
- Matrix logs:
  ``vdyp_io/logs/patchworks_matrixbuilder_{stdout,stderr,manifest}-<run_id>.log``

Key Invariants
--------------

- Managed area should remain near expected baseline.
- Block joins must remain 1:1 between ``tracks/blocks.csv`` and ``blocks/blocks.shp``.
- Seral accounts must exist in ``tracks/accounts.csv``.
- Required managed species yields must remain non-zero (except explicitly allowed species).

Baseline Workflow
-----------------

Initialize accepted baseline evidence (once per accepted model state):

.. code-block:: bash

   femic run --run-config config/run_profile.k3z.yaml --run-id k3z_baseline
   femic patchworks matrix-build --config config/patchworks.runtime.windows.yaml --run-id k3z_baseline

Validate against baseline:

.. code-block:: bash

   femic run --run-config config/run_profile.k3z.yaml --run-id k3z_compare
   femic patchworks matrix-build --config config/patchworks.runtime.windows.yaml --run-id k3z_compare
