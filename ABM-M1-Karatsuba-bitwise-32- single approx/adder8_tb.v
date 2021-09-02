`timescale 10ms / 1ms
`include "adder8.v"

module adder8_tb();


reg [7:0] a,b;

wire [8:0]  s;

adder8 uut(s,a,b);

initial begin
    $dumpfile("adder8.vcd");
    $dumpvars(0,adder8_tb);

    a = 127; b = 64; #20;
    a = 124; b = 76; #20;
    a = 118; b = 99; #20;

    $finish;
end

endmodule