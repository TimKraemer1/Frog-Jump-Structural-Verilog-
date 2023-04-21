`timescale 1ns / 1ps

module plant_movement2(
    input frame,
    input game_play,
    input clk,
    input reset_plant_init_pos,
    output [9:0] current_pos,
    output reset
    );
    
    wire [9:0] reg_out;
    wire [9:0] mover_out;
    wire [9:0] mux_out;
    wire [9:0] reset_mux;
    
    assign reset_mux = reset_plant_init_pos ? 10'b1000011100 : mux_out; 
    
    assign mux_out = reset ? 10'd720 : mover_out;
    
    FDRE #(.INIT(1'b0) ) ff_0 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[0]), .Q(reg_out[0]));
    FDRE #(.INIT(1'b0) ) ff_1 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[1]), .Q(reg_out[1]));
    FDRE #(.INIT(1'b1) ) ff_2 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[2]), .Q(reg_out[2]));
    FDRE #(.INIT(1'b1) ) ff_3 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[3]), .Q(reg_out[3]));
    FDRE #(.INIT(1'b1) ) ff_4 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[4]), .Q(reg_out[4]));
    FDRE #(.INIT(1'b0) ) ff_5 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[5]), .Q(reg_out[5]));
    FDRE #(.INIT(1'b0) ) ff_6 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[6]), .Q(reg_out[6]));
    FDRE #(.INIT(1'b0) ) ff_7 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[7]), .Q(reg_out[7]));
    FDRE #(.INIT(1'b0) ) ff_8 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[8]), .Q(reg_out[8]));
    FDRE #(.INIT(1'b1) ) ff_9 (.C(clk), .CE((frame & game_play) | reset_plant_init_pos), .D(reset_mux[9]), .Q(reg_out[9]));
    
    assign mover_out = reg_out - 10'd3;
    
    assign current_pos = reg_out;
    
    assign reset = (reg_out == 10'd0);
    
            
endmodule
