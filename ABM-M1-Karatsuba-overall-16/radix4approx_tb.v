`timescale 10ms / 1ms
`include "radix4approx.v"

module radix4approx_tb();


reg   [7 : 0]   x,y;

wire  [15:0]   p;

radix4approx uut(p,x,y);

initial begin
    $dumpfile("radix4approx.vcd");
    $dumpvars(0, radix4approx_tb);

    x = 94; y = 103; #20;
    x = -114; y = 83; #20;
    x = 125; y = 116; #20;
    
    $finish;
end
endmodule