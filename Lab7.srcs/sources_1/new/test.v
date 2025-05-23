`timescale 1ns / 1ps

module test(
    input clkin,
    input btnR,
    input btnU,
    input btnD,
    input btnL,
    input btnC,
    output [3:0] vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen,
    output Hsync,
    output Vsync,
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg
    );
       
       wire clk;
       wire [9:0] x_pixel;
       wire [9:0] y_pixel;
       wire collision;
       wire flash_disp;
       wire flash_signal;
       
       //ring counter module, for display, selector, and hex7seg module
       wire [3:0] ring_out;
       wire digsel;
       ring_counter ring (.clk(clk), .advance(digsel), .ring(ring_out));
       assign an[0] = !(flash_disp ? flash_signal : 1'b1) | !ring_out[0];
       assign an[1] = !(flash_disp ? flash_signal : 1'b1) | !ring_out[1];
       assign an[2] = !(flash_disp ? flash_signal : 1'b1) | !ring_out[2];
       assign an[3] = !(flash_disp ? flash_signal : 1'b1) | !ring_out[3];
       
       wire [15:0] sel_in;
       wire [3:0] sel_out;
       selector select1 (.sel(ring_out), .N(sel_in), .H(sel_out)); 
       
       hex7seg disp (.n(sel_out), .seg(seg));
       
       //defines the signal signal whenever the display refreshes once (once every frame)
       wire frame;
       assign frame = (x_pixel == 700) && (y_pixel == 489);
       
              
       lab7_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));
       
       //vga controller
       vga_controller controller1 (.clk(clk), .x_pixel(x_pixel), .y_pixel(y_pixel), .h_sync(Hsync), .v_sync(Vsync));
       
       //Half second counter
       wire half_reset;
       wire HalfSec;
       Half_Second_Timer halfsectime (.clk(clk), .frame(frame), .reset(half_reset), .HalfSec(HalfSec));
       assign half_reset = btnL | collision;
       
       FDRE #(.INIT (1'b1)) reset_frog_test_ff (.C(clk), .CE(1'b1), .D(flash_signal ^ HalfSec), .Q(flash_signal));       
       
       //frog movement state machine
       wire move_up_signal;
       wire move_down_signal;
       wire [9:0] frog_y_coord;
       wire timer_on, reset_timer, twosec;
       wire [7:0] ps;
       wire reset_plants;
       wire reset_frog;
       wire game_play;
       wire reset_frog_test;
       wire flash;
       
       frog_movement_sm frog_brain (.reset_frog(reset_frog), .game_play(game_play), .reset_plants(reset_plants), 
       .flash(flash), .btnC(btnC), .collision(collision), .ps(ps), .clk(clk), .btnU(btnU), .btnD(btnD), 
       .flash_disp(flash_disp), .timer_on(timer_on), .reset_timer(reset_timer), .btnL(btnL), .twosec(twosec), 
       .y_coord(frog_y_coord), .move_up(move_up_signal), .move_down(move_down_signal));
       
       //2 second timer
       counter_2_sec timer (.ResetTimer(reset_timer), .frame(frame), .clk(clk), .Timer_Counter_On_2(timer_on), .TwoSecs(twosec));
                            
       //frog movement module. Includes the counter that counts up or down by 3 depending on move_up or move_down
       frog_movement frog_movement(.reset_frog(reset_frog), .move_up(move_up_signal), .move_down(move_down_signal), .frame(frame), .clk(clk), .current_pos(frog_y_coord));
       
       //plant movement module(s).
       wire [9:0] plant_R_edge_1;
       wire [9:0] plant_R_edge_2;
       wire [9:0] plant_R_edge_3;
       wire signal_0_1, signal_0_2, signal_0_3;
       plant_movement1 plant_movement1(.reset_plant_init_pos(reset_plants), .clk(clk), .frame(frame), .game_play(game_play), .current_pos(plant_R_edge_1), .reset(signal_0_1));
       plant_movement2 plant_movement2(.reset_plant_init_pos(reset_plants), .clk(clk), .frame(frame), .game_play(game_play), .current_pos(plant_R_edge_2), .reset(signal_0_2));
       plant_movement3 plant_movement3(.reset_plant_init_pos(reset_plants), .clk(clk), .frame(frame), .game_play(game_play), .current_pos(plant_R_edge_3), .reset(signal_0_3));
       
       wire [9:0] random_value1, random_value2, random_value3;
       assign random_value1[9:5] = 5'd0;
       assign random_value2[9:5] = 5'd0;
       assign random_value3[9:5] = 5'd0;
       wire negative1, negative2, negative3;
       LFSR random_plant1 (.clk(clk), .CE(signal_0_1), .rand_val(random_value1[4:0]), .negative(negative1));
       LFSR random_plant2 (.clk(clk), .CE(signal_0_2), .rand_val(random_value2[4:0]), .negative(negative2));
       LFSR random_plant3 (.clk(clk), .CE(signal_0_3), .rand_val(random_value3[4:0]), .negative(negative3));

       //scoring
       wire point;
       wire [15:0] total_score;
       assign point = (plant_R_edge_1 >=10'd113 && plant_R_edge_1 < 10'd116) | (plant_R_edge_2 >= 10'd113 && plant_R_edge_2 < 10'd116) | (plant_R_edge_3 >= 10'd113 && plant_R_edge_3 < 10'd116);
       score_counter score(.reset(reset_plants), .clk(clk), .frame(frame), .point(point), .total_score(total_score));
       assign sel_in = total_score;
       
       //defining the y position of the plants
       wire [9:0] plant1top, plant2top, plant3top;
       assign plant1top = negative1 ? 10'd191 + random_value1 : 10'd191 - random_value1;
       assign plant2top = negative2 ? 10'd191 + random_value2 : 10'd191 - random_value2;
       assign plant3top = negative3 ? 10'd191 + random_value3 : 10'd191 - random_value3;
                   
       //defines the active region of the display 
       wire is_in_active_region;
       assign is_in_active_region = ((x_pixel >= 10'd0000) && (x_pixel <= 10'd639) && (y_pixel >= 10'd000) && (y_pixel <= 10'd479));
       
       //frog module
       wire [3:0] draw_frog = (flash ? {4{flash_signal}} : 4'b1111) & {4{(is_in_active_region & ((x_pixel>=(10'd100)) && (x_pixel<=(10'd116)) && (y_pixel >= frog_y_coord) && (y_pixel <= frog_y_coord + 10'd16)))}};
       
       //plant draw module(s)
       wire [3:0] draw_plant_1;
       wire [3:0] draw_plant_2;
       wire [3:0] draw_plant_3;
       assign draw_plant_1 = {4{(is_in_active_region&(((x_pixel>=(plant_R_edge_1-10'd40)&&x_pixel<=plant_R_edge_1)||(x_pixel<plant_R_edge_1&&plant_R_edge_1<10'd40))&&(y_pixel>=plant1top)&&(y_pixel<=(plant1top+10'd96))))}};
       assign draw_plant_2 = {4{(is_in_active_region&(((x_pixel>=(plant_R_edge_2-10'd40)&&x_pixel<=plant_R_edge_2)||(x_pixel<plant_R_edge_2&&plant_R_edge_2<10'd40))&&(y_pixel>=plant2top)&&(y_pixel<=(plant2top+10'd96))))}};
       assign draw_plant_3 = {4{(is_in_active_region&(((x_pixel>=(plant_R_edge_3-10'd40)&&x_pixel<=plant_R_edge_3)||(x_pixel<plant_R_edge_3&&plant_R_edge_3<10'd40))&&(y_pixel>=plant3top)&&(y_pixel<=(plant3top+10'd96))))}};
       
       //ocean drawing
       wire [3:0] draw_ocean;
       assign draw_ocean = {4{is_in_active_region}}&
       (({4{y_pixel>=10'd240 & y_pixel<10'd256}} & 4'd15) | 
       ({4{y_pixel>=10'd256 & y_pixel<10'd272}} & 4'd14) |
       ({4{y_pixel>=10'd272 & y_pixel<10'd288}} & 4'd13) |
       ({4{y_pixel>=10'd288 & y_pixel<10'd304}} & 4'd12) |
       ({4{y_pixel>=10'd304 & y_pixel<10'd320}} & 4'd11) |
       ({4{y_pixel>=10'd320 & y_pixel<10'd336}} & 4'd10) |
       ({4{y_pixel>=10'd336 & y_pixel<10'd352}} & 4'd9) |
       ({4{y_pixel>=10'd352 & y_pixel<10'd368}} & 4'd8) |
       ({4{y_pixel>=10'd368 & y_pixel<10'd384}} & 4'd7) |
       ({4{y_pixel>=10'd384 & y_pixel<10'd400}} & 4'd6) |
       ({4{y_pixel>=10'd400 & y_pixel<10'd416}} & 4'd5) |
       ({4{y_pixel>=10'd416 & y_pixel<10'd432}} & 4'd4) |
       ({4{y_pixel>=10'd432 & y_pixel<10'd448}} & 4'd3) |
       ({4{y_pixel>=10'd448 & y_pixel<10'd464}} & 4'd2) | 
       ({4{y_pixel>=10'd464 & y_pixel<10'd480}} & 4'd1));       
       wire [3:0] black_ocean;
       assign black_ocean = 4'd0;
       //color assignment
       assign vgaBlue = (draw_frog & 4'd15) | ((draw_plant_1 | draw_plant_2 | draw_plant_3) ? (black_ocean) : (draw_ocean));
       
       assign vgaRed = (draw_frog & 4'd15);
       
       assign vgaGreen = (draw_frog & 4'd15)|(draw_plant_1&4'd15)|(draw_plant_2&4'd15)|(draw_plant_3&4'd15);
       
       //Collision detection, collision wire defined above
       collision_detection detect (.plant1left(plant_R_edge_1-10'd40), .plant1right(plant_R_edge_1), .plant1top(plant1top), .plant1bottom(plant1top + 10'd96),
       .plant2left(plant_R_edge_2-10'd40), .plant2right(plant_R_edge_2), .plant2top(plant2top), .plant2bottom(plant2top + 10'd96),
       .plant3left(plant_R_edge_3-10'd40), .plant3right(plant_R_edge_3), .plant3top(plant3top), .plant3bottom(plant3top + 10'd96),
       .frog_top(frog_y_coord), .frog_bottom(frog_y_coord + 10'd16), .frog_left(10'd100), .frog_right(10'd116), .inside(collision));
       
endmodule
