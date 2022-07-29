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
    localparam FSM_BITS = clogb2(2);
    localparam [FSM_BITS - 1: 0] PAUSE = 0;
    localparam [FSM_BITS - 1: 0] OK = 1;
    localparam [FSM_BITS - 1: 0] STOP = 2;
    reg last_dir = 1'b0;
    localparam OK_T = 3;
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
        if (CNT == OK_T) begin
            last_dir <= ~last_dir;
        end
        case (state)
            PAUSE: begin
                if (CNT == OK_T) begin
                    state <= STOP;
                end
                end
            STOP: begin
                  if (CNT == OK_T) begin
                    state <= PAUSE;
                  end
                  end
            default: state <= PAUSE;
         endcase
    end
    
    assign pin1 = (state == OK);
    assign pin2 = (state == STOP);
    assign pin3 = (state == PAUSE);
endmodule

module counter(input clk,
    output Q
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
    assign Q = (count == FREQ - 1);
endmodule
