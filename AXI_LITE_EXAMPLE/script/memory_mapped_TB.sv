`timescale 1ns/1ps

module tb_Memory_mapped_interface();

  // Parameters
  parameter ADDR_WIDTH = 10;
  parameter DATA_WIDTH = 32;

  // DUT Ports
  logic clk, rst;

  // Write address channel
  logic [ADDR_WIDTH-1:0] AW_ADDR;
  logic [2:0]            AW_PROT;
  logic                  AW_VALID;
  logic                  AW_READY;

  // Write data channel
  logic [DATA_WIDTH-1:0] W_DATA;
  logic [(DATA_WIDTH/8)-1:0] W_STRB;
  logic                  W_VALID;
  logic                  W_READY;

  // Write response channel
  logic [1:0]            B_RESP;
  logic                  B_valid;
  logic                  B_ready;

  // Read address channel
  logic [ADDR_WIDTH-1:0] AR_ADDR;
  logic [2:0]            AR_PROT;
  logic                  AR_VALID;
  logic                  AR_READY;

  // Read data channel
  logic [DATA_WIDTH-1:0] R_DATA;
  logic [1:0]            R_RESP;
  logic                  R_VALID;
  logic                  R_READY;


  // Clock generation
  always #5 clk = ~clk;

  // DUT instance
  Memory_mapped_interface #(
      .ADDR_WIDTH(ADDR_WIDTH),
      .DATA_WIDTH(DATA_WIDTH)
  ) DUT (
      .clk(clk),
      .rst(rst),

      // WRITE ADDRESS
      .AW_ADDR(AW_ADDR),
      .AW_PROT(AW_PROT),
      .AW_VALID(AW_VALID),
      .AW_READY(AW_READY),

      // WRITE DATA
      .W_DATA(W_DATA),
      .W_STRB(W_STRB),
      .W_VALID(W_VALID),
      .W_READY(W_READY),

      // WRITE RESPONSE
      .B_RESP(B_RESP),
      .B_valid(B_valid),
      .B_ready(B_ready),

      // READ ADDRESS
      .AR_ADDR(AR_ADDR),
      .AR_PROT(AR_PROT),
      .AR_VALID(AR_VALID),
      .AR_READY(AR_READY),

      // READ DATA
      .R_DATA(R_DATA),
      .R_RESP(R_RESP),
      .R_VALID(R_VALID),
      .R_READY(R_READY)
  );

  // Simple task to perform write
  task axi_write(input [9:0] addr, input [31:0] data);
    begin
      // Write Address Channel
      AW_ADDR  = addr;
      AW_PROT  = 3'b000;
      AW_VALID = 1'b1;

      // Write Data Channel
      W_DATA   = data;
      W_STRB   = 4'b1111;
      W_VALID  = 1'b1;

      B_ready  = 1'b1;

      // Wait for handshake
      wait (AW_READY && W_READY);
      @(posedge clk);
      AW_VALID = 0;
      W_VALID  = 0;

      // Wait for write response
      wait (B_valid);
      @(posedge clk);
      B_ready = 1'b0;

      $display("[%0t] WRITE Complete -> Addr: 0x%0h Data: 0x%0h", $time, addr, data);
    end
  endtask

  // Simple task to perform read
  task axi_read(input [9:0] addr);
    begin
      AR_ADDR  = addr;
      AR_PROT  = 3'b000;
      AR_VALID = 1'b1;
      R_READY  = 1'b1;

      // Wait for handshake
      wait (AR_READY);
      @(posedge clk);
      AR_VALID = 1'b0;

      // Wait for valid read data
      wait (R_VALID);
      @(posedge clk);
      $display("[%0t] READ Complete  -> Addr: 0x%0h Data: 0x%0h", $time, addr, R_DATA);
      R_READY = 1'b0;
    end
  endtask

  // Test sequence
  initial begin
    clk = 0;
    rst = 1;
    AW_ADDR = 0;
    AW_PROT = 0;
    AW_VALID = 0;
    W_DATA = 0;
    W_STRB = 0;
    W_VALID = 0;
    B_ready = 0;
    AR_ADDR = 0;
    AR_PROT = 0;
    AR_VALID = 0;
    R_READY = 0;

    // Reset sequence
    repeat (5) @(posedge clk);
    rst = 0;
    $display("[%0t] Reset De-asserted", $time);

      // Parallel read and write operation
    fork
        // ----------------------------
        // WRITE PROCESS
        // ----------------------------
        begin
            $display("[%0t] Starting parallel writes", $time);
            axi_write(10'h0004, 32'h4);
            axi_write(10'h0008, 32'h8);
            axi_write(10'h0012, 32'h12);
            axi_write(10'h0016, 32'h16);
            axi_write(10'h0020, 32'h20);
            axi_write(10'h0024, 32'h24);
            axi_write(10'h0028, 32'h28);
            axi_write(10'h0032, 32'h32);
            axi_write(10'h0036, 32'h36);
            axi_write(10'h0100, 32'h100);
            axi_write(10'h0200, 32'h200);
            $display("[%0t] All writes complete", $time);
        end

        // ----------------------------
        // READ PROCESS
        // ----------------------------
        begin
            repeat (30) @(posedge clk); // small delay to overlap writes and reads
            $display("[%0t] Starting parallel reads", $time);
            axi_read(10'h0004);
            axi_read(10'h0008);
            axi_read(10'h0012);
            axi_read(10'h0016);
            axi_read(10'h0020);
            axi_read(10'h0024);
            axi_read(10'h0028);
            axi_read(10'h0032);
            axi_read(10'h0036);
            axi_read(10'h0100);
            axi_read(10'h0200);
            $display("[%0t] All reads complete", $time);
        end
    join

    $display("[%0t] TEST COMPLETE", $time);
    repeat (8) @(posedge clk);$finish;
  end

endmodule
