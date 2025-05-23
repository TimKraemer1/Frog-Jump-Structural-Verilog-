`timescale 1ns / 1ps

module score_counter(
    input point,
    input clk,
    input frame,
    input reset,
    output [15:0] total_score
    );
    
    wire [15:0] mux1_out;
    wire [15:0] incr_out;
    wire [15:0] reg_out;
    
    FDRE #(.INIT(1'b0)) ff_1 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[0]), .Q(reg_out[0]));
    FDRE #(.INIT(1'b0)) ff_2 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[1]), .Q(reg_out[1]));
    FDRE #(.INIT(1'b0)) ff_3 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[2]), .Q(reg_out[2]));
    FDRE #(.INIT(1'b0)) ff_4 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[3]), .Q(reg_out[3]));
    FDRE #(.INIT(1'b0)) ff_5 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[4]), .Q(reg_out[4]));
    FDRE #(.INIT(1'b0)) ff_6 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[5]), .Q(reg_out[5]));
    FDRE #(.INIT(1'b0)) ff_7 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[6]), .Q(reg_out[6]));
    FDRE #(.INIT(1'b0)) ff_8 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[7]), .Q(reg_out[7]));
    FDRE #(.INIT(1'b0)) ff_9 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[8]), .Q(reg_out[8]));
    FDRE #(.INIT(1'b0)) ff_10 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[9]), .Q(reg_out[9]));
    FDRE #(.INIT(1'b0)) ff_11 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[10]), .Q(reg_out[10]));
    FDRE #(.INIT(1'b0)) ff_12 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[11]), .Q(reg_out[11]));
    FDRE #(.INIT(1'b0)) ff_13 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[12]), .Q(reg_out[12]));
    FDRE #(.INIT(1'b0)) ff_14 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[13]), .Q(reg_out[13]));
    FDRE #(.INIT(1'b0)) ff_15 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[14]), .Q(reg_out[14]));
    FDRE #(.INIT(1'b0)) ff_16 (.R(reset), .C(clk), .CE(frame), .D(mux1_out[15]), .Q(reg_out[15]));
    
    assign incr_out = reg_out + 16'd1;
    
    assign mux1_out = point ? incr_out : reg_out;    

    assign total_score = reg_out;

endmodule
