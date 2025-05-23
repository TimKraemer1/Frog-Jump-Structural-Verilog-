`timescale 1ns / 1ps

module plant_mov_test();

reg clk;
wire [3:0] out;
wire reset;

wire [3:0] reg_out;
wire [3:0] adder_out;
wire [3:0] mux_out;

assign mux_out = reset ? 4'b1111 : adder_out;

FDRE #(.INIT(1'b1) ) ff_1 (.C(clk), .CE(1'b1), .D(mux_out[0]), .Q(reg_out[0]));
FDRE #(.INIT(1'b1) ) ff_2 (.C(clk), .CE(1'b1), .D(mux_out[1]), .Q(reg_out[1]));
FDRE #(.INIT(1'b1) ) ff_3 (.C(clk), .CE(1'b1), .D(mux_out[2]), .Q(reg_out[2]));
FDRE #(.INIT(1'b1) ) ff_4 (.C(clk), .CE(1'b1), .D(mux_out[3]), .Q(reg_out[3]));

assign adder_out = reg_out - 4'd1;
assign reset = !reg_out[0] & !reg_out[1] & !reg_out[2] & !reg_out[3];
assign out = reg_out;

initial begin
    clk = 0;
    forever 
         #10 clk = ~clk;
end

initial
begin

end

endmodule
