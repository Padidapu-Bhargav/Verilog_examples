module GCD_AXI_TB;
    localparam DW = 32;

    logic clk, rst;
    logic [DW-1:0] A_data, B_data;
    logic A_valid, B_valid;
    logic A_ready, B_ready;
    logic [DW-1:0] GCD_data;
    logic GCD_valid;
    logic GCD_ready;

    GCD #(.DW(DW)) dut (
        .clk(clk),
        .rst(rst),
        .A_data(A_data), .A_valid(A_valid), .A_ready(A_ready),
        .B_data(B_data), .B_valid(B_valid), .B_ready(B_ready),
        .GCD_data(GCD_data), .GCD_valid(GCD_valid), .GCD_ready(GCD_ready)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        rst = 1;
        A_data = 0;
        B_data = 0;
        A_valid = 0;
        B_valid = 0;
        GCD_ready = 0;
        @(posedge clk);
        rst = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Test #1: 48, 18 => GCD = 6
        A_data = 48;
        B_data = 18;
        A_valid = 1;
        B_valid = 1;
        @(posedge clk);
        wait(A_ready||B_ready);
            if(A_ready) begin
                wait(B_ready);
                A_valid = 0;
            end
            else if(B_ready) begin
                 wait(A_ready);
                 B_valid = 0;
            end
        B_valid = 0;
        A_valid = 0;

        wait(GCD_valid);
        GCD_ready = 1;
        @(posedge clk);
        $display("1. GCD(48,18) = %0d (expected 6)", GCD_data);
        GCD_ready = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Test #2: 105, 91 => GCD = 7
        A_data = 105;
        B_data = 91;
        A_valid = 1;
        B_valid = 1;
        @(posedge clk);
        wait(A_ready||B_ready);
            if(A_ready) begin
                wait(B_ready);
                A_valid = 0;
            end
            else if(B_ready) begin
                 wait(A_ready);
                 B_valid = 0;
            end
        B_valid = 0;
        A_valid = 0;

        wait(GCD_valid);
        GCD_ready = 1;
        @(posedge clk);
        $display("2. GCD(105,91) = %0d (expected 7)", GCD_data);
        GCD_ready = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);


        // Test #3: 105, 91 => GCD = 7 delayed GCD_ready
        A_data = 17;
        B_data = 13;
        A_valid = 1;
        B_valid = 1;
        @(posedge clk);
        wait(A_ready||B_ready);
            if(A_ready) begin
                wait(B_ready);
                A_valid = 0;
            end
            else if(B_ready) begin
                 wait(A_ready);
                 B_valid = 0;
            end
        B_valid = 0;
        A_valid = 0;

        wait(GCD_valid);
        repeat(4)@(posedge clk);
        GCD_ready = 1;
        $display("3. GCD(17,13) = %0d (expected 1)", GCD_data);
        @(posedge clk);
        GCD_ready = 0;

        // Test #4: 105, 91 => GCD = 7 delayed A_valid
        B_data = 25;
        B_valid = 1;
        @(posedge clk);
        wait(A_ready||B_ready);
            if(A_ready) begin
                A_valid = 0;
                repeat(4) @(posedge clk);
                B_data = 25;
                B_valid = 1;
                @(posedge clk);
                wait(B_ready);

            end
            if(B_ready) begin
                B_valid = 0;
                repeat(4) @(posedge clk);
                A_data = 100;
                A_valid = 1;
                @(posedge clk);
                wait(A_ready);
                 
            end

        wait(GCD_valid);
        GCD_ready = 1;
        $display("4. GCD(100,25) = %0d (expected 25)", GCD_data);
        @(posedge clk);
        GCD_ready = 0;

        // Test #5: 105, 91 => GCD = 7 delayed B_valid
        A_data = 0;
        A_valid = 1;
        @(posedge clk);
        wait(A_ready||B_ready);
            if(A_ready) begin
                A_valid = 0;
                repeat(4) @(posedge clk);
                B_data = 5;
                B_valid = 1;
                @(posedge clk);
                wait(B_ready);

            end
            if(B_ready) begin
                B_valid = 0;
                repeat(4) @(posedge clk);
                A_data = 0;
                A_valid = 1;
                @(posedge clk);
                wait(A_ready);
                 
            end
        B_valid = 0;
        A_valid = 0;

        wait(GCD_valid);
        GCD_ready = 1;
        $display("5. GCD(0,5) = %0d (expected 5)", GCD_data);
        @(posedge clk);
        GCD_ready = 0;
        repeat(20) @(posedge clk);





        $stop;
    end
endmodule
