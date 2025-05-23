`timescale 1ns / 1ps

module multiplexer8(
    input [7:0] in,
    input [2:0] s,
    output o
    );
    
    assign o = (!s[2] & !s[1] & !s[0] & in[0]) | (!s[2] & !s[1] & s[0] & in[1]) | (!s[2] & s[1] & !s[0] & in[2]) | (!s[2] & s[1] & s[0] & in[3]) | (s[2] & !s[1] & !s[0] & in[4]) | (s[2] & !s[1] & s[0] & in[5]) | (s[2] & s[1] & !s[0] & in[6]) | (s[2] & s[1] & s[0] & in[7]);
    
endmodule
