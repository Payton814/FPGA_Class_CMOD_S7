`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2022 10:37:53 AM
// Design Name: 
// Module Name: FPGA_Class_5
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

// This code makes an example of a Finite State Machine (FSM) using the traffic lights
// at an intersection
module FPGA_Class_5(input clk,
    output pps,
    output NS_RED,
    output NS_YELLOW,
    output NS_GREEN,
    output EW_RED,
    output EW_YELLOW,
    output EW_GREEN
    );
    // Here we include a header file, which can be done by adding a source and
    // selecting the type of file to be verilog header. This allows us to use the 
    // function clogb2 which is defined in the header file
    `include "clogb2.vh"
    
    // Defining the 5 unique states for our system, and calculating the number of bits
    // needed to store the information of the states
    localparam FSM_BITS = clogb2(4);
    localparam [FSM_BITS - 1: 0] PAUSE = 0;
    localparam [FSM_BITS - 1: 0] NS_OK = 1;
    localparam [FSM_BITS - 1: 0] NS_WARN = 2;
    localparam [FSM_BITS - 1: 0] EW_OK = 3;
    localparam [FSM_BITS - 1: 0] EW_WARN = 4;
    reg [FSM_BITS - 1: 0] state = PAUSE;
    
    localparam NS = 0;
    localparam EW = 1;
    reg last_dir = NS;
    
    localparam OK_SEC = 120;
    localparam WARN_SEC = 5;
    localparam PAUSE_SEC = 1;
    localparam CNT_BITS = clogb2(OK_SEC - 1);
    reg [CNT_BITS - 1: 0] counter = 0;
    
    // Here begins the state transitions
    always @(posedge clk) begin
        case (state)
            PAUSE: begin
                if (counter == PAUSE_SEC - 1) begin
                    if (last_dir == NS) begin
                        state <= EW_OK;
                    end else begin
                        state <= NS_OK;
                    end
                end
            end
            NS_OK: if (counter == OK_SEC - 1) begin
                state <= NS_WARN;
                   end
            NS_WARN: if (counter == WARN_SEC - 1) begin
                        state <= PAUSE;
                     end
            EW_OK: if (counter == OK_SEC - 1) begin
                        state <= EW_WARN;
                   end
            EW_WARN: if (counter == WARN_SEC - 1) begin
                        state <= PAUSE;
                     end
            default: state <= PAUSE;
        endcase
    end
    assign NS_RED = (state != NS_OK && state != NS_WARN);
    assign NS_YELLOW = (state == NS_WARN);
    assign NS_GREEN = (state == NS_OK);
    assign EW_RED = (state != EW_OK && state != EW_WARN);
    assign EW_YELLOW = (state == EW_WARN);
    assign EW_GREEN = (state == EW_OK);
endmodule
