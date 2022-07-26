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
    output pin6
    );
    
    `include "clogb2.vh";
    
    
    
endmodule

module counter(input clk,
    output Q
    );
    
    parameter FREQ = 12000000;
    localparam C_BITS = clogb2(FREQ - 1);
    reg [C_BITS - 1:0] count = {C_BITS{1'b0}};
    
    always @ (posedge clk) begin
        if (count == FREQ - 1) begin
            count = {C_BITS{1'b0}};
        end else begin
            count = count + 1;
        end
    end    
    assign Q = count;
endmodule
