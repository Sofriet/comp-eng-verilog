`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TU Delft
// Engineer: Sofie Vos
// 
// Create Date: 09/20/2025 06:41:20 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: simulation test for the finite state machine road sign
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_road_sign;

    reg clk;
    reg reset;
    reg [3:0] btn;
    wire [3:0] led;
    wire [2:0] rgb_led;

    // Instantiate the DUT (Device Under Test)
    road_sign uut (
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .led(led),
        .rgb_led(rgb_led)
    );

    // Clock generation (10ns period -> 100MHz)
    always #5 clk = ~clk;

    initial begin
        // Init
        clk = 0;
        reset = 1;
        btn = 4'b0000;

        // Hold reset for a few cycles
        #20;
        reset = 0;

        // Press LEFT button (btn[0])
        #20; btn = 4'b0001;
        #10; btn = 4'b0000;  // Release
        
        // Wait to see LEFT mode effect
        #500;
        
         // Press SAFE button (btn[3])
        #20; btn = 4'b1000;
        #10; btn = 4'b0000;  // Release

        // Wait to see SAFE mode effect
        #500;

        // Press RIGHT button (btn[1])
        #20; btn = 4'b0010;
        #10; btn = 4'b0000;

        // Wait to see RIGHT mode effect
        #500;

        // Press WARNING button (btn[2]) should not be allowed, stay in right mode
        #20; btn = 4'b0100;
        #10; btn = 4'b0000;
        #500;

         // Press SAFE button (btn[3])
        #20; btn = 4'b1000;
        #10; btn = 4'b0000;  // Release

        // Wait to see SAFE mode effect
        #500;
        
        // Press WARNING button (btn[2]) should not be allowed, stay in right mode
        #20; btn = 4'b0100;
        #10; btn = 4'b0000;
        
        #500;

        $finish;
    end

endmodule


