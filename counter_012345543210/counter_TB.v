`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2025 11:04:35
// Design Name: 
// Module Name: counter_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter_TB();

reg clk;
reg rst;

wire [2:0]count;


counter DUT (.clk(clk),.rst(rst),.count(count));

initial begin
    clk=1'b0;
    forever #10 clk = ~clk;
end

initial begin
    rst = 1'b1;
    repeat(3) @(posedge clk);
    rst =1'b0;
end


endmodule
