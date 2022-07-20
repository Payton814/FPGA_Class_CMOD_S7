`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2022 10:30:36 AM
// Design Name: 
// Module Name: Binary_Shift_Example
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


module Binary_Shift_Example(

    );
    
    integer i;
    integer value = 4;
    integer j;
    reg Q;
    wire Z;
    

    
    initial begin
    for (i = 0; i < 10; i = i + 1) begin
        $display ("current loop#%0d", i);
    end
    
    for (j = 0; value > 0; j = j + 1) begin
        value = value >> 1;
        $display ("#%0d, j value #%0d", value, j);
        Q = (j > 12);
        $display ("Q is #%0d", Q);
    end
    end
endmodule
