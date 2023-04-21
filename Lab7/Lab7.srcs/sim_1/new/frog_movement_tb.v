`timescale 1ns / 1ps

module frog_movement_tb();

reg frame;
reg move_up;
reg move_down;
wire [9:0] current_pos;

frog_movement move (.frame(frame), .move_up(move_up), .move_down(move_down), .current_pos(current_pos));

initial begin
    frame = 0;
    forever
        #100 frame = ~frame;
end

initial
begin

frame = 1'b0;
move_up = 3'b000;
move_down = 3'b000;

#2000;

move_up = 3'b111;
#3200;
move_up = 3'b000;

#200;

move_down = 3'b111;
#3200;
move_down = 3'b000;

end
endmodule
