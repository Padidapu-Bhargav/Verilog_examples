**Module**: Single_port_buffer_rd_enable
**Description**
Single_port_buffer_rd_enable is a single-port RAM buffer with automatic, sequential read-out. The read address (rd_address) increments whenever rd_en is asserted, providing a simple FIFO-like read mechanism. Read data is available immediately as a combinational output from the buffer.

**Ports**
Name	Direction	Width	Description
clk	  input	    1    	Clock
rst	input	1	Synchronous reset (unused in code)
wr_address	input	Add_width	Write address
wr_data	input	dw	Data to be written
wr_en	input	1	Write enable
rd_address	output	Add_width	Current read address pointer (output)
rd_data	output	dw	Data read from buffer
rd_en	input	1	Read enable; increments read address
Parameters
dw (default: 56): Data width (bits).

buffer_depth (default: 1440): Buffer depth (number of elements).

Add_width (default: calculated): Address width according to buffer depth.

Functionality
Write operation:
On rising clock edge, if wr_en is high, writes wr_data to wr_address.

Read address:
On each rising clock, if rd_en is high, increments rd_address by 1.

Read data:
At all times, rd_data reflects the value at the current rd_address (combinational output). No output register; data changes immediately with new address.

Note:

The rd_address is an output and internally updated; the user cannot set the read address directly.

There is no reset logic in the module for rd_address. On simulation, it may be undefined unless initialized externally.

Memory Mapping
Single-port block RAM (bram).

Inferred as M20K RAM blocks for Intel/Altera FPGAs (see synthesis attribute).

Example Instantiation
verilog
Single_port_buffer_rd_enable #(
    .dw(56),
    .buffer_depth(1440)
) my_buffer (
    .clk(clk),
    .rst(rst),
    .wr_address(wr_addr),
    .wr_data(wr_data),
    .wr_en(wr_en),
    .rd_address(rd_addr),
    .rd_data(rd_data),
    .rd_en(rd_en)
);
