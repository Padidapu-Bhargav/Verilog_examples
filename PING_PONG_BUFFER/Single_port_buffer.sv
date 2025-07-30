// working and invoking BRAMS
// 
module Single_port_buffer_rd_address #(
	
    parameter dw = 56, // 28 bit real and 28 bit imaginary
    parameter buffer_depth = 1440,
    parameter Add_width = $clog2(buffer_depth)
)
    (
    input 					       clk,
    input 					       rst,

    input   logic [Add_width-1       :           0] wr_address,
    input   logic [dw-1              :           0] wr_data,
    input   logic                                   wr_en,

    input   logic [Add_width-1       :           0] rd_address,
    output  logic [dw-1              :           0] rd_data,
    input   logic                                   rd_en
);

(* ramstyle = "M20K" *) logic [dw-1:0] bram [buffer_depth];


always_ff @( posedge clk  ) begin : write_data_logic
    // writing data
    if (wr_en) begin
        bram[wr_address]	<= wr_data;
    end
    // reading data
    if (rd_en) begin
	    rd_data 		<= bram[rd_address];
    end
end

endmodule


// working for output rd_Addres
module Single_port_buffer_rd_enable #(
	
    parameter dw = 56, // 28 bit real and 28 bit imaginary
    parameter buffer_depth = 1440,
    parameter Add_width = $clog2(buffer_depth)
)
    (
    input 											clk,
    input 											rst,

    input   logic [Add_width-1       :           0] wr_address,
    input   logic [dw-1              :           0] wr_data,
    input   logic                                   wr_en,

    output  logic [Add_width-1       :           0] rd_address,
    output  logic [dw-1              :           0] rd_data,
    input   logic                                   rd_en
);

   
(* ramstyle = "M20K" *) logic [dw-1:0] bram [buffer_depth];

// writing data
always_ff @( posedge clk  ) begin : write_data_logic
    if (wr_en) begin
        bram[wr_address]	<= wr_data;
    end
	 if(rd_en) rd_address <= rd_address + 1;
end

assign rd_data = bram[rd_address];

endmodule
