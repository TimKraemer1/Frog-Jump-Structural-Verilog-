`timescale 1ns / 1ps

module frog_movement(
    input move_up,
    input move_down,
    input reset_frog,
    input frame,
    input clk,
    output [9:0] current_pos
    );
    
    wire [9:0] reg_out;
    wire [9:0] mux_out;
    
    wire [9:0] mux1;
    
    assign mux1 = reset_frog ? 10'b0011100111 : mux_out;

    
    
    FDRE #(.INIT(1'b1) )ff_0 (.C(clk), .CE(frame | reset_frog), .D(mux1[0]), .Q(reg_out[0]));
    FDRE #(.INIT(1'b1) )ff_1 (.C(clk), .CE(frame | reset_frog), .D(mux1[1]), .Q(reg_out[1]));
    FDRE #(.INIT(1'b1) )ff_2 (.C(clk), .CE(frame | reset_frog), .D(mux1[2]), .Q(reg_out[2]));
    FDRE #(.INIT(1'b0) )ff_3 (.C(clk), .CE(frame | reset_frog), .D(mux1[3]), .Q(reg_out[3]));
    FDRE #(.INIT(1'b0) )ff_4 (.C(clk), .CE(frame | reset_frog), .D(mux1[4]), .Q(reg_out[4]));
    FDRE #(.INIT(1'b1) )ff_5 (.C(clk), .CE(frame | reset_frog), .D(mux1[5]), .Q(reg_out[5]));
    FDRE #(.INIT(1'b1) )ff_6 (.C(clk), .CE(frame | reset_frog), .D(mux1[6]), .Q(reg_out[6]));
    FDRE #(.INIT(1'b1) )ff_7 (.C(clk), .CE(frame | reset_frog), .D(mux1[7]), .Q(reg_out[7]));
    FDRE #(.INIT(1'b0) )ff_8 (.C(clk), .CE(frame | reset_frog), .D(mux1[8]), .Q(reg_out[8]));
    FDRE #(.INIT(1'b0) )ff_9 (.C(clk), .CE(frame | reset_frog), .D(mux1[9]), .Q(reg_out[9]));
    
    assign mux_out = move_down ? (reg_out + 10'd3) : (move_up ? (reg_out - 10'd3) : reg_out);
    
    assign current_pos = reg_out;
        
endmodule
