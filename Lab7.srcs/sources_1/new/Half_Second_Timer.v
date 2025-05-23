`timescale 1ns / 1ps

module Half_Second_Timer(
    input reset,
    input clk,
    input frame,
    output HalfSec
    );
    
    wire CE;
    wire R;
    wire [7:0] out;
    
    time_counter_8bit timer_counter_1 (.CE(CE), .R(R), .clk(clk), .Q(out));
    
    assign R = out[5];
    assign CE = frame;
    assign HalfSec = out[5];
    
endmodule
