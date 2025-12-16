`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TU Delft
// Engineer: Sofie Vos
// 
// Create Date: 09/20/2025 11:23:18 AM
// Design Name: 
// Module Name: warning_mode
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


module warning_mode (
    input wire clk,
    input wire enable,
    input wire tick,
    input wire reset,
    output reg [3:0] led = S1
);

    // LED patterns (state values)
    localparam S1 = 4'd0,
               S2 = 4'b1100,
               S3 = 4'b0011;

    reg [3:0] next_led;

    //FSM transition
    always @(posedge clk) begin
        if(reset) begin
            led <= S1;
        end else if (enable && tick) begin
            if ((led == S1) || (led == S2) || (led == S3)) begin
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
            S3: next_led = S1;
            default: next_led = S1;
        endcase
    end

endmodule
