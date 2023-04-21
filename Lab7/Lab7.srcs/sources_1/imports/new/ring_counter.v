`timescale 1ns / 1ps

module ring_counter(
    input advance,
    input clk,
    input reset,
    output [3:0] ring
    );
    
    wire [3:0] in;
    
    FDRE #(.INIT(1'b1) ) ff_3 (.C(clk), .CE(advance), .R(reset), .D(in[0]), .Q(in[1]));
    FDRE #(.INIT(1'b0) ) ff_2 (.C(clk), .CE(advance), .D(in[1]), .Q(in[2]));
    FDRE #(.INIT(1'b0) ) ff_1 (.C(clk), .CE(advance), .D(in[2]), .Q(in[3]));
    FDRE #(.INIT(1'b0) ) ff_0 (.C(clk), .CE(advance), .D(in[3]), .Q(in[0]));
    
    assign ring[0] = in[0];
    assign ring[1] = in[1];
    assign ring[2] = in[2];
    assign ring[3] = in[3];
    
endmodule
