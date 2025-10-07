`timescale 1ns/1ps

module GCD_TOP_TB;

    // Parameters
    localparam ADDR_WIDTH = 5;
    localparam DATA_WIDTH = 32;

    // Clock and reset
    logic clk;
    logic rst;

    // AXI4-Lite interface signals
    logic [ADDR_WIDTH-1:0] AW_ADDR;
    logic [2:0]            AW_PROT;
    logic                  AW_VALID;
    logic                  AW_READY;

    logic [DATA_WIDTH-1:0] W_DATA;
    logic [(DATA_WIDTH/8)-1:0] W_STRB;
    logic                  W_VALID;
    logic                  W_READY;

    logic [1:0] B_RESP;
    logic       B_valid;
    logic       B_ready;

    logic [ADDR_WIDTH-1:0] AR_ADDR;
    logic [2:0]            AR_PROT;
    logic                  AR_VALID;
    logic                  AR_READY;

    logic [DATA_WIDTH-1:0] R_DATA;
    logic [1:0] R_RESP;
    logic       R_VALID;
    logic       R_READY;

    // Instantiate DUT
    GCD_TOP GCD_TOP_DUT (
        .clk(clk),
        .rst(rst),
        .AW_ADDR(AW_ADDR),
        .AW_PROT(AW_PROT),
        .AW_VALID(AW_VALID),
        .AW_READY(AW_READY),

        .W_DATA(W_DATA),
        .W_STRB(W_STRB),
        .W_VALID(W_VALID),
        .W_READY(W_READY),

        .B_RESP(B_RESP),
        .B_valid(B_valid),
        .B_ready(B_ready),

        .AR_ADDR(AR_ADDR),
        .AR_PROT(AR_PROT),
        .AR_VALID(AR_VALID),
        .AR_READY(AR_READY),

        .R_DATA(R_DATA),
        .R_RESP(R_RESP),
        .R_VALID(R_VALID),
        .R_READY(R_READY)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz clock

    // Testbench tasks for AXI4-Lite write and read
    task axi_write(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data);
    begin
        // Write Address
        AW_ADDR  = addr;
        AW_PROT  = 3'd0;
        AW_VALID = 1;
        // Write Data
        W_DATA   = data;
        W_STRB   = 4'b1111;
        W_VALID  = 1;
        B_ready  = 1;
        wait (AW_READY && W_READY);
        @(posedge clk);
        AW_VALID = 0;
        W_VALID  = 0;
        wait (B_valid);
        @(posedge clk);
        B_ready = 0;
    end
    endtask

    task axi_read(input [ADDR_WIDTH-1:0] addr, output [DATA_WIDTH-1:0] data);
    begin
        AR_ADDR  = addr;
        AR_PROT  = 3'd0;
        AR_VALID = 1;
        R_READY  = 1;
        wait (AR_READY);
        @(posedge clk);
        AR_VALID = 0;
        wait (R_VALID);
        @(posedge clk);
        data = R_DATA;
        R_READY = 0;
    end
    endtask

    // Test sequence
    initial begin


        // -----------------------
        // Declarations first
        // -----------------------
        static int unsigned A_values[4] = '{36, 24, 15, 81};
        static int unsigned B_values[4] = '{60, 18, 10, 27};
        int unsigned i;
        logic [31:0] control_val;
        logic [31:0] gcd_result;

        rst = 1; AW_VALID = 0; W_VALID = 0; AR_VALID = 0; R_READY = 0; B_ready = 0;
        repeat(5) @(posedge clk);
        rst = 0;

        for (i = 0; i < 4; i++) begin
            // Write operands
            axi_write(10'd4, A_values[i]);
            axi_write(10'd8, B_values[i]);

            // Start GCD
            axi_write(10'd0, 32'd1); // updating the control register to 2

            // checking for CONTROL register until done (CONTROL = 2)
            control_val = 0;
            do begin
                axi_read(10'd0, control_val);
                @(posedge clk);
            end while (control_val != 2);

            // Read GCD result
            axi_read(10'd12, gcd_result);
            $display("[%0t] GCD of %0d and %0d = %0d", $time, A_values[i], B_values[i], gcd_result);

            // Wait a few cycles before next example
            repeat (5) @(posedge clk);
        end

        $display("[%0t] TEST COMPLETE", $time);

        repeat (5) @(posedge clk);
        $finish;
    end

endmodule
