`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2022 03:23:13 PM
// Design Name: 
// Module Name: Blinker_TEST_BENCH
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


module Blinker_TEST_BENCH;
    
    reg clk;
  //  reg CLK2;
    //reg [23:0] Q;
    wire led;
    Das_Blinkenlights uut(.clk(clk),
    .led(led));
  
    always begin
    #41.6666666666666666667 clk = ~clk;
    end
    initial begin
        clk <= 0;
     //   CLK2 <= 0;
       // Q <= 0;
       #100;
    end
endmodule