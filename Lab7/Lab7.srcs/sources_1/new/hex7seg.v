`timescale 1ns / 1ps

module hex7seg(
    input [3:0] n,
    output [6:0] seg
    );
    
    //selector bus
    wire [2:0] sel;
    assign sel = {n[3:1]};
    
    //CA Segment
    wire [7:0] CA;
    assign CA = {1'b0, n[0], n[0], 1'b0, 1'b0, !n[0], 1'b0, n[0]};
    multiplexer8 mux8_1(.in(CA), .s(sel), .o(seg[0]));
    
    //CB Segment
    wire [7:0] CB;
    assign CB = {1'b1, !n[0], n[0], 1'b0, !n[0], n[0], 1'b0, 1'b0};
    multiplexer8 mux8_2(.in(CB), .s(sel), .o(seg[1]));
    
    //CC Segment
    wire [7:0] CC;
    assign CC = {1'b1, !n[0], 1'b0, 1'b0, 1'b0, 1'b0, !n[0], 1'b0};
    multiplexer8 mux8_3(.in(CC), .s(sel), .o(seg[2]));
    
    //CD Segment
    wire [7:0] CD;
    assign CD = {n[0], 1'b0, !n[0], n[0], n[0], !n[0], 1'b0, n[0]};
    multiplexer8 mux8_4(.in(CD), .s(sel), .o(seg[3]));
    
    //CE Segment
    wire [7:0] CE;
    assign CE = {1'b0, 1'b0, 1'b0, n[0], n[0], 1'b1, n[0], n[0]};
    multiplexer8 mux8_5(.in(CE), .s(sel), .o(seg[4]));
    
    //CF Segment
    wire [7:0] CF;
    assign CF = {1'b0, n[0], 1'b0, 1'b0, n[0], 1'b0, 1'b1, n[0]};
    multiplexer8 mux8_6(.in(CF), .s(sel), .o(seg[5]));
    
    //CG Segment
    wire [7:0] CG;
    assign CG = {1'b0, !n[0], 1'b0, 1'b0, n[0], 1'b0, 1'b0, 1'b1};
    multiplexer8 mux8_7(.in(CG), .s(sel), .o(seg[6]));
    
    
endmodule
