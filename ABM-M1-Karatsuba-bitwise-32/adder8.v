`timescale 10ms / 1ms

module adder8(s,a,b);

input [15:0] a,b;

output [16:0] s;


assign s = a+b;

endmodule