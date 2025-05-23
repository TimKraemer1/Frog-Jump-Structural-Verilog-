`timescale 1ns / 1ps

module LFSR_test();

reg clk;
reg CE;
wire [4:0] rand_val;
wire negative;

LFSR rand(.clk(clk), .CE(CE), .rand_val(rand_val), .negative(negative));

initial begin
    clk = 0;
    forever 
         #10 clk = ~clk;
end

initial
begin

CE = 1'b0;
#505;
CE = 1'b1;
#20;
CE = 1'b0;
#20;
CE = 1'b1;
#20;
CE = 1'b0;
#20;
CE = 1'b1;
#20;
CE = 1'b0;
#20;
CE = 1'b1;
#20;
CE = 1'b0;
#20;
CE = 1'b1;
#20;
CE = 1'b0;
#20;
CE = 1'b1;
#20;
CE = 1'b0;
#20;
CE = 1'b1;
#20;
CE = 1'b0;
#20;
CE = 1'b1;
#20;
CE = 1'b0;

end

endmodule
