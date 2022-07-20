`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2022 09:22:45 AM
// Design Name: 
// Module Name: Class_4
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


module FPGA_Class_4(
    input clk,
    output led
    );
    
    wire pulse_per_second;
    Counter #(.FREQ(12000000)) count(.clk(clk), .Q(pulse_per_second));
    
endmodule

module Counter(
    input clk,
    output Q
    );
    
    parameter FREQ = 12000000;
    
    function integer clogb2;
        input integer value;
        for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1) begin
            value = value >> 1;
        end
    endfunction
    localparam NBITS = clogb2(FREQ - 1);
    reg [NBITS-1:0] counter = {NBITS{1'b0}};
    
    always @ (posedge clk) begin
        if (counter == FREQ - 1) begin
            counter = {NBITS{1'b0}};
        end else begin
            counter = counter + 1;
        end
    end
    assign Q = (counter == FREQ - 1);    
endmodule
