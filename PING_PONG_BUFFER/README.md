# 🧠 PING_PONG & Single Port Buffer Modules (Verilog)

This repository contains a **modular RTL design** for implementing **ping-pong buffering** using **single-port block RAMs (M20Ks)** in Intel FPGA devices like Agilex, Stratix, etc.

It includes:

- ✅ Two flexible single-port RAM modules
- 🌀 A `PING_PONG` top-level controller to toggle between two buffers
- 🧩 Targeted for **efficient M20K usage** in **Intel Quartus**

---

## 📦 Module Overview

| Module Name                    | Description                                                                |
|--------------------------------|----------------------------------------------------------------------------|
| `PING_PONG`                    | Top-level buffer switcher using two `Single_port_buffer` RAMs              |
| `Single_port_buffer_rd_address`| Single-port RAM with external read address and enable control              |
| `Single_port_buffer_rd_enable` | Single-port RAM where read address auto-increments based on `rd_en`        |

---

## 🔄 What is Ping-Pong Buffering?

Ping-pong buffering is a **double-buffering technique** that allows one buffer to be **written to**, while the other is being **read from**, and vice versa. It eliminates read-write contention and ensures continuous data streaming.

### ✅ When to Use:
- In high-throughput systems like **FFT**, **DFT**, **OFDM modulation**
- For **streaming applications** where one packet is written while another is processed
- When the **write and read clocks are the same**

---

## 1️⃣ Top Module: `PING_PONG`

### 💡 Description

This module switches between **two single-port RAMs** (Buffer A and Buffer B) using select lines.

- `wr_select_line`: controls **which RAM receives writes**
- `rd_select_line`: controls **which RAM sends out data**
- RAMs are instantiated using `Single_port_buffer` (read-address based)

### 🔧 Parameters

| Parameter       | Description                       | Default           |
|----------------|-----------------------------------|-------------------|
| `dw`           | Data width                        | 56                |
| `buffer_depth` | Entries in each buffer            | 1440              |
| `Add_width`    | Address width (`$clog2(depth)`)   | `$clog2(1440)`    |

> 56 bits usually encode 28-bit real + 28-bit imaginary data.

---

### 🧩 Ports

| Port           | Dir   | Width        | Description                                    |
|----------------|-------|--------------|------------------------------------------------|
| `clk`          | In    | 1            | System clock                                   |
| `rst`          | In    | 1            | Reset signal                                   |
| `wr_select_line` | In  | 1            | Selects which buffer receives the write        |
| `rd_select_line` | In  | 1            | Selects which buffer outputs the data          |
| `wr_address`   | In    | `Add_width`  | Address for writing                            |
| `wr_data`      | In    | `dw`         | Input data                                     |
| `wr_en`        | In    | 1            | Write enable                                   |
| `rd_en`        | In    | 1            | Read enable                                    |
| `rd_data`      | Out   | `dw`         | Output read data                               |
| `rd_address`   | Out   | `Add_width`  | Output read address                            |

---

### 🔍 How It Works

```
- DUT_A and DUT_B are two RAM blocks (instantiated from Single_port_buffer)
- wr_select_line chooses which DUT gets write
- rd_select_line chooses which DUT sends data
- rd_data and rd_address are muxed between DUT_A and DUT_B based on rd_select_line
```

📌 **Internally uses `rd_en_reg` to delay data muxing by 1 cycle to match BRAM read latency**

---

### 🧠 Flexibility in RAM Design

You can choose which internal RAM to instantiate in PING_PONG:
- Use `Single_port_buffer_rd_address` if you want to **control read address externally**
- Use `Single_port_buffer_rd_enable` if you want **auto-incrementing read address**

Update instantiations as needed inside `PING_PONG`.

---


# 2. 💡 Module: `Single_port_buffer_rd_address`

### 🔹 Purpose

This module allows full control over **read and write addresses** externally. Suitable for designs where read logic is FSM-controlled.


## ⚒️ Parameters (Common to Both Modules)

| Name           | Description                            | Default        |
| -------------- | -------------------------------------- | -------------- |
| `dw`           | Data width per entry                   | 56             |
| `buffer_depth` | Total entries in the buffer            | 1440           |
| `Add_width`    | Address width (auto from buffer depth) | `$clog2(1440)` |

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

```verilog
(* ramstyle = "M20K" *) logic [dw-1:0] bram [buffer_depth];

always_ff @(posedge clk) begin
    if (wr_en) bram[wr_address] <= wr_data;
    if (rd_en) rd_data <= bram[rd_address]; // Synchronous read
end
```

### 🧠 Memory Inference
### 💡 Key Logic
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

# 3. 🌌 Module: `Single_port_buffer_rd_enable`

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

### 💡 Key Logic

```verilog
always_ff @(posedge clk) begin
    if (wr_en) bram[wr_address] <= wr_data;
    if (rd_en) rd_address <= rd_address + 1;
end

assign rd_data = bram[rd_address];
```

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


## 🧠 Quartus BRAM Inference

All modules use:

```verilog
(* ramstyle = "M20K" *) logic [dw-1:0] bram [buffer_depth];
```

This guarantees Quartus will map memory to **M20K block RAMs** instead of LUTs.

---


## 📄 License

MIT — Free to use, modify, and distribute.

---

## 🙋‍♂️ Author

**Bhargav Ram** — RTL Design Engineer

---


