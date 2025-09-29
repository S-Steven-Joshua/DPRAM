# DPRAM

**Double-Port RAM (DPRAM)** – A hardware module supporting simultaneous read/write operations on two independent ports.  
Designed in [VHDL / Verilog] for FPGA or ASIC integration.

---


## Overview

DPRAM is a dual-port RAM block allowing concurrent access through two independent ports (A and B). Each port can perform read or write without interfering with the other, ideal for shared memory scenarios in FPGA designs.

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


---

## 🚀 Features

- Synchronous Dual-Port RAM
- Independent read/write ports
- Address decoding logic
- Collision detection using comparator
- Verilog HDL implementation
- Testbench with various test cases

---

## 🧠 Modules Overview

### 1. `dpram.v`
- Core module implementing the DPRAM logic.
- Supports two ports with separate address, data, and control lines.

### 2. `comparator.v`
- Checks if both ports are accessing the same memory location simultaneously.
- Can be used to detect and prevent write collisions.

### 3. `decoder.v`
- Decodes address inputs into select lines for memory access.

---

## 🧪 Testbench (`dpram_tb.v`)
- Simulates read and write operations.
- Checks for data consistency.
- Includes corner cases such as simultaneous writes to the same address.

#





   
