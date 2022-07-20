`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/08/2022 12:22:32 PM
// Design Name: 
// Module Name: Blinker
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
module Das_Blinkenlights( input clk, output led);
    wire pulse_per_second;
    
    Counter counter(.clk(clk), .Q(pulse_per_second));
    
    Blink_OOOO Blinky(.clk(clk), .CE(pulse_per_second), .Q(led));
    
endmodule

module Counter(
    output Q,
    input clk
    );
    reg [23:0] counter = 24'd0;
    always @ (posedge clk) begin
        if (counter == 24'd11999999) begin
            counter <= 24'd0;
        end else begin
            counter = counter + 1;
        end
    end
    assign Q = (counter == 24'd11999999);
    
endmodule

module Blink_OOOO(input clk,
    input CE,
    output Q);
    
    reg led_value = 0;
    
    always @ (posedge clk) begin
        if (CE) led_value <= ~led_value;
    end
    
    assign Q = led_value;

endmodule

module All_4_Lights(
    input [1:0] btn,
    input clk,
    output [3:0] led,
    output [2:0] rgb
    );
    
    reg [23:0] counter = 24'd0;
    reg Q = 1;
    
    always @ (posedge clk) begin
        if (counter == 24'd11999999) begin
            counter <= 24'd0;
            if (Q == 1) begin
                Q <= 0;
            end else begin
                Q <= 1;
            end
        end else begin
            counter <= counter + 1;
        end
       // if (counter == 24'd6000000) begin
       //     Q <= 1;
        //end
        //if (counter == 24'd0) begin
        //    Q <=0;
       // end  
    end
    assign led[0] = 1;
    assign led[2] = (btn[0] | btn[1]) ? 1 : 0;
    assign led[1] = (btn[0] & btn[1]) ? 1 : 0; 
    assign led[3] = Q;
endmodule


//module LedButton(btn, rgb, led);
  //  input wire [1 : 0] btn;
    //output wire [2 : 0] rgb;
    //output wire [3 : 0] led;

    //assign rgb[2] = btn[0] ? 1 : 0;
   // assign rgb[1] = btn[1] ? 0 : 1;
    //assign rgb[0] = 1;

    //assign led[0] = btn[0] ? 1 : 0;
    //assign led[3] = btn[1] ? 2'b11 : 2'b00;
    //assign led[2:1] = btn[0] & btn[1] ? 2'b11 : 2'b00;
//endmodule


//`define DELAY 12_000_000

//module Blink(clk, rgb, led);
  //  input wire clk;
    //output reg [2 : 0] rgb = 3'b111;
    //output reg [3 : 0] led = 4'b0000;
    
    //reg [$clog2(`DELAY) - 1:0] counter = 0;
    
    //always @(posedge clk)
    //begin
     //   if (counter == `DELAY - 1)
       // begin
      //      led <= led + 1;
        //    counter <= 0;
        //end
        //else
          //  counter <= counter + 1;
    //end
//endmodule
