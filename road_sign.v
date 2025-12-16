`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TU Delft
// Engineer: Himanshu Savargaonkar (template), Sofie Vos
// 
// Create Date: 29.08.2024 14:40:05
// Design Name: 
// Module Name: road_sign
// Project Name: 
// Target Devices: PYNQ Z1
// Tool Versions: 2023.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: finite state machine
// 
//////////////////////////////////////////////////////////////////////////////////


module road_sign(
    input wire clk,      // Clock signal
    input wire reset,    // Reset signal to restart the FSM
    input wire [3:0] btn, // 4-bit input register
    output reg [3:0] led, // 4-bit output register
    output reg [2:0] rgb_led //show the mode
    );
    //----------Template code stops here ----------
    
    //Enable mode
    wire left_enable, right_enable, warning_enable;
    //Led to use for mode
    wire [3:0] left_led, right_led, warning_led;
    
    //Detecting button press
    reg [3:0] btn_prev;
    reg [3:0] btn_rising_edge;
    
    //Counter for led state transitions every 500ms
    localparam integer MAX_COUNT = 62500000;
   //uncomment line below for simulation, and comment above
   //localparam integer MAX_COUNT = 10;

    //tick for led state transitions every 500ms
    reg [26:0] tick_counter = 0;
    //tick = 1 means next transition is allowed
    //tick = 0 means stay in current led state
    reg tick = 0;
    
    localparam SAFE    = 3'd0,
               LEFT    = 3'd1,
               RIGHT   = 3'd2,
               WARNING = 3'd3;
    
    reg [2:0] mode = SAFE, next_mode;
    
    //Modes
    //reset propagated for if the led is 
    left_mode left_inst (
        .clk(clk),
        .enable(left_enable),
        .led(left_led),
        .tick(tick),
        .reset(reset)
    );
    
    right_mode right_inst (
        .clk(clk),
        .enable(right_enable),
        .led(right_led),
        .tick(tick),
        .reset(reset)
    );
    
    warning_mode warning_inst (
        .clk(clk),
        .enable(warning_enable),
        .led(warning_led),
        .tick(tick),
        .reset(reset)
    );
    
    //enables of inner FSM's with mode
    assign left_enable    = (mode == LEFT);
    assign right_enable   = (mode == RIGHT);
    assign warning_enable = (mode == WARNING);
    
    //Counter for led state transitions every 500ms
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tick_counter <= 0;
            tick <= 0;
        end else begin
            if (tick_counter >= MAX_COUNT - 1) begin
                tick_counter <= 0;
                tick <= 1;
            end else begin
                tick_counter <= tick_counter + 1;
                tick <= 0;
            end
        end
    end
    
    //Update button pressses
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            btn_prev <= 4'b0000;
            btn_rising_edge <= 4'b0000;
        end else begin
            btn_rising_edge <= btn & ~btn_prev;
            btn_prev <= btn;
        end
    end
    
    //Mode transitions
    always @(posedge clk) begin
        if (reset) begin
            mode <= SAFE;
        end else begin
            mode <= next_mode;
        end 
        
        rgb_led <= mode;
    end

    
    //Mode logic
    always @(*) begin
       if (mode == SAFE) begin
        case (btn_rising_edge)
            4'b0001: next_mode = LEFT;
            4'b0010: next_mode = RIGHT;
            4'b0100: next_mode = WARNING;
            4'b1000: next_mode = SAFE;
            default: next_mode = mode;
        endcase
       end else begin
        case (btn_rising_edge) 
            4'b1000: next_mode = SAFE;
            default: next_mode = mode;
        endcase
       end
    end
    
    //Led logic
    always @(*) begin
        case (mode)
            LEFT:    led = left_led;
            RIGHT:   led = right_led;
            WARNING: led = warning_led;
            default: led = 4'd0;
        endcase
    end

endmodule
