# Using Cadence Innovus

This document contains the following guides:

- Launching the Innovus GUI
- Viewing a design in Innovus
- Finding Innovus Commands

## Launching the Innovus GUI

**To launch the Innovus GUI:**
1. SSH into the Linux server.

    **Important:** Since you are launching a GUI, you _must_ be using a remote terminal emulator with X11 forwarding, like FastX or MobaXterm.
2. `cd` into a design directory. For the onboarding project, you'll want to `cd` into `Physical-Design-Onboarding-Project/RTL2GDS/design/`.

3. Enter the C shell by running `tcsh`.
4. Run `source envsetup` to set up the environment variables necessary to use Cadence tools.
5. Run `innovus -legacy_ui` to launch the Innovus GUI.

> **Note:** There are two versions of Innovus — the legacy version, and Stylus. Most industry flows use the legacy version, and so do we. This is why we pass the flag `-legacy_ui` when we launch Innovus (the same flag the flow uses in `scripts/SJapr`). This distinction is important, since the CLI commands for the legacy and Stylus versions are different.

## Viewing a Design in Innovus

> **Important:** Before you open a design, you need to **[run the flow](Running-the-Flowtool.md)**. The flow generates the output files required to open your design in Innovus.
>
> The design files are stored in the `dbs/` directory after the flow is run. 

There are three ways to open a design in Innovus:
- With the command line
- As a launch flag
- With the GUI



**To open a design with the command line:**

1. [Launch the Innovus GUI](#launching-the-innovus-gui).

2. In the terminal where you ran `innovus -legacy_ui`, run the following command:
```bash
restoreDesign <path-to-db-folder>/<design-step-output>.enc.dat <top-module-name>
```
Where `<design-step-output>.enc.dat` is the directory written by `saveDesign`, and `<top-module-name>` is the name of your top-level design.

For example:
```bash
innovus 1> pwd
/nethome/user/Physical-Design-Onboarding-Project/RTL2GDS/design
innovus 2> restoreDesign dbs/postroute.enc.dat <top-module-name>
``` 
This will open the design output by the postroute step of the flow.

We can also view the design at other stages of the flow, with, for example, `floorplan.enc.dat`.

**To open a design as a launch parameter:**

We can open Innovus with a design preloaded. To do this, [launch the Innovus GUI](#launching-the-innovus-gui), but instead of using `innovus -legacy_ui`, use `innovus -legacy_ui -init <path-to-db-folder>/<design-step-output>.enc`.

Where `<design-step-output>.enc` is the restore script written by `saveDesign` alongside the `.enc.dat` directory.

For example:

```bash
user@rschsrv> pwd
/nethome/user/Physical-Design-Onboarding-Project/RTL2GDS/design
user@rschsrv> innovus -legacy_ui -init dbs/postroute.enc
``` 

This will open the design output by the postroute step of the flow.

We can also view the design at other stages of the flow, with, for example, `floorplan.enc.dat`.

**To open a design with the GUI:**

Don't open a design with the GUI. Be Based and use the CLI

## Finding Innovus Commands

Innovus has ~1500 possible commands. 

You can find commands and their associated documentation by searching relevant keywords on the [Cadence Support website](https://support.cadence.com) or by <mark>[Launching Innovus](#launching-the-innovus-gui), then running `help *keyword*` on the Innovus command line.</mark> (This is the fastest way to find relevant commands.)

For example, running `help *macro*` will output all the manual entries containing the term 'macro'.
