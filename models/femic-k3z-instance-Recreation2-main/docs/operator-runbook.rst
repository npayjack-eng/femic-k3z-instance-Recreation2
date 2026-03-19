Operator Runbook
================

Fresh Setup
-----------

1. Initialize submodules and environment.
2. Validate prerequisites with case preflight.
3. Confirm Patchworks runtime config resolves correctly.

.. code-block:: bash

   git submodule update --init --recursive
   femic prep validate-case --run-config config/run_profile.k3z.yaml --tipsy-config-dir config/tipsy
   femic patchworks preflight --config config/patchworks.runtime.windows.yaml

Rebuild Workflow
----------------

.. code-block:: bash

   femic run --run-config config/run_profile.k3z.yaml --run-id k3z_full_rebuild
   femic patchworks build-blocks --config config/patchworks.runtime.windows.yaml
   femic patchworks matrix-build --config config/patchworks.runtime.windows.yaml --run-id k3z_full_rebuild

Diagnostics Workflow
--------------------

.. code-block:: bash

   femic run --run-config config/run_profile.k3z.yaml --run-id k3z_reprocheck
   femic patchworks matrix-build --config config/patchworks.runtime.windows.yaml --run-id k3z_reprocheck

Review:

- ``vdyp_io/logs/patchworks_matrixbuilder_manifest-<run_id>.json``

Troubleshooting Workflow
------------------------

1. Preflight failure: fix runtime paths/license prerequisites first.
2. Block join mismatch: rebuild blocks and rerun matrix builder.
3. Account anomalies: trace curves -> attributes/products -> accounts.

Release Checklist
-----------------

- Rebuild and matrix-build complete without hard errors.
- Invariant report passes baseline checks.
- Required docs pages and contract tests pass.
- Published docs navigation resolves and includes current pages.

Publication Checklist
---------------------

- Standalone docs build with warnings-as-errors:

  .. code-block:: bash

     python -m sphinx -b html docs docs/_build/html -W

- Parent docs contracts and full validation gates pass before release.
