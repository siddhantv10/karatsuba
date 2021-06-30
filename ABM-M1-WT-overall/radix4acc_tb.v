`timescale 10ms / 1ms
`include "radix4acc.v"

module radix4acc_tb();


reg  unsigned [7 : 0]   x,y;

wire unsigned [15:0]   p;

integer i, out, seed=7;

radix4acc uut(p,x,y);

initial begin
    $dumpfile("radix4acc.vcd");
    $dumpvars(0, radix4acc_tb);
    out = $fopen("accurate-mult.csv");

    for(i=0; i<500; i=i+1)
    begin
        x = $urandom(seed) %255;
        y = $urandom(seed) %255;
        #1;
        $fwrite(out, "%d, %d, %d\n", x,y,p);
        #4;
    end
    $finish;
end
endmodule