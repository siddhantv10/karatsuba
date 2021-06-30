`timescale 10ms / 1ms
`include "radix4approx10bit.v"

module radix4approx10bit_tb();


reg   [9 : 0]   x,y;

wire  [19:0]   p;

radix4approx10bit uut(p,x,y);

initial begin
    $dumpfile("radix4approx10bit.vcd");
    $dumpvars(0, radix4approx10bit_tb);

    x = 440; y = 503; #20;
    x = -494; y = 483; #20;
    x = 325; y = 416; #20;
    
    $finish;
end
endmodule