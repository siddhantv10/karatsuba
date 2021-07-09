`timescale 10ms / 1ms
`include "radix4approx34bit.v"

module radix4approx34bit_tb();


reg  unsigned [33 : 0]   x,y;

wire unsigned [67:0]   p;

integer i, out, seed=7;

radix4approx34bit uut(p,x,y);

initial begin
    $dumpfile("radix4approx34bit.vcd");
    $dumpvars(0, radix4approx34bit_tb);
    out = $fopen("radix4-approx-34bit-mult-result.csv");
    

    for(i=0; i<50; i=i+1)
        begin
        x = $urandom(seed);
        y = $urandom(seed);


        #1;
        $fwrite(out, "%d, %d, %d\n", x,y,p);
        #4;
    end
    $finish;
end
endmodule