
module ram_dual_port #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10    // 2^10 = 1024 words
)(
    input  logic                     clk,
    input  logic                     rst,
    
    // Write port
    input  logic                     we,
    input  logic [ADDR_WIDTH-1:0]    write_addr,
    input  logic [DATA_WIDTH-1:0]    write_data,

    // Read port
    input  logic                     re,
    input  logic [ADDR_WIDTH-1:0]    read_addr,
    output logic [DATA_WIDTH-1:0]    read_data

    // output logic [DATA_WIDTH-1      :0]     A_data,
    // output logic [1                 :0]     control,
    // output logic [DATA_WIDTH-1      :0]     B_data,

    // input logic [DATA_WIDTH-1       :0]     GCD_data
);
    localparam  DEPTH = ('d1<<ADDR_WIDTH);

    // memory array
    logic [DATA_WIDTH-1:0] mem [DEPTH -1 : 0];
    integer i;
    always@(*) begin

    end

    // WRITE
    always_ff @(posedge clk) begin
        if(rst) begin
            for(i = 0 ; i<DEPTH ; i = i+1) mem[i] = 'd0;
        end 
        else             mem[write_addr] <= we ?  write_data : mem[write_addr];
    end

    // READ
    always_ff @(posedge clk) begin
        if(rst) read_data <= 'd0 ;
        else  read_data <= re ? mem[read_addr] : read_data ;
    end


endmodule
