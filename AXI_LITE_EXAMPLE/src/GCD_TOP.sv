//-------------------------------------------------------------
// Address Mapping (AXI4-Lite Memory-Mapped Registers)
//-------------------------------------------------------------
// 0x00 : CONTROL Register  
//        [0] -> Start bit (Write '1' to start GCD computation)
//        [1] -> Done bit  (Set to '1' by hardware when GCD is ready)
//
// 0x04 : A Register (Operand A)  
//        Write operand A data here before starting computation
//
// 0x08 : B Register (Operand B)  
//        Write operand B data here before starting computation
//
// 0x0C : GCD Result Register (Read Only)  
//        Read the computed GCD result from this location
//
// Note:
// - CONTROL[0] = 1 → FSM moves from IDLE → READ and reads A & B.
//-------------------------------------------------------------


module GCD_TOP#(
    parameter ADDR_WIDTH = 5,
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
// =====================================================
// Localparams: Memory-Mapped Register Address Map
// =====================================================

// Control Register (Start / Done / Status flags)
localparam logic [9:0] CONTROL_ADDR = 10'd0;      // 0x0000_0000
// Operand A Register
localparam logic [9:0] A_ADDR       = 10'd4;      // 0x0000_0004
// Operand B Register
localparam logic [9:0] B_ADDR       = 10'd8;      // 0x0000_0008
// GCD Result Register
localparam logic [9:0] GCD_ADDR     = 10'd12;     // 0x0000_000C

logic                           B_ready_reg;
//---------------------------
// WRITE ADDRESS CHANNEL
//---------------------------
logic [ADDR_WIDTH-1:0]     AW_ADDR_reg;
logic [2:0]                AW_PROT_reg;
logic                      AW_VALID_reg;
//---------------------------
// WRITE DATA CHANNEL
//---------------------------
logic [DATA_WIDTH-1:0]     W_DATA_reg;
logic [(DATA_WIDTH/8)-1:0] W_STRB_reg;
logic                      W_VALID_reg;

// READ ADDRESS PORTS
logic [ADDR_WIDTH-1     :0]     AR_ADDR_reg;
logic [2                :0]     AR_PROT_reg;
logic                           AR_VALID_reg;
logic                           AR_READY_reg;

// READ DATA PORTS
logic [DATA_WIDTH-1     :0]     R_DATA_reg;
logic [1                :0]     R_RESP_reg;
logic                           R_VALID_reg;
logic                           R_READY_reg;

//-----------------------------------------------------
// Internal Signals for GCD Core Connections
//-----------------------------------------------------
logic [DATA_WIDTH-1:0] GCD_A_data;       // Operand A input data
logic                  GCD_A_valid;      // Operand A valid signal
logic                  GCD_A_ready;      // Operand A ready handshake

logic [DATA_WIDTH-1:0] GCD_B_data;       // Operand B input data
logic                  GCD_B_valid ;      // Operand B valid signal
logic                  GCD_B_ready;      // Operand B ready handshake

logic [DATA_WIDTH-1:0] GCD_data;     // GCD result output data
logic                  GCD_valid;    // GCD result valid signal
logic                  GCD_ready;    // GCD result ready handshake


//===================================================
//  GCD Core Instantiation
//===================================================
GCD #(
    .DW(DATA_WIDTH)
) GCD_DUT (
    .clk        (clk),
    .rst        (rst),
    .A_data     (GCD_A_data),
    .A_valid    (GCD_A_valid),
    .A_ready    (GCD_A_ready),

    .B_data     (GCD_B_data),
    .B_valid    (GCD_B_valid ),
    .B_ready    (GCD_B_ready),

    .GCD_data   (GCD_data),
    .GCD_valid  (GCD_valid),
    .GCD_ready  (GCD_ready)
);

// this tores the data in the RAM and then gives the respective output
Memory_mapped_interface #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
) MMI_DUT (
    .clk        (clk),
    .rst        (rst),

    // WRITE ADDRESS PORTS
    .AW_ADDR    (AW_ADDR_reg),
    .AW_PROT    (AW_PROT_reg),
    .AW_VALID   (AW_VALID_reg),
    .AW_READY   (AW_READY),

    // WRITE DATA PORTS
    .W_DATA     (W_DATA_reg),
    .W_STRB     (W_STRB_reg),
    .W_VALID    (W_VALID_reg),
    .W_READY    (W_READY),

    // RESPONSE PORTS
    .B_RESP     (B_RESP),
    .B_valid    (B_valid),
    .B_ready    (B_ready_reg),

    // READ ADDRESS PORTS
    .AR_ADDR    (AR_ADDR_reg),
    .AR_PROT    (AR_PROT_reg),
    .AR_VALID   (AR_VALID_reg),
    .AR_READY   (AR_READY_reg),

    // READ DATA PORTS
    .R_DATA     (R_DATA_reg),
    .R_RESP     (R_RESP_reg),
    .R_VALID    (R_VALID_reg),
    .R_READY    (R_READY_reg)
);


