`timescale 10ms / 1ms
`include "radix4approx.v"

module radix4approx_tb();               //M2

reg unsigned [31:0] A,B;
wire unsigned [63:0] P;
integer i, out, seed=7;


radix4approx uut(P,A,B);


initial begin
    $dumpfile("radix4approx.vcd");
    $dumpvars(0, radix4approx_tb);
    out = $fopen("radix4approxoutput.csv");
    
    for(i=0; i<50; i=i+1)
    begin
        A = $urandom(seed) %4294967295;
        B = $urandom(seed) %4294967295;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end
    $finish;
end

endmodule