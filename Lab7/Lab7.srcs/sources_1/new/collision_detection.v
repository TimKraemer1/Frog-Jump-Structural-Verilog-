`timescale 1ns / 1ps

module collision_detection(

    input [9:0] plant1left,
    input [9:0] plant1right,
    input [9:0] plant1top,
    input [9:0] plant1bottom,

    input [9:0] plant2left, 
    input [9:0] plant2right,
    input [9:0] plant2top,
    input [9:0] plant2bottom,

    input [9:0] plant3left,
    input [9:0] plant3right,
    input [9:0] plant3top,
    input [9:0] plant3bottom,

    input [9:0] frog_top,
    input [9:0] frog_bottom,
    input [9:0] frog_left,
    input [9:0] frog_right,
    output inside
);

wire inside_plant1, inside_plant2, inside_plant3;
assign inside_plant1 = (((frog_top > plant1top) & (frog_top < plant1bottom)) | ((frog_bottom > plant1top) & (frog_bottom < plant1bottom))) & 
                        (((frog_left > plant1left) & (frog_left < plant1right)) | ((frog_right > plant1left) & (frog_right < plant1right)));
                        
assign inside_plant2 = (((frog_top > plant2top) & (frog_top < plant2bottom)) | ((frog_bottom > plant2top) & (frog_bottom < plant2bottom))) & 
                        (((frog_left > plant2left) & (frog_left < plant2right)) | ((frog_right > plant2left) & (frog_right < plant2right)));

assign inside_plant3 = (((frog_top > plant3top) & (frog_top < plant3bottom)) | ((frog_bottom > plant3top) & (frog_bottom < plant3bottom))) & 
                        (((frog_left > plant3left) & (frog_left < plant3right)) | ((frog_right > plant3left) & (frog_right < plant3right)));
                        
assign inside = inside_plant1 | inside_plant2 | inside_plant3;
endmodule
