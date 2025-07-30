module PING_PONG #(
    parameter dw = 56, // 28 bit real and 28 bit imaginary
    parameter buffer_depth = 1440,
    parameter Add_width = $clog2(buffer_depth)
)
    (
    input 											clk,
    input 											rst,
	  input 		                                  wr_select_line,
	  input		                                    rd_select_line,

    // input   logic                                   SOP, // indicates the start of packect
    input   logic [Add_width-1       :           0] wr_address,
    input   logic [dw-1              :           0] wr_data,
    input   logic                                   wr_en,

    output   logic [Add_width-1       :           0] rd_address,
    output  logic [dw-1              :           0] rd_data,
    input   logic                                   rd_en
);

logic wr_en_a,wr_en_b,rd_en_a,rd_en_b;
logic rd_en_reg;
logic [dw-1              :           0] rd_data_a,rd_data_b;
logic [Add_width-1       :           0] rd_address_a,rd_address_b;

always@(posedge clk) begin
    rd_en_reg <= rd_en;
end
assign wr_en_a = wr_en & !wr_select_line;
assign wr_en_b = wr_en & wr_select_line;
assign rd_en_a = rd_en & !rd_select_line;
assign rd_en_b = rd_en & rd_select_line;

// assign  rd_data = (rst || !rd_en) ? 'd0 : (rd_select_line ? rd_data_b : rd_data_a);
assign  rd_data = rst ? 'd0 : (rd_en_reg ? (rd_select_line ? rd_data_b : rd_data_a) : 'd0);
assign  rd_address = rst ? 'd0 : (rd_en_reg ? (rd_select_line ? rd_address_b : rd_address_a) : 'd0);


// Storing DATA A
Single_port_buffer #(.dw(dw), .buffer_depth(buffer_depth), .Add_width(Add_width) ) 
    DUT_A(
    .clk(clk),
    .rst(rst),
    .wr_address(wr_address),
    .wr_data(wr_data),
    .wr_en(wr_en_a),

    .rd_address(rd_address_a),
    .rd_data(rd_data_a),
    .rd_en(rd_en_a)
);

// Storing DATA B
Single_port_buffer #(.dw(dw), .buffer_depth(buffer_depth), .Add_width(Add_width) )
    DUT_B(
    .clk(clk),
    .rst(rst),
    .wr_address(wr_address),
    .wr_data(wr_data),
    .wr_en(wr_en_b),

    .rd_address(rd_address_b),
    .rd_data(rd_data_b),
    .rd_en(rd_en_b)
);

  
endmodule
