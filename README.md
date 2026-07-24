<div align="center">

# 1-to-64 Demultiplexer (DEMUX) - Complete RTL-to-GDSII ASIC Flow 🚀
### A Silicon Journey: From Behavioral Verilog to Sky130 Manufacturing-Ready Layout

[![OpenLane](https://img.shields.io/badge/OpenLane-Automated%20Flow-blue.svg)](https://github.com/The-OpenROAD-Project/OpenLane)
[![PDK](https://img.shields.io/badge/PDK-Sky130-red.svg)](https://github.com/google/skywater-pdk)
[![Language](https://img.shields.io/badge/Language-Verilog-blueviolet.svg)](#)
[![Status](https://img.shields.io/badge/Status-DRC%20%26%20LVS%20Clean-success.svg)](#)

*Documenting the complete physical design realization of a 1-to-64 Demultiplexer using the open-source OpenLane toolchain and SkyWater 130nm standard cell library.*

<img src="demux%20ss/klayout.png" alt="Final KLayout GDSII Layout" width="800px">

---

**[Explore the Visual Journey](#-the-rtl-to-gdsii-visual-journey) • [Reproduce the Flow](#-how-to-reproduce) • [Repository Structure](#-repository-structure)**

</div>

---

## 💡 Project Overview & Logic Architecture

A **1-to-64 Demultiplexer (DEMUX)** is a combinational circuit designed to route a single input signal ($D_{in}$) to one of 64 output lines ($Y_0$ to $Y_{63}$) based on the state of 6 select lines ($S[5:0]$). 

$$\text{Active Output } Y_k = D_{in} \quad \text{where } k = \sum_{i=0}^{5} S_i \cdot 2^i$$

Executing its physical implementation through an automated ASIC backend highlights key trade-offs in high-fanout signal distribution, routing density, and standard cell area optimization across 64 individual output channels.

---

## 🛠️ Tools & Technology Stack

| Flow Stage | Open-Source Tool / PDK | Function |
| :--- | :--- | :--- |
| **Process Node** | SkyWater 130nm (`sky130A`) | Target silicon manufacturing technology (`sky130_fd_sc_hd`) |
| **Functional Verification** | Icarus Verilog (`iverilog`) & GTKWave | RTL simulation and waveform debugging |
| **Logic Synthesis** | Yosys & abc | Gate-level netlist generation & tech-mapping |
| **Floorplan & Placement** | OpenROAD | Core/die initialization, PDN, and cell placement |
| **Clock Tree & Routing** | OpenROAD (TritonRoute) | Global and detailed interconnect routing |
| **Physical Verification** | Magic & Netgen | Signoff DRC checks and LVS netlist comparison |
| **GDSII Layout Viewer** | KLayout | Final layout viewer and stream file verification |

---

## 📖 The RTL-to-GDSII Visual Journey

Follow the automated physical design pipeline execution step-by-step with visual checkpoints from our runtime workspace:

### 1️⃣ RTL Design & Functional Verification
The behavioral logic of the 1-to-64 DEMUX was validated using a testbench. Waveform inspection in GTKWave confirms correct single-input routing to designated output channels driven by select control vectors.

<p align="center">
  <img src="demux%20ss/waveforms.png" width="90%" alt="GTKWave Verification Waveforms">
</p>

### 2️⃣ Logic Synthesis & Power Reports
The Verilog source description is synthesized into standard cells from the `sky130_fd_sc_hd` library. Area utilization and static/dynamic power reports are verified.

<p align="center">
  <img src="demux%20ss/area.png" width="48%" alt="Synthesis Area and Cell Report">
  <img src="demux%20ss/power.png" width="48%" alt="Power Consumption Summary">
</p>

### 3️⃣ Floorplanning & Power Delivery Network (PDN)
Core/die boundaries are established, power rings and vertical/horizontal power stripes (`VDD`/`GND`) are inserted, and I/O pins are placed along the periphery.

<p align="center">
  <img src="demux%20ss/floorning.png" width="80%" alt="OpenROAD Floorplan Window">
</p>

### 4️⃣ Global & Detailed Placement
Standard cells are legally placed into core rows, minimizing total wire length while satisfying cell density rules.

<p align="center">
  <img src="demux%20ss/placement.png" width="80%" alt="Global and Detailed Cell Placement">
</p>

### 5️⃣ Interconnect Routing
Signal interconnects are routed across multi-layer metal grids (`met1`–`met5`) using TritonRoute, preserving minimum manufacturing clearance rules.

<p align="center">
  <img src="demux%20ss/routing.png" width="80%" alt="Routed Netlist OpenROAD View">
</p>

### 6️⃣ Physical Signoff & Verification (DRC/LVS/Magic)
The finished layout was exported for signoff physical verification. Magic DRC confirms 0 violations and Netgen confirms LVS clean state.

<p align="center">
  <img src="demux%20ss/drc.png" width="48%" alt="DRC and LVS Summary">
  <img src="demux%20ss/magic.png" width="48%" alt="Magic Verification View">
</p>

---

## 📂 Repository Structure

```text
64-1-demux-from-RTL-to-GDSII-using-opensource-VLSI-to/
├── demux ss/               # Visual logs, simulation waveforms, and layout screenshots
│   ├── area.png
│   ├── drc.png
│   ├── floorning.png
│   ├── klayout.png
│   ├── magic.png
│   ├── placement.png
│   ├── power.png
│   ├── routing.png
│   └── waveforms.png
├── src/                    # Verilog source files and testbench
│   ├── demux.v
│   └── tb_demux.v
├── config.json             # OpenLane configurations
├── demux.gds               # Final exported binary stream file
└── README.md               # Project documentation
