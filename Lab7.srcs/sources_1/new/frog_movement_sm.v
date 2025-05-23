`timescale 1ns / 1ps

module frog_movement_sm(
    input clk,
    input btnL,
    input btnU,
    input btnC,
    input btnD,
    input [9:0] y_coord,
    input twosec,
    input reset_timer,
    input collision,
    output move_up,
    output move_down,
    output timer_on,
    output reset_plants,
    output reset_frog,
    output flash,
    output game_play,
    output [7:0] ps,
    output flash_disp
    );
    
    wire [7:0] PS, NS;
    
    frog_movement_sm_logic brain (.reset_frog(reset_frog), .reset_plants(reset_plants), .btnC(btnC), .collision(collision), 
    .flash_disp(flash_disp), .game_play(game_play), .timer_on(timer_on), .reset_timer(reset_timer), .btnL(btnL), .btnU(btnU), .btnD(btnD), 
    .flash(flash), .twosec(twosec), .y_coord(y_coord), .PS(PS), .NS(NS), .move_up(move_up), .move_down(move_down));
    
    FDRE #(.INIT(1'b0)) IDLE_FF (.C(clk), .CE(1'b1), .D(NS[0]), .Q(PS[0]));
    FDRE #(.INIT(1'b0)) UP1_FF (.C(clk), .CE(1'b1), .D(NS[1]), .Q(PS[1]));
    FDRE #(.INIT(1'b0)) DW1_FF (.C(clk), .CE(1'b1), .D(NS[2]), .Q(PS[2]));
    FDRE #(.INIT(1'b0)) DW2_FF (.C(clk), .CE(1'b1), .D(NS[3]), .Q(PS[3]));
    FDRE #(.INIT(1'b0)) UP2_FF (.C(clk), .CE(1'b1), .D(NS[4]), .Q(PS[4]));
    FDRE #(.INIT(1'b1)) START_FF (.C(clk), .CE(1'b1), .D(NS[5]), .Q(PS[5]));
    FDRE #(.INIT(1'b0)) TIMER_FF (.C(clk), .CE(1'b1), .D(NS[6]), .Q(PS[6])); 
    FDRE #(.INIT(1'b0)) STOP_FF (.C(clk), .CE(1'b1), .D(NS[7]), .Q(PS[7]));
    
    assign ps = PS;
    
endmodule
