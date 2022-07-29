`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2022 12:10:44 PM
// Design Name: 
// Module Name: FSM_Traffic_TB
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


module FSM_Traffic_TB(

    );
    
    reg clk;
    wire pin1;
    wire pin2;
    wire pin3;
    wire Q;
    reg [25:0] Val = 0;
    reg [5:0] CNT = 0;
    
    
    FSM_Traffic FSM(.clk(clk), .pin1(pin1), .pin2(pin2), .pin3(pin3));
    counter count(.clk(clk),.Q(Q));
    always begin
    if (Q) begin
        CNT <= CNT + 1;
    end
    #41.666666666666666666666666666666666666666666667 clk = ~clk;
    end
    
    always @(posedge clk) begin
    Val <= Val + 1;
    end
    
    initial begin
        clk <= 0;
        #100;
    end
endmodule




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
