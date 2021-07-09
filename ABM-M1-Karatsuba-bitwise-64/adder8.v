`timescale 10ms / 1ms

module adder8(s,a,b);

input [31:0] a,b;

output [32:0] s;


assign s = a+b;

endmodule