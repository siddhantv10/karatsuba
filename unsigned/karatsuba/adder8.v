`timescale 10ms / 1ms

module adder8(s,a,b);

input [7:0] a,b;

output [8:0] s;


assign s = a+b;

endmodule