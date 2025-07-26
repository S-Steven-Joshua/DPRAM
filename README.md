# DPRAM

**Double-Port RAM (DPRAM)** – A hardware module supporting simultaneous read/write operations on two independent ports.  
Designed in [VHDL / Verilog] for FPGA or ASIC integration.

---


## Overview

DPRAM is a dual-port RAM block allowing concurrent access through two independent ports (A and B). Each port can perform read or write without interfering with the other, ideal for shared memory scenarios in FPGA designs.

---

## Features

- **Dual Ported**: Two independent ports with distinct clocks, addresses, data, and control lines  
- **Synchronous Operation**: Enables clocked read and write actions  
- **Configurable Size**: Easily adjustable data-width and depth  
- **VHDL / Verilog Implementation**: Easily modifiable codebase for synthesis  

---

## Pinout & Interface

| Port  | Signal        | Description                         |
|-------|---------------|-------------------------------------|
| A     | `clk_a`       | Clock for port A                    |
|       | `addr_a`      | Address input for port A            |
|       | `data_in_a`   | Input data to be written via port A |
|       | `we_a`        | Write enable for port A             |
|       | `re_a`        | Read enable for port A              |
|       | `data_out_a`  | Read data output from port A        |
| B     | `clk_b`       | Clock for port B                    |
|       | `addr_b`      | Address input for port B            |
|       | `data_in_b`   | Input data to be written via port B |
|       | `we_b`        | Write enable for port B             |
|       | `re_b`        | Read enable for port B              |
|       | `data_out_b`  | Read data output from port B        |



---

## Architecture

- Separate read/write logic per port  
- Dual-clock synchronizer if ports operate on different frequencies  
- Conflict management for simultaneous writes to the same address (if supported)  
- Parameterized memory depth and width  

---

## Getting Started

### Prerequisites

- FPGA toolchain (Xilinx, Intel/Altera, Lattice, etc.)  
- Simulator: ModelSim, GHDL, Vivado, QuestaSim  

### Installation


1. Clone the repository:  
   ```bash
   git clone https://github.com/S‑Steven‑Joshua/DPRAM.git
   cd DPRAM

   
