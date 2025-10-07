/*/////////////////////////////////////////////////////////////////////////////
GCD Verilog Module

Author: PADIDAPU BHARGAV RAM

Description:
This module calculates the Greatest Common Divisor (GCD) of two 
input numbers A_data and B_data using the Euclidean Algorithm. 
It is designed as a synchronous finite state machine (FSM) with 
valid-ready handshake interface for input and output data. 
It supports parameterizable data width (DW).

Module Parameters:
- DW: Data width of inputs and output (default 32 bits)

Inputs:
- clk        : System clock
- rst        : Active-high synchronous reset
- A_data     : First input number
- A_valid    : Input A valid signal
- B_data     : Second input number
- B_valid    : Input B valid signal
- GCD_ready  : Output GCD ready handshake signal

Outputs:
- A_ready    : Input A ready signal (for handshake)
- B_ready    : Input B ready signal (for handshake)
- GCD_data   : Calculated GCD output
- GCD_valid  : Output valid signal

Internal Signals:
- A_data_reg, B_data_reg : Registered versions of input data
- A_valid_reg, B_valid_reg : Registered valid signals
- opcode     : Indicates the operation to perform in COMPARE_UPDATE state
- current_state, next_state : FSM state tracking
- A_have, B_have : Indicates if input data has been successfully latched into registers

FSM States:
1. IDLE:
   - Waits for both input numbers to be valid.
   - Checks if either input is zero:
       - If yes, move directly to GCD state.
       - If no, move to COMPARE_UPDATE for Euclidean iterations.
   - Handles input handshake and latching.

2. COMPARE_UPDATE:
   - Implements one iteration of the Euclidean Algorithm:
       - If A > B, subtract B from A (opcode = 2'b10)
       - If B > A, subtract A from B (opcode = 2'b01)
       - If A == B, move to GCD state (opcode = 2'b11)
   - Opcode is **computed combinationally** in each cycle based on 
     the current values of A_data_reg and B_data_reg.
   - Opcode determines which subtraction operation is performed 
     in this state.

3. GCD:
   - Outputs the GCD result.
   - Logic:
       - If A = 0 → GCD = B
       - If B = 0 → GCD = A
       - Otherwise → GCD = final value of A or B
   - Sets GCD_valid high until GCD_ready is received.

Handshake Mechanism:
- Input handshake:
   - A_ready and B_ready signals indicate that the module can accept input data.
   - Data is latched into A_data_reg and B_data_reg only when both valid 
     and ready signals are high.
- Output handshake:
   - GCD_valid is asserted when GCD_data is valid.
   - Module waits for GCD_ready from external system before returning to IDLE.

Detailed Explanation of Helper Signals:
- **A_have and B_have:**
   - These signals track whether the input data has been successfully latched 
     into internal registers.
   - A_have = 1 when A_valid and A_ready are both high, meaning A_data is stored.
   - B_have = 1 when B_valid and B_ready are both high, meaning B_data is stored.
   - These signals are used to control input ready signals in IDLE state 
     and prevent overwriting data prematurely.
- **Opcode:**
   - Opcode encodes which subtraction operation should occur:
       - 2'b10 → A = A - B
       - 2'b01 → B = B - A
       - 2'b11 → A == B, move to GCD state
   - It is updated combinationally based on current A_data_reg and B_data_reg 
     values and drives the COMPARE_UPDATE state operations.



Example 1: Zero Input
- Inputs: A = 0, B = 24
- FSM: IDLE → GCD
- GCD_data = 24, GCD_valid asserted, waits for GCD_ready, then returns to IDLE.

Example 2: Normal Input
- Inputs: A = 48, B = 18
- FSM: IDLE → COMPARE_UPDATE (iterations: 48-18=30, 30-18=12, 12-6=6) → GCD
- GCD_data = 6, GCD_valid asserted, waits for GCD_ready, then returns to IDLE.


Highlights:
- Fully synchronous design with parameterized data width.
- Implements Euclidean algorithm efficiently using iterative subtraction.
- Handshake mechanism ensures proper data flow without race conditions.
- Designed for integration in larger hardware systems.

Usage:
- Instantiate the module with desired data width.
- Provide valid input numbers and monitor GCD_valid/GCD_data outputs.
- Respect handshake protocol to avoid data loss.
*//////////////////////////////////////////////////////////////////////////////


