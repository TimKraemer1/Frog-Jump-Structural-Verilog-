`timescale 1ns / 1ps

module LFSR(
    input clk,
    input CE,
    output [4:0] rand_val,
    output negative
    );
   
   wire first_FF_in;
   wire [7:0] rnd;
   wire [7:0] out;
   
   //generating random number stream
   assign first_FF_in = rnd[0] ^ rnd[5] ^ rnd[6] ^ rnd[7];
   
   FDRE #(.INIT(1'b1) )ff_0 (.C(clk), .CE(1'b1), .D(first_FF_in), .Q(rnd[0]));
   FDRE #(.INIT(1'b0) )ff_1 (.C(clk), .CE(1'b1), .D(rnd[0]), .Q(rnd[1]));
   FDRE #(.INIT(1'b0) )ff_2 (.C(clk), .CE(1'b1), .D(rnd[1]), .Q(rnd[2]));
   FDRE #(.INIT(1'b0) )ff_3 (.C(clk), .CE(1'b1), .D(rnd[2]), .Q(rnd[3]));
   FDRE #(.INIT(1'b0) )ff_4 (.C(clk), .CE(1'b1), .D(rnd[3]), .Q(rnd[4]));
   FDRE #(.INIT(1'b0) )ff_5 (.C(clk), .CE(1'b1), .D(rnd[4]), .Q(rnd[5]));
   FDRE #(.INIT(1'b0) )ff_6 (.C(clk), .CE(1'b1), .D(rnd[5]), .Q(rnd[6]));
   FDRE #(.INIT(1'b0) )ff_7 (.C(clk), .CE(1'b1), .D(rnd[6]), .Q(rnd[7]));
   
   //selecting on random number
   FDRE #(.INIT(1'b0) )ff_sel_0 (.C(clk), .CE(CE), .D(rnd[0]), .Q(out[0]));
   FDRE #(.INIT(1'b0) )ff_sel_1 (.C(clk), .CE(CE), .D(rnd[1]), .Q(out[1]));
   FDRE #(.INIT(1'b0) )ff_sel_2 (.C(clk), .CE(CE), .D(rnd[2]), .Q(out[2]));
   FDRE #(.INIT(1'b0) )ff_sel_3 (.C(clk), .CE(CE), .D(rnd[3]), .Q(out[3]));
   FDRE #(.INIT(1'b0) )ff_sel_4 (.C(clk), .CE(CE), .D(rnd[4]), .Q(out[4]));
   FDRE #(.INIT(1'b0) )ff_sel_5 (.C(clk), .CE(CE), .D(rnd[5]), .Q(out[5]));
   FDRE #(.INIT(1'b0) )ff_sel_6 (.C(clk), .CE(CE), .D(rnd[6]), .Q(out[6]));
   FDRE #(.INIT(1'b0) )ff_sel_7 (.C(clk), .CE(CE), .D(rnd[7]), .Q(out[7]));
   
   assign rand_val[4:0] = out[2:0] << 2;
   assign negative = out[0];    
   
endmodule
