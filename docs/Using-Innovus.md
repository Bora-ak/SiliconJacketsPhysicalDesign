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
5. Run `innovus -stylus` to launch the Innovus GUI.

> **Note:** There are two versions of Innovus — the legacy version, and Stylus. Most industry flows use the legacy version, but we use Stylus, the newer version. This is why we pass the flag `-stylus` when we launch Innovus. This distinction is important, since the CLI commands for the legacy and Stylus versions are different.

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

2. In the terminal where you ran `innovus -stylus`, run the following command:
```bash
read_db <path-to-db-folder>/<design-step-output>
```
Where `<design-step-output>` is a `.enc`, `.cdb`, or `.db` directory.

For example:
```bash
@innovus 1> pwd
/nethome/user/Physical-Design-Onboarding-Project/RTL2GDS/design
@innovus 2> read_db dbs/postroute.enc
``` 
This will open the design output by the postroute step of the flow.

We can also view the design at other stages of the flow, with, for example, `floorplan.enc` or `syn_opt.cdb`.

**To open a design as a launch paramter:**

We can open Innovus with a design preloaded. To do this, [launch the Innovus GUI](#launching-the-innovus-gui), but instead of using `innovus -stylus`, use `innovus -stylus -db <path-to-db-folder>/<design-step-output>`.

Where `<design-step-output>` is a `.enc`, `.cdb`, or `.db` directory.

For example:

```bash
user@linlab> pwd
/nethome/user/Physical-Design-Onboarding-Project/RTL2GDS/design
user@linlab> innovus -stylus -db dbs/postroute.enc
``` 

This will open the design output by the postroute step of the flow.

We can also view the design at other stages of the flow, with, for example, `floorplan.enc` or `syn_opt.cdb`.

**To open a design with the GUI:**

Don't open a design with the GUI. Be Based and use the CLI

## Finding Innovus Commands

Innovus has ~1500 possible commands. 

You can find commands and their associated documentation by searching relevant keywords on the [Cadence Support website](https://support.cadence.com) or by <mark>[Launching Innovus](#launching-the-innovus-gui), then running `help *keyword*` on the Innovus command line.</mark> (This is the fastest way to find relevant commands.)

For example, running `help *macro*` will output all the manual entries containing the term 'macro'.
