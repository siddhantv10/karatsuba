`timescale 10ms / 1ms
`include "radix4approx10bit.v"

module radix4approx10bit_tb();


reg  unsigned [9 : 0]   x,y;

wire unsigned [19:0]   p;

integer i, out, seed=7;

radix4approx10bit uut(p,x,y);

initial begin
    $dumpfile("radix4approx10bit.vcd");
    $dumpvars(0, radix4approx10bit_tb);
    out = $fopen("radix4-approx-10bit-mult-result.csv");
    

    for(i=0; i<50; i=i+1)
        begin
        x = $urandom(seed) %1023;
        y = $urandom(seed) %1023;


        #1;
        $fwrite(out, "%d, %d, %d\n", x,y,p);
        #4;
    end
    $finish;
end
endmodule