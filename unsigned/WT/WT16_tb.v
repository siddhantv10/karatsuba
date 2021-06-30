`timescale 10ms / 1ms
`include "WT16.v"

module WT16_tb();

reg signed [15:0] A,B;
wire signed [31:0] P;
integer i, out, seed=7;


WT16 uut(P,A,B);


initial begin
    $dumpfile("WT16.vcd");
    $dumpvars(0, WT16_tb);
    out = $fopen("WT16output.csv");
    
    for(i=0; i<500; i=i+1)
    begin
        A = $random(seed) %32767;
        B = $random(seed) %32767;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end
    $finish;
end

endmodule