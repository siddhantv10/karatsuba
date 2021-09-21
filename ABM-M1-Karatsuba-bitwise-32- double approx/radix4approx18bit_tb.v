`timescale 10ms / 1ms
`include "radix4approx18bit.v"

module radix4approx18bit_tb();


reg  unsigned [17 : 0]   x,y;

wire unsigned [35:0]   p;

integer i, out, seed=7;

radix4approx18bit uut(p,x,y);

initial begin
    $dumpfile("radix4approx18bit.vcd");
    $dumpvars(0, radix4approx18bit_tb);
    out = $fopen("radix4-approx-18bit-mult-result.csv");
    
        x = 2;
        y = 2881;


        #1;
        $fwrite(out, "%d, %d, %d\n", x,y,p);

    /*for(i=0; i<50; i=i+1)
        begin
        x = $urandom(seed) %262143;
        y = $urandom(seed) %262143;


        #1;
        $fwrite(out, "%d, %d, %d\n", x,y,p);
        #4;
    end
    */
    $finish;
end
endmodule