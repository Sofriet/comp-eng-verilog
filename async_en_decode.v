`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TU Delft
// Engineer: Sofie Vos
// 
// Create Date: 11.09.2024 15:11:11
// Design Name:
// Module Name: async_en_decode
// Project Name:
// Target Devices: PYNQ Z1
// Tool Versions: 2023.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: cardinal direction decoder
// 
//////////////////////////////////////////////////////////////////////////////////


module async_en_decode(
    input wire reset,
    input wire prog_select,
    input wire [2:0] bin_rot,
    input wire [3:0] gray_rot,
    output reg [3:0] led
);

    always @(*) begin
        if (prog_select) begin
            if (reset) begin
                led = 4'b0000;
            end
            else begin
                led[2:0] = bin_rot;
                led[3]   = 1'b0;
            end
        end else begin
            case (gray_rot)
                    4'b1111: led = 4'b1000; // West → LD3
                    4'b0100: led = 4'b1001; // North-West → LD0, LD3
                    4'b0110: led = 4'b0001; // North → LD0
                    4'b0010: led = 4'b0011; // North-East → LD0, LD1
                    4'b0011: led = 4'b0010; // East → LD1
                    4'b0001: led = 4'b0110; // South-East → LD2, LD1
                    4'b1001: led = 4'b0100; // South → LD2
                    4'b1000: led = 4'b1100; // South-West → LD2, LD3
                    default: led = 4'b0000; // Invalid input
            endcase
        end
    end


endmodule
