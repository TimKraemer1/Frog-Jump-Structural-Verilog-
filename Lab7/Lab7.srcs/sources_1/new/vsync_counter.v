`timescale 1ns / 1ps

module vsync_counter(
    input clk,
    input CE,
    output [9:0] out,
    output TC
    );

    wire counter_reset;
    //Terminal Count should equal = 1000001100
    
    counter_10_bit counter2 (.CE(CE), .R(counter_reset), .clk(clk), .Q(out));
    
    assign TC = out[9] & !out[8] & !out[7] & !out[6] & !out[5] & !out[4] & out[3] & out[2] & !out[1] & !out[0];
    
    assign counter_reset = TC & CE;
    
endmodule
