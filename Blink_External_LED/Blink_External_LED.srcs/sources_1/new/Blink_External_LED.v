`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2022 03:40:52 PM
// Design Name: 
// Module Name: Blink_External_LED
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


module Blink_External_LED(input clk,
    output p1
    );
    `include "clogb2.vh";
    parameter FREQ = 6000000;
    localparam NBITS = clogb2(FREQ - 1);
    reg [NBITS - 1:0] counter = {NBITS{1'b0}};
    reg Q = 1'b0;
    
    always @(posedge clk) begin
        if (counter == FREQ - 1) begin
            counter = {NBITS{1'b0}};
            Q = ~Q;
        end else begin
            counter = counter + 1;
        end
    end 
    
    assign p1 = Q;
    
    
endmodule
