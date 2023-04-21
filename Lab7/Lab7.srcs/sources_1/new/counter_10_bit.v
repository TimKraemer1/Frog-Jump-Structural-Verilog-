`timescale 1ns / 1ps

module counter_10_bit(
    input CE,
    input R,
    input clk,
    output [9:0] Q
    );
    
    wire [9:0] reg_out;
    wire [9:0] incr_out;
    wire [9:0] mux_out;
    
    FDRE #(.INIT(1'b0) )ff_0 (.C(clk), .R(R), .CE(CE), .D(mux_out[0]), .Q(reg_out[0]));
    FDRE #(.INIT(1'b0) )ff_1 (.C(clk), .R(R), .CE(CE), .D(mux_out[1]), .Q(reg_out[1]));
    FDRE #(.INIT(1'b0) )ff_2 (.C(clk), .R(R), .CE(CE), .D(mux_out[2]), .Q(reg_out[2]));
    FDRE #(.INIT(1'b0) )ff_3 (.C(clk), .R(R), .CE(CE), .D(mux_out[3]), .Q(reg_out[3]));
    FDRE #(.INIT(1'b0) )ff_4 (.C(clk), .R(R), .CE(CE), .D(mux_out[4]), .Q(reg_out[4]));
    FDRE #(.INIT(1'b0) )ff_5 (.C(clk), .R(R), .CE(CE), .D(mux_out[5]), .Q(reg_out[5]));
    FDRE #(.INIT(1'b0) )ff_6 (.C(clk), .R(R), .CE(CE), .D(mux_out[6]), .Q(reg_out[6]));
    FDRE #(.INIT(1'b0) )ff_7 (.C(clk), .R(R), .CE(CE), .D(mux_out[7]), .Q(reg_out[7]));
    FDRE #(.INIT(1'b0) )ff_8 (.C(clk), .R(R), .CE(CE), .D(mux_out[8]), .Q(reg_out[8]));
    FDRE #(.INIT(1'b0) )ff_9 (.C(clk), .R(R), .CE(CE), .D(mux_out[9]), .Q(reg_out[9]));
    
    assign Q = reg_out;
    
    assign incr_out = reg_out + 1'd1;
    
    mux_10v10 mux1 (.in0(incr_out), .in1(reg_out), .sel(CE), .out(mux_out));
    
    
    
endmodule
