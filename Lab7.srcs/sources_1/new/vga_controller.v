`timescale 1ns / 1ps

module vga_controller(
    input clk,
    output [9:0] x_pixel,
    output [9:0] y_pixel,
    output h_sync,
    output v_sync
    );
    
    wire [9:0] hor_counter_out;
    wire [9:0] ver_counter_out;
    wire hor_tc;
    wire ver_tc;
    wire ver_counter_enable;
    
    hsync_counter hor_counter (.clk(clk), .out(hor_counter_out), .TC(hor_tc));
    vsync_counter ver_counter (.clk(clk), .out(ver_counter_out), .CE(ver_counter_enable), .TC(ver_tc));
    
    assign ver_counter_enable = hor_tc;
    
    assign x_pixel = hor_counter_out;
    assign y_pixel = ver_counter_out;
    
    assign h_sync = !((x_pixel >=655) && (x_pixel <= 750));
    assign v_sync = !((y_pixel >= 489) && (y_pixel <= 490));
    
endmodule
