`timescale 1ns / 1ps

module time_counter_8bit(
    input CE,
    input R,
    input clk,
    output [7:0] Q
    );
    
    wire [7:0] mux_out;
    wire [7:0] reg_out;
    wire [7:0] incr_out;
    
    FDRE #(.INIT(1'b0) )ff_0 (.C(clk), .R(R), .CE(CE), .D(mux_out[0]), .Q(reg_out[0]));
    FDRE #(.INIT(1'b0) )ff_1 (.C(clk), .R(R), .CE(CE), .D(mux_out[1]), .Q(reg_out[1]));
    FDRE #(.INIT(1'b0) )ff_2 (.C(clk), .R(R), .CE(CE), .D(mux_out[2]), .Q(reg_out[2]));
    FDRE #(.INIT(1'b0) )ff_3 (.C(clk), .R(R), .CE(CE), .D(mux_out[3]), .Q(reg_out[3]));
    FDRE #(.INIT(1'b0) )ff_4 (.C(clk), .R(R), .CE(CE), .D(mux_out[4]), .Q(reg_out[4]));
    FDRE #(.INIT(1'b0) )ff_5 (.C(clk), .R(R), .CE(CE), .D(mux_out[5]), .Q(reg_out[5]));
    FDRE #(.INIT(1'b0) )ff_6 (.C(clk), .R(R), .CE(CE), .D(mux_out[6]), .Q(reg_out[6]));
    FDRE #(.INIT(1'b0) )ff_7 (.C(clk), .R(R), .CE(CE), .D(mux_out[7]), .Q(reg_out[7]));
    
    assign Q = reg_out;
    
    assign incr_out = reg_out + 8'd1;

    assign mux_out = CE ? incr_out : reg_out;
        
endmodule