enum logic [2:0]  {
     IDLE,
     READ_A,
     READ_B,
     WRITE,
     DONE
}GCD_state, GCD_next ;

always@(posedge clk) begin
    if(rst) GCD_state <= IDLE;
    else GCD_state <= GCD_next;
end

always@(*)begin
    case(GCD_state)
        IDLE:begin 
            if(R_VALID_reg && R_READY_reg && (R_DATA_reg[0]==1) ) GCD_next = READ_A;
            else GCD_next = IDLE;
        end
        READ_A:begin
            if(R_VALID_reg && R_READY_reg ) GCD_next = READ_B;
            else GCD_next = READ_A;
        end
        READ_B:begin
            if(R_VALID_reg && R_READY_reg && (R_DATA_reg[0]==1) ) GCD_next = WRITE;
            else GCD_next = READ_B;
        end
        WRITE:begin
            if(B_valid && B_ready_reg) GCD_next = DONE;
            else GCD_next = WRITE;
        end
        DONE: begin
             if(B_valid && B_ready_reg) GCD_next = IDLE;
            else GCD_next = DONE;
        end
    endcase
end

always@(posedge clk)begin
    if(rst) begin
        AR_ADDR_reg <= 'd0;
        AR_PROT_reg <= 'd0 ;
        AR_VALID_reg <= 'd0;
        GCD_A_data      <= 'd0;
        GCD_A_valid <= 0;
        GCD_B_data      <= 'd0;
        AW_ADDR_reg <= 'd0;
        AW_PROT_reg <= 'd0;
        AW_VALID_reg <= 'd0;
        W_DATA_reg <='d0;
        W_STRB_reg  <= 'd0;
        W_VALID_reg <= 'd0;
        B_ready_reg <= 0;

    end
    else begin
        case(GCD_state)
            IDLE:begin 
                B_ready_reg <= B_ready;
                GCD_A_data      <= 'd0;
                GCD_A_valid     <= 0;
                GCD_B_data      <= 'd0;
                GCD_B_valid <= 'd0;
                AW_ADDR_reg <= AW_ADDR;
                AW_PROT_reg  <= AW_PROT;
                AW_VALID_reg <= AW_VALID;
                W_DATA_reg   <= W_DATA;
                W_STRB_reg  <= W_STRB;
                W_VALID_reg <= W_VALID;

                AR_ADDR_reg <= AR_VALID_reg && AR_READY_reg ? CONTROL_ADDR : AR_ADDR_reg;
                AR_PROT_reg <= 'd0 ;
                AR_VALID_reg <= 1;
            end
            READ_A:begin
                GCD_A_data <= R_VALID_reg && R_READY_reg && GCD_A_valid && GCD_A_ready ? R_DATA_reg : GCD_A_data;
                GCD_A_valid <= 1;
                AR_ADDR_reg <= AR_VALID_reg && AR_READY_reg ? A_ADDR : AR_ADDR_reg;
                AR_PROT_reg <= 'd0 ;
                AR_VALID_reg <= 1;
            end
            READ_B:begin
                GCD_A_valid <= 0;
                GCD_B_data <= R_VALID_reg && R_READY_reg && GCD_B_valid && GCD_B_ready  ? R_DATA_reg : GCD_B_data;
                AR_ADDR_reg <= AR_VALID_reg && AR_READY_reg ?  B_ADDR : AR_ADDR_reg;
                AR_PROT_reg <= 'd0 ;
                AR_VALID_reg <= 1;            
            end
            WRITE:begin
                AR_VALID_reg <= 0;

                B_ready_reg <= 1;
                AW_ADDR_reg <= AW_VALID_reg && AW_READY ? GCD_ADDR :AW_ADDR_reg;
                AW_PROT_reg <= 'd0;
                AW_VALID_reg <= 'd1;
                W_DATA_reg <= W_VALID_reg && W_READY && GCD_valid && GCD_ready ? GCD_data : W_DATA_reg;
                W_STRB_reg  <= 4'b1111;
                W_VALID_reg <= 'd1;

            end
            DONE: begin
                B_ready_reg <= 1;
                AW_ADDR_reg <= AR_VALID_reg && AR_READY_reg ? CONTROL_ADDR : AR_ADDR_reg;
                AW_PROT_reg <= 'd0;
                AW_VALID_reg <= 'd1;
                W_DATA_reg <= W_VALID_reg && W_READY ? 'd2 : W_DATA_reg;
                W_STRB_reg  <= 4'b1111;
                W_VALID_reg <= 'd1;
            end
        endcase
    end

end


endmodule