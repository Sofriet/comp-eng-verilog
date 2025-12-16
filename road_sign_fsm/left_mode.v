`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TU Delft
// Engineer: Sofie Vos
// 
// Create Date: 09/19/2025 05:32:36 PM
// Design Name: 
// Module Name: left_mode
// Project Name: 
// Target Devices: PYNQ Z1
// Tool Versions: 2023.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module left_mode (
    input wire clk,
    input wire enable,
    input wire tick,
    input wire reset,
    output reg [3:0] led = S1
);

    // LED patterns (state values)
    localparam S1 = 4'b0000,
               S2 = 4'b0001,
               S3 = 4'b0011,
               S4 = 4'b0110,
               S5 = 4'b1100,
               S6 = 4'b1000;

    reg [3:0] next_led;

    //FSM transition
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            led <= S1;
        end else if (enable && tick) begin
            if ((led == S1) || (led == S2) || (led == S3) || (led == S4) || (led == S5) || (led == S6)) begin
                led <= next_led;
            end else begin
                led <= S1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (led)
            S1: next_led = S2;
            S2: next_led = S3;
            S3: next_led = S4;
            S4: next_led = S5;
            S5: next_led = S6;
            S6: next_led = S1;
            default: next_led = S1;
        endcase
    end

endmodule
