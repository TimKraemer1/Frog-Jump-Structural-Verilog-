`timescale 1ns / 1ps

module frog_movement_sm_logic(
    input btnU,
    input btnD,
    input btnL,
    input btnC,
    input reset_timer,
    input twosec,
    input collision,
    input [9:0] y_coord,
    input [7:0] PS,
    output [7:0] NS,
    output move_up,
    output move_down,
    output timer_on,
    output reset_plants,
    output flash,
    output reset_frog,
    output game_play,
    output flash_disp
    );
    
    wire IDLE, UP1, DW1, UP2, DW2, START, TIMER, STOP;
    wire IDLE_next, UP1_next, DW1_next, UP2_next, DW2_next, START_next, TIMER_next, STOP_next;
    
    //defines the y_coordinate of the top left corner of the frog when it is in the center
    wire [9:0] frog_center;
    assign frog_center = 10'd231;
    
    //defines the y_coordinate of the highest and lowest point the frog top edge can jump
    wire [9:0] top_edge;
    assign top_edge = 10'd135;
    wire [9:0] bottom_edge;
    assign bottom_edge = 10'd327;
    
    //1 if the frog reached the upper boundary, 0 if it didnt
    wire upper_bound;
    assign upper_bound = (y_coord <= top_edge);
    
    //1 if the frog reached the lower boundary, 0 if it didnt 
    wire lower_bound;
    assign lower_bound = (y_coord >= bottom_edge);
    
    //1 if the frog reached the center, 0 if it didnt
    wire center;
    assign center = (y_coord == frog_center);
    
    assign IDLE = PS[0];
    assign UP1 = PS[1];
    assign DW1 = PS[2];
    assign DW2 = PS[3];
    assign UP2 = PS[4];
    assign START = PS[5];
    assign TIMER = PS[6];
    assign STOP = PS[7];
    
    assign NS[0] = IDLE_next;
    assign NS[1] = UP1_next;
    assign NS[2] = DW1_next;
    assign NS[3] = DW2_next;
    assign NS[4] = UP2_next;
    assign NS[5] = START_next;
    assign NS[6] = TIMER_next;
    assign NS[7] = STOP_next;
    
    assign IDLE_next = (IDLE & !btnD & !btnU & !collision) | (UP2 & center) | (DW1 & center) | (TIMER & twosec);
    assign UP1_next = (IDLE & btnU) | (UP1 & !upper_bound & !collision);
    assign DW1_next = (UP1 & upper_bound) | (DW1 & !center & !collision);
    assign DW2_next = (IDLE & btnD) | (DW2 & !lower_bound & !collision);
    assign UP2_next = (DW2 & lower_bound) | (UP2 & !center & !collision);
    assign TIMER_next = (START & btnC) | (TIMER & !twosec) | (STOP & btnC);
    assign START_next = START & !btnC;
    assign STOP_next = (UP1 & collision) | (UP2 & collision) | (DW1 & collision) | (DW2 & collision) | (IDLE & collision) | (STOP & collision & !btnC);
    
    assign move_up = UP1 | UP2;
    assign move_down = DW1 | DW2;
    assign reset_timer = (START & btnC) | (STOP & btnC);
    assign timer_on = TIMER;
    assign reset_plants = STOP & btnC;
    assign reset_frog = STOP & btnC;
    assign game_play = IDLE | UP1 | UP2 | DW1 | DW2;
    assign flash = TIMER | STOP;
    assign flash_disp = STOP;
    
endmodule
