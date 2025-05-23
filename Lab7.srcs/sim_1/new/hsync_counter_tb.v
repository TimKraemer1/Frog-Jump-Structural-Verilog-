`timescale 1ns / 1ps

module hsync_vsync_counter_tb();

reg clkin;
reg btnR;
wire [3:0] vgaRed;
wire [3:0] vgaBlue;
wire [3:0] vgaGreen;
wire Hsync;
wire Vsync;

test test1 (.clkin(clkin), .btnR(btnR), .vgaRed(vgaRed), .vgaBlue(vgaBlue), .vgaGreen(vgaGreen), .Hsync(Hsync), .Vsync(Vsync));

parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;

    initial    // Clock process for clkin
    begin
        #OFFSET
		  clkin = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;
        end
    end
    

initial
begin

btnR = 1'b0;


end

endmodule
