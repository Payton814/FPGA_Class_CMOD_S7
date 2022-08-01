`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2022 02:51:47 PM
// Design Name: 
// Module Name: FSM_Traffic
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

module FSM_Traffic(
    input clk,
    output pin1,
    output pin2,
    output pin3,
    output pin4,
    output pin5,
    output pin6,
    output led
    );
    parameter FREQ = 12000000;
    parameter NUM_STATES = 5;
    localparam FSM_BITS = clogb2(NUM_STATES - 1);
    localparam [FSM_BITS - 1: 0] PAUSE = 0;
    localparam [FSM_BITS - 1: 0] OK_NS = 1;
    localparam [FSM_BITS - 1: 0] WARN_NS = 2;
    localparam [FSM_BITS - 1: 0] OK_WEAST = 3;
    localparam [FSM_BITS - 1: 0] WARN_WEAST = 4;
    reg last_dir = 1'b0;
    localparam OK_T = 5;
    localparam CNT_BITS = clogb2(OK_T - 1);
    reg [CNT_BITS - 1:0] CNT = 0;
    reg [FSM_BITS - 1: 0] state = PAUSE;
    wire Q;
    `include "clogb2.vh";
    counter counter(.clk(clk), .Q(Q));
    
    always @(posedge clk) begin
        if (Q) begin
            CNT <= CNT + 1;
        end
        case (state)
            PAUSE: begin
                if (CNT == OK_T - 3 & last_dir == 0) begin
                    state <= OK_NS;
                    CNT <= 0;
                    last_dir <= last_dir + 1;
                end
                if (CNT == OK_T - 3 & last_dir == 1) begin
                    state <= OK_WEAST;
                    CNT <= 0;
                    last_dir = last_dir + 1;
                end
                end
            WARN_NS: begin
                  if (CNT == OK_T - 4) begin
                    state <= PAUSE;
                    CNT <= 0;
                  end
                  end
            OK_NS: begin
                if (CNT == OK_T) begin
                    state <= WARN_NS;
                    CNT <= 0;
                end
            end
            WARN_WEAST: begin
                  if (CNT == OK_T - 4) begin
                    state <= PAUSE;
                    CNT <= 0;
                  end
                  end
            OK_WEAST: begin
                if (CNT == OK_T) begin
                    state <= WARN_WEAST;
                    CNT <= 0;
                end
            end
            default: state <= PAUSE;
         endcase
    end
    
    assign pin1 = (state == OK_NS);
    assign pin2 = (state == WARN_NS);
    assign pin3 = (state != OK_NS && state != WARN_NS);
    assign pin4 = (state == OK_WEAST);
    assign pin5 = (state == WARN_WEAST);
    assign pin6 = (state != OK_WEAST && state != WARN_WEAST);
endmodule

module counter(input clk,
    output Q,
    output Val
    );
    parameter FREQ = 12000000;
    `include "clogb2.vh";
    localparam C_BITS = clogb2(FREQ - 1);
    reg [C_BITS - 1:0] count = {C_BITS{1'b0}};
    
    always @ (posedge clk) begin
        if (count == FREQ - 1) begin
            count = {C_BITS{1'b0}};
        end else begin
            count = count + 1;
        end
    end    
    assign Q = (count == FREQ - 1) && (clk);
    assign Val = count;
endmodule
