                                                              # 📦 Single Port Buffer Module (Verilog)
- **Single_port_buffer_rd_address** ==> this module gives a particular write address and a particular read_address and also enable
- **Single_port_buffer_rd_enable**  ==> this module gives a particular write address and gives rd_enable signal and based on this rd_address gets updated on its own and gives the data

This module implements a **synchronous single-port memory buffer** in Verilog, designed for efficient use of **M20K block RAMs** in Intel FPGAs (e.g., Agilex, Stratix, Cyclone) using Quartus.

---

## 🚀 Features

* Two variants of the single-port buffer are included:

  1. **`Single_port_buffer_rd_address`**  ➔ Explicit **read and write address control**
  2. **`Single_port_buffer_rd_enable`**   ➔ Read address increments **internally based on enable signal**

* Implements **single-port RAM interface**

* Supports configurable **data width** and **buffer depth**

* Targets **M20K BRAM** inference in Quartus

* Synchronous **read/write** design

* Ideal for buffering **real and imaginary** data pairs (e.g., OFDM, FFT, DFT)

---

## ⚒️ Parameters (Common to Both Modules)

| Name           | Description                            | Default        |
| -------------- | -------------------------------------- | -------------- |
| `dw`           | Data width per entry                   | 56             |
| `buffer_depth` | Total entries in the buffer            | 1440           |
| `Add_width`    | Address width (auto from buffer depth) | `$clog2(1440)` |

> Typically, `dw = 56` is used for 28-bit real + 28-bit imaginary data.

---

# 1. 💡 Module: `Single_port_buffer_rd_address`

### 🔹 Purpose

This module allows full control over **read and write addresses** externally. Suitable for designs where read logic is FSM-controlled.

### 🔌 Port Descriptions

| Port         | Direction | Width       | Description                                   |
| ------------ | --------- | ----------- | --------------------------------------------- |
| `clk`        | Input     | 1           | Clock for synchronous operations              |
| `rst`        | Input     | 1           | Reset (optional, no direct effect internally) |
| `wr_address` | Input     | `Add_width` | Write address                                 |
| `wr_data`    | Input     | `dw`        | Write data                                    |
| `wr_en`      | Input     | 1           | Write enable                                  |
| `rd_address` | Input     | `Add_width` | Read address                                  |
| `rd_en`      | Input     | 1           | Read enable                                   |
| `rd_data`    | Output    | `dw`        | Output data (valid 1 clock after read)        |

---

### 🧠 Memory Inference

```verilog
(* ramstyle = "M20K" *) logic [dw-1:0] bram [buffer_depth];
```

This instructs Quartus to use **M20K block RAMs** instead of LUT-based memory.

---

### ⏳ Timing Behavior

* Both read and write are **synchronous**
* On asserting `rd_en` with `rd_address`, data appears on `rd_data` **1 clock cycle later**
* This is typical for true synchronous BRAMs

---

# 2. 🌌 Module: `Single_port_buffer_rd_enable`

### 🔹 Purpose

In this variant, the **read address is internal** and updates automatically when `rd_en` is asserted. This is ideal for **streaming read** patterns.

### 🔌 Additional Port Change

## 🔌 Port Descriptions

| Port         | Direction | Width         | Description                                      |
|--------------|-----------|---------------|--------------------------------------------------|
| `clk`        | Input     | 1             | Clock for all synchronous operations             |
| `rst`        | Input     | 1             | Reset (not used in internal logic here)          |
| `wr_address` | Input     | `Add_width`   | Write address                                    |
| `wr_data`    | Input     | `dw`          | Write data                                       |
| `wr_en`      | Input     | 1             | Write enable                                     |
| `rd_address` | Output     | `Add_width`  | Address automatically incremented on `rd_en`                                      |
| `rd_en`      | Input     | 1             | Read enable                                      |
| `rd_data`    | Output    | `dw`          | Read data output (available 1 cycle after read)  |


---

### 🔄 Internal Read Address Update

```verilog
if (rd_en) rd_address <= rd_address + 1;
```

* Address increments only when `rd_en` is high
* You **do not control** `rd_address` externally

### 📊 Read Data

```verilog
assign rd_data = bram[rd_address];
```

* Combinational read using current `rd_address`
* No explicit read pipeline delay, but actual hardware may still infer latency (Quartus might insert a register)

---

## 📉 When to Use Which?

| Use Case                                 | Recommended Module              |
| ---------------------------------------- | ------------------------------- |
| Controlled read/write access (FSM/logic) | `Single_port_buffer_rd_address` |
| Streaming read with only enable required | `Single_port_buffer_rd_enable`  |

---

## 📄 Licensing

MIT License — free to use, modify, and distribute.

---

## 🌐 Author

**Designed by Bhargav Ram for RTL-based buffer control**

