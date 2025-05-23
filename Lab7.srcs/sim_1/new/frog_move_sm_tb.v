`timescale 1ns / 1ps

module frog_move_sm_tb();

reg clk;
reg btnU;
reg btnL;
reg btnD;
reg reset_timer;
reg twosec;
reg collision;
reg [9:0] y_coord;
wire move_up;
wire move_down;
wire timer_on;

frog_movement_sm i_hate_myself (.collision(collision), .btnL(btnL), .reset_timer(reset_timer), .timer_on(timer_on), .clk(clk), .y_coord(y_coord), .move_up(move_up), .move_down(move_down),
.btnU(btnU), .twosec(twosec), .btnD(btnD));

initial begin
    clk = 0;
    forever 
         #10 clk = ~clk;
end
 
 initial
 begin

btnL = 1'b0;
btnD = 1'b0;
reset_timer = 1'b0;
twosec = 1'b0;
btnU = 1'b0;
collision = 1'b0;
y_coord = 10'd231;

#2000;

btnL = 1'b1;
#50;
btnL = 1'b0;
#200;
twosec = 1'b1;
#50;
twosec = 1'b0;
#100;
btnU = 1'b1;
#100;
collision = 1'b1;

 end

endmodule
