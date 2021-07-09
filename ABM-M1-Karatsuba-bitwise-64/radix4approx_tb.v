`timescale 10ms / 1ms
`include "radix4approx.v"

module radix4approx_tb();


reg  unsigned [15 : 0]   x,y;

wire unsigned [31:0]   p;

integer i, out, seed=7;

radix4approx uut(p,x,y);

initial begin
    $dumpfile("radix4approx.vcd");
    $dumpvars(0, radix4approx_tb);
    out = $fopen("radix4-approx-mult-result.csv");
    

    for(i=0; i<50; i=i+1)
        begin
        x = $urandom(seed) %65535;
        y = $urandom(seed) %65535;


        #1;
        $fwrite(out, "%d, %d, %d\n", x,y,p);
        #4;
    end
    $finish;
end
endmodule