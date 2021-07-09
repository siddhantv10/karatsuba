`timescale 10ms / 1ms
`include "WT64.v"

module WT64_tb();

reg unsigned [63:0] A,B;
wire unsigned [127:0] P;
integer i, out, seed=7;


WT64 uut(P,A,B);


initial begin
    $dumpfile("WT64.vcd");
    $dumpvars(0, WT64_tb);
    out = $fopen("WT64output.csv");
    
    for(i=0; i<500; i=i+1)
    begin
        A = {2{$urandom(seed)}};
        B = {2{$urandom(seed)}};
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end
    $finish;
end

endmodule