`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TU Delft
// Engineer: Sofie Vos
// 
// Create Date: 09/22/2025 12:48:23 PM
// Design Name: 
// Module Name: LFSR
// Project Name:
// Target Devices: PYNQ Z1
// Tool Versions: 2023.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: linear feedback shift register random number generator
// 
//////////////////////////////////////////////////////////////////////////////////


module LFSR(
    input wire clk,
    input wire [5:0] seed,
    input wire reset,
    output wire [5:0] lfsr
);
    reg [5:0] lfsr_reg;
    reg [5:0] seed_reg;
    reg [0:7] counter;
    reg hold;

    // Feedback for x^6 + x^5 + x^3 + 1
    wire feedback = lfsr_reg[5] ^ lfsr_reg[4] ^ lfsr_reg[2];

    always @(posedge clk) begin
        if (reset) begin
            lfsr_reg <= seed;
            seed_reg <= seed;
            hold <= 0;
            counter <= 0;
        end else begin
            if (seed != seed_reg) begin
                lfsr_reg <= seed;
                seed_reg <= seed;
                hold <= 0;
                counter <= 0;
            end else if (!hold) begin
                lfsr_reg <= {lfsr_reg[4:0], feedback};
                counter <= counter + 1;
                if ({lfsr_reg[4:0], feedback} == seed_reg) begin
                    hold <= 1; 
                end
            end
        end
    end

    assign lfsr = lfsr_reg;

endmodule



