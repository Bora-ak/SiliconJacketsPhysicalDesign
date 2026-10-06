# Running the Flowtool (SJapr)

- [Running the Flow](#running-the-flow)
- [Interactive Mode](#interactive-mode)
- [Changing Flow Parameters](#changing-flow-parameters)
- [Cleaning Up and Archiving](#cleaning-up-and-archiving)

## Running the Flow

> **Note:** You _must_ be on an ECE Linux server. Otherwise you won't have access to the Cadence/Synopsys tools.

1. Clone the repo (with submodules) and enter it:

    ```bash
    git clone --recurse-submodules git@github.gatech.edu:SiliconJackets/physical-design-onboarding-F26
    cd physical-design-onboarding-F26
    ```

2. Enter the C shell: `tcsh`
3. Set up the environment: `source envsetup`

    This adds `SJapr` to your `$PATH` and loads the Cadence and Synopsys tools. *Run this every time you open a new shell*.

4. Run the flow:

    ```bash
    SJapr syn     # synthesis only (Synopsys Design Compiler)
    SJapr apr     # place & route only (Cadence Innovus)
    SJapr flow    # synthesis, then place & route
    ```
    `apr` needs the output of a previous `syn`, so run `syn` first (or use `flow`).

### Outputs

| Location | Contents |
| --- | --- |
| `outputs/synthesis/` | Synthesis results, plus `DBS/`, `RPT/`, `LOG/` |
| `outputs/apr/` | P&R results, plus `DBS/`, `RPT/`, `LOG/` |

Re-running a stage doesn't overwrite the old results. The previous directory is renamed to `<dir>_<MMDD>_<HHMM>`.

> **IMPORTANT:** The flow can take a while, potentially longer than an hour. Start early in case the servers go down!

## Interactive Mode

Add `-i` (or `--interactive`) to run one step at a time. The tool queues the steps and stays at its prompt:

```bash
SJapr apr -i
```

| Command | Description |
| --- | --- |
| `sj_next_step` | Run the next queued step |
| `sj_run_remaining` | Run all remaining steps, stopping at the first failure |
| `sj_skip_step` | Drop the next step without running it |
| `sj_list_steps` | Show the remaining queue |

## Changing Flow Parameters

Most parameters are in `scripts/config.tcl`:

| Variable | Meaning |
| --- | --- |
| `DESIGN` | Top-level module name |
| `CLOCK_PERIOD` | Clock period in ns |
| `RTL_SEARCH_SUBDIRS` | Folders (relative to the repo root) searched for RTL |
| `LIBRARY`, `READ`, ..., `DUMP` | `1`/`0` toggles for synthesis stages |
| `INIT`, `FLOORPLAN`, `PLACE`, `CTS`, `ROUTE`, `SIGNOFF` | `1`/`0` toggles for P&R stages |

For finer control, edit the step scripts:

- Synthesis: `scripts/synthesis/steps/step_*.tcl`
- P&R: `scripts/apr/steps/step_*.tcl`

## Cleaning Up and Archiving

The Makefile provides a few targets you might find useful.

Run these from the repo root:

| Command | Description |
| --- | --- |
| `make tidy` | Preview the files `make clean` would delete |
| `make clean` | Delete everything that isn't a default repo file (including `outputs/`) |
| `make archive NAME=<name>` | Copy flow outputs to `archives/<name>/` |
| `make restore NAME=<name>` | Run `clean`, then restore an archive |
| `make purge` | Delete all archives |
