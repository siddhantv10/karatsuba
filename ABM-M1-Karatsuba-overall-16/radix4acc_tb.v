`timescale 10ms / 1ms
`include "radix4acc.v"

module radix4acc_tb();


reg   [7 : 0]   x,y;

wire  [15:0]   p;

radix4acc uut(p,x,y);

initial begin
    $dumpfile("radix4acc.vcd");
    $dumpvars(0, radix4acc_tb);

    x = 125; y = 103; #20;
    x = -114; y = 50; #20;
    x = 123; y = 96; #20;
    
    $finish;
end
endmodule