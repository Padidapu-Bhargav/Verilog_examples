module Memory_mapped_interface#(
    parameter ADDR_WIDTH = 10,
    parameter DATA_WIDTH = 32
)(
input                                   clk,
input                                   rst,

// WRITE ADDRESS PORTS
input   logic [ADDR_WIDTH-1     :0]     AW_ADDR,
input   logic [2                :0]     AW_PROT,
input   logic                           AW_VALID,
output  logic                           AW_READY,

// WRITE DATA PORTS
input   logic [DATA_WIDTH-1     :0]     W_DATA,
input   logic [(DATA_WIDTH/8)-1 :0]     W_STRB,
input   logic                           W_VALID,
output  logic                           W_READY,

// RESPONSE PORTS
output  logic [1                :0]     B_RESP,
output  logic                           B_valid,
input   logic                           B_ready,

// READ ADDRESS PORTS
input   logic [ADDR_WIDTH-1     :0]     AR_ADDR,
input   logic [2                :0]     AR_PROT,
input   logic                           AR_VALID,
output  logic                           AR_READY,

// READ DATA PORTS
output  logic [DATA_WIDTH-1     :0]     R_DATA,
output  logic [1                :0]     R_RESP,
output  logic                           R_VALID,
input   logic                           R_READY



);



//---------------------------
// WRITE ADDRESS CHANNEL
//---------------------------
logic [ADDR_WIDTH-1:0]     aw_addr_reg;
logic [2:0]                aw_prot_reg;
logic                      aw_valid_reg;


//---------------------------
// WRITE DATA CHANNEL
//---------------------------
logic [DATA_WIDTH-1:0]     w_data_reg;
logic [(DATA_WIDTH/8)-1:0] w_strb_reg;
logic                      w_valid_reg;




//======================================================================
// DUT: Dual Port RAM Instance
//======================================================================
ram_dual_port #(
    .DATA_WIDTH(DATA_WIDTH),   // Width of each memory word
    .ADDR_WIDTH(ADDR_WIDTH)    // Number of address bits => 1024-depth
) u_ram_dual_port (
    .clk        (clk),         // Clock input
    .rst        (rst),         // Reset input

    // Write port connections
    .we         (we),          // Write enable
    .write_addr (aw_addr_reg>>2),  // Write address
    .write_data (w_data_reg),  // Write data input

    // Read port connections
    .re         (re),          // Read enable
    .read_addr  (AR_ADDR>>2),   // Read address
    .read_data  (R_DATA)    // Read data output
);


// AXI-lite write FSM
enum logic [1:0] {
    WR_IDLE,
    WRITE,
    RESPONSE
}wr_state, wr_next ;

// write state FSM current state update
always@(posedge clk)begin
    if(rst) wr_state <= WR_IDLE;
    else wr_state <= wr_next;
end

always@(*) begin
    if(rst) wr_next = WR_IDLE;
    else begin
        case (wr_state)
            WR_IDLE: begin
                if(w_valid_reg && aw_valid_reg) wr_next = WRITE ;
                else wr_next = WR_IDLE;
            end
            WRITE: begin
                wr_next = RESPONSE;
            end
            RESPONSE: begin
                if(B_ready) wr_next = WR_IDLE;
                else wr_next = RESPONSE;
            end
        endcase

    end
end

// write channels output logic

always@(posedge clk)begin
    if(rst) begin
        w_valid_reg     <= 'd0;
        w_data_reg      <= 'd0;
        w_strb_reg      <= 'd0;

        aw_valid_reg    <= 'd0;
        aw_addr_reg     <= 'd0;
        aw_prot_reg     <= 'd0;

    end
    else begin
        case (wr_state)
            WR_IDLE: begin
                // register the write data channel signals
                w_valid_reg     <= (W_VALID & W_READY) ;
                w_data_reg      <= (W_VALID & W_READY) ? W_DATA : w_data_reg ;
                w_strb_reg      <= (W_VALID & W_READY) ? W_STRB : w_strb_reg ;
                
                // register the write address cahnnel signals
                aw_valid_reg    <= (AW_VALID & AW_READY) ;
                aw_addr_reg     <= (AW_VALID & AW_READY) ? AW_ADDR : aw_addr_reg;
                aw_prot_reg     <= (AW_VALID & AW_READY) ? AW_PROT : aw_prot_reg;

            end
            default : begin
                w_valid_reg     <= 'd0;
                w_data_reg      <= 'd0;
                w_strb_reg      <= 'd0;
                    
                aw_valid_reg    <= 'd0;
                aw_addr_reg     <= 'd0;
                aw_prot_reg     <= 'd0;
            end
        endcase       
    end
end
assign AW_READY = rst ? 0 :((wr_state == WR_IDLE) ? !aw_valid_reg : 0);
assign W_READY = rst ? 0 : ((wr_state == WR_IDLE) ? !w_valid_reg : 0);
assign B_RESP = rst ? 0 : 2'd00  ;
assign B_valid = rst ? 0 : ((wr_state == RESPONSE) ? 1 : 0);
assign we = rst ? 0 : ((wr_state == WRITE) ? 1 : 0);

//AXI-lite read FSM
enum logic  {
     RD_IDLE,
     READ
}rd_state, rd_next ;

// Read state FSM current state update
always@(posedge clk)begin
    if(rst) rd_state <= RD_IDLE;
    else rd_state <= rd_next;
end

always@(*) begin
    if(rst) rd_next = RD_IDLE;
    else begin
        case (rd_state)
            RD_IDLE: begin
                rd_next = AR_VALID ? READ : RD_IDLE ;
            end
            READ: begin
                rd_next = R_READY ? RD_IDLE : READ ;
            end
        endcase
        
    end
end

assign AR_READY = rst ? 0 : ( (rd_state == RD_IDLE) ? 1 : 0);
assign R_VALID = rst ? 0 : ((rd_state == READ) ? 1 : 0);
assign R_RESP = rst ? 0 : 2'd00  ;
assign re = rst ? 0 : ((rd_state == READ) ? 1 : 0);


endmodule