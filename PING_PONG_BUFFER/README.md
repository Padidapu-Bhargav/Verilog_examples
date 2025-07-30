# 📦 Single Port Buffer Module (Verilog)

This module implements a **synchronous single-port memory buffer** in Verilog, designed for efficient use of **M20K block RAMs** in Intel FPGAs (e.g., Agilex, Stratix, Cyclone) using Quartus.


## 🚀 Features
- Here we have two modules, which are similarity with different functionality ,
- **Single_port_buffer_rd_address** ==> this module gives a particular write address and a particular read_address and also enable
- **Single_port_buffer_rd_enable**  ==> this module gives a particular write address and gives rd_enable signal and based on this rd_address gets updated on its own and gives the data
- **Single-port RAM interface** with shared clock for read and write
- Supports configurable **data width** and **buffer depth**
- Implements **synchronous read and write**
- Instructs Quartus to **infer M20K BRAM blocks**
- Ideal for buffering real+imaginary data (e.g., DFT, OFDM, signal processing)

---

## 🛠️ Parameters

| Name           | Description                              | Default         |
|----------------|------------------------------------------|-----------------|
| `dw`           | Data width per entry                     | 56              |
| `buffer_depth` | Total entries in the buffer              | 1440            |
| `Add_width`    | Address width (auto from buffer depth)   | `$clog2(1440)`  |

> Typically, `dw = 56` is used for 28-bit real + 28-bit imaginary data.

---

## 🔌 Port Descriptions

| Port         | Direction | Width         | Description                                      |
|--------------|-----------|---------------|--------------------------------------------------|
| `clk`        | Input     | 1             | Clock for all synchronous operations             |
| `rst`        | Input     | 1             | Reset (not used in internal logic here)          |
| `wr_address` | Input     | `Add_width`   | Write address                                    |
| `wr_data`    | Input     | `dw`          | Write data                                       |
| `wr_en`      | Input     | 1             | Write enable                                     |
| `rd_address` | Input     | `Add_width`   | Read address                                     |
| `rd_en`      | Input     | 1             | Read enable                                      |
| `rd_data`    | Output    | `dw`          | Read data output (available 1 cycle after read)  |

---

## 🧠 Memory Implementation


This is the attribute used in QUARTUS to invoke BRAMS
This attribute instructs Quartus to infer M20K block RAMs, not LUT RAM.
(* ramstyle = "M20K" *) logic [dw-1:0] bram [buffer_depth];



🔄 Timing Behavior

  Both read and write are synchronous (clocked by clk)
  When rd_en and rd_address are asserted:
  The output rd_data will be valid after 1 clock cycle
  This latency is typical of true synchronous BRAM
