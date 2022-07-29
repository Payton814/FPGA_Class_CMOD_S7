`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2022 09:29:02 AM
// Design Name: 
// Module Name: counter_sim
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


module counter_sim;

reg clk;
wire Q;
counter count(.clk(clk), .Q(Q));


always begin
#41.66666667 clk = ~clk;
end

initial begin
clk <= 0;

#100;
end
endmodule
