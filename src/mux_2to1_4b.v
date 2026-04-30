// Code your design here
/*
* Instituto Tecnológico de Costa Rica
* Prof. Dr.-ing. Pablo Mendoza Ponce
* Rev. 1 28 July 2024
*/

`timescale 1ns/1ps

module mux_2to1_4b(
    input  [3:0] a_i,
    input  [3:0] b_i,
    input        s_i,
    output reg [3:0] q_o
);

    always @(*) begin
        if(s_i == 1'b0)
            q_o = a_i;
        else
            q_o = b_i;
    end

endmodule