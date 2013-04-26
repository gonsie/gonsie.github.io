---
title: Parallel Circuit Simulation
category: notes
layout: notes
---

# Parallel Circuit Simulation

> Elsa Gonsiorowski <br />
> Rensselaer Polytechnic Institute

## Description

This work represents a more than 2 year effort between RPI and AFRL in investigating massively-parallel circuit simulation. 

## Links

### Main Project

- [`CODE:` ROSS/gates model](http://github.com/gonsie/gates)
- [`CODE:` Liberty and Gate Parser System](http://github.com/gonsie/gate-parser)
- [`CODE:` Additional Scripts](http://gonsie.com/gate_scripts/)
- [Paper for MASCOTS 2012](http://gonsie.com/mascots2012.pdf)

### Additional Resources

- [ROSS Documentation](odin.cs.rpi.edu)
- [OpenSPARC Project](opensparc.net)

## System Overview

### Source Code

- Verilog RTL processed into a netlist using Synopsys (or other synthesis tool)
- Liberty-format gate library

### Step 1: Parsing

- `ply_liberty` parse the liberty library. This step defines the some of the valid tokens for the netlist, as well as the format of all gate data. By defining the gate types, the 'factory' design pattern is used to fill in the data model. This piece of the system leverages the strength of the Java language with object oriented programs.
- `ply_verilog_netlist` parse the generated netlist file. This step builds the data model for the circuit. Each named wire and gate is connected, 
- `ply_bool_expr` parse boolean expressions (used during library parsing). This generates C-code from simple boolean expressions.

### Step 2: Data Generation

The parsing step creates a data model. This model must be unified between the library and netlist, as well as mapped to LPs in ROSS. Once the data model is created, there are several transformations performed before the ROSS/gates initialization file is generated. These transformations include:

- Various modules are linked together
- Unlinked input and output pins are defined as LPs (fake gates)
- Gates are mapped to LPs
- Wires identifiers are removed and gates are directly linked. Any branching wires are defined as an LP (fake gates)

### Step 3: Simulation

The ROSS/gates is built using a combination of CMake and a bash scripts. These scripts handle various architectures and ensure unified results files with full details about the run and configuration.

### Step 4: Results

- A single output file is generated for each run. This file includes details about the particular configuration, includeing specific run scripts.
- If the `-wave` option is used, a Value Change Dump file is generated for each MPI_task. This file can be merged into one (via a providede python script) and each VCD file can be visualized using GTKWave or similar software.

## Images

### Project Overview

![Project Overview](http://gonsie.com/images/overview.pdf)

### OpenSPARC T2 Processor

![OpenSPARC T2 Processor](http://gonsie.com/images/OpenSPARCT2.pdf)

## To Do

- full Liberty library parsing
- ModelSIM correctness comparison
- full processor simulation (clock?)
- valid instructions 