module GCD#(
    parameter DW = 32    )
    (
    input clk,
    input rst,

    input logic [DW-1:0] A_data,
    input logic A_valid,
    output logic A_ready,

    input logic [DW-1:0] B_data,
    input logic B_valid,
    output logic B_ready,

    output logic [DW-1:0] GCD_data,
    output logic GCD_valid,
    input logic GCD_ready
);

logic [DW-1:0] A_data_reg;
logic A_valid_reg;

logic [DW-1:0] B_data_reg;
logic B_valid_reg;

logic [1:0] opcode;
logic A_have, B_have;

enum { IDLE, COMPARE_UPDATE, GCD} current_state, next_state;

// curent state logic
always@(posedge clk)begin
    if(rst) current_state <= IDLE;
    else current_state <= next_state;
end

// next state logic
always_comb begin 
    next_state = IDLE;
    case(current_state) 
        IDLE: begin
            if(A_valid_reg && B_valid_reg && (A_data_reg ==0 || B_data_reg==0 ) ) next_state <= GCD;
            else if(A_valid_reg && B_valid_reg) next_state <= COMPARE_UPDATE;
            else next_state <= IDLE;
        end
        COMPARE_UPDATE: begin
            case(opcode)
                2'b10,2'b01 : next_state <= COMPARE_UPDATE;
                2'b11       : next_state <= GCD;
                default     :next_state <= COMPARE_UPDATE;
            endcase
        end
        GCD: begin
            if(GCD_ready) next_state <= IDLE;
            else next_state <= GCD;
        end
    endcase
    
end


always@(posedge clk) begin 
    if(rst) begin
        A_ready         <= 'd0;
        B_ready         <= 'd0;
        A_data_reg      <= 'd0;
        A_valid_reg     <= 'd0;
        B_data_reg      <= 'd0;
        B_valid_reg     <= 'd0;
    end
    else begin
        case(current_state) 
            IDLE: begin
                if(!A_valid && !B_valid) begin
                    A_ready  <= 'd1;
                    B_ready  <= 'd1; 
                end
                else if( (A_valid && !B_valid) || (B_valid && !A_valid) ) begin
                    A_ready <= !A_have ;
                    B_ready <= !B_have; 
                end
                else begin
                    A_ready <= 'd0 ;
                    B_ready <= 'd0 ; 
                end
                    
                
                if(A_valid && A_ready) begin
                    A_data_reg  <= A_data;
                    A_valid_reg <= A_valid;
                end
                 if(B_ready && B_valid) begin
                    B_data_reg  <= B_data;
                    B_valid_reg <= B_valid;
                end

            end

            COMPARE_UPDATE: begin     
                A_ready <= 'd0;
                B_ready <= 'd0; 
                case (opcode)
                    2'b10:A_data_reg <= A_data_reg - B_data_reg;
                    2'b01:B_data_reg <= B_data_reg - A_data_reg;
                    default : begin
                        A_data_reg <= A_data_reg;
                        B_data_reg <= B_data_reg;
                    end
                endcase
            end
            GCD: begin
                A_ready <= 'd0;
                B_ready <= 'd0; 
                A_valid_reg <= 'd0 ;  
                B_valid_reg <= 'd0;             
            end
        endcase
        
    end
end

always@(*) begin
if(rst) begin
        opcode          = 'd0;
        GCD_valid       = 'd0;
        GCD_data        = 'd0;
        GCD_valid       = 'd0;
        A_have          = 'd0;
        B_have          = 'd0;
    end
    else begin
        case(current_state) 
            IDLE: begin
                GCD_data        = 'd0;
                GCD_valid       = 'd0;
                opcode          = 'd0;
                A_have          = A_valid && A_ready;
                B_have          = B_valid && B_ready;
            end
            COMPARE_UPDATE: begin

                if( A_data_reg > B_data_reg)        opcode    = 2'b10;
                else if( B_data_reg > A_data_reg)   opcode    = 2'b01;
                else                                opcode    = 2'b11;
            end
            GCD: begin


                //  - If A = 0 → GCD = B
                //  - Else if B = 0 → GCD = A
                //  - Else → move forward to COMPARE_UPDATE state for normal Euclid iterations
                GCD_data    = A_data_reg == 0 ? (B_data_reg ): (B_data_reg ==0 ? A_data_reg : B_data_reg );
                GCD_valid   = 'd1;
            end
        endcase
        
    end
end



endmodule