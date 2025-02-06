`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT hyd
// Engineer: Bhargav
// 
// Create Date: 06.02.2025 11:04:17
// Design Name: 
// Module Name: counter
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


module counter(
    input clk,
    input rst,
    
    output reg [2:0]count
    );

reg dir;

always @(posedge clk) begin
        if (rst) begin
            count <= 3'd0;
            dir <= 1'b1;   
        end else begin
            if (dir) begin
                if (count < 3'd5)
                    count <= count + 1;
                else
                    dir <= 1'b0; 
            end else begin
                if (count > 3'd0)
                    count <= count - 1;
                else
                    dir <= 1'b1; 
            end
        end
    end

 
    
endmodule
