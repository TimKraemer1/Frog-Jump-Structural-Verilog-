`timescale 1ns / 1ps

module counter_2_sec(
    
    input ResetTimer,
    input frame,
    input clk,
    input Timer_Counter_On_2,
    output TwoSecs
    );
    
    wire CE;
    assign CE = Timer_Counter_On_2 & !TwoSecs & frame;
    
    wire R;
    assign R = TwoSecs;
    
    wire [7:0] out;
    
    time_counter_8bit timer_counter_1 (.CE(CE), .R(R), .clk(clk), .Q(out));
    
    assign TwoSecs = out[6] & out[5] & out[4] & out[3];
    
endmodule
