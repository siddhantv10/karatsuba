`timescale 10ms / 1ms
`include "WT32.v"

module WT32_tb();

reg unsigned [31:0] A,B;
wire unsigned [63:0] P;
integer i, out, seed=7;


WT32 uut(P,A,B);


initial begin
    $dumpfile("WT32.vcd");
    $dumpvars(0, WT32_tb);
    out = $fopen("WT32output.csv");
    
    for(i=0; i<500; i=i+1)
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