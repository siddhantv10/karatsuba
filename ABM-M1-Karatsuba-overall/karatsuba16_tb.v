`timescale 10ms / 1ms
`include "karatsuba16.v"

module karatsuba16_tb();

reg signed [15:0] A,B;
wire signed [31:0] P;
integer i, out, seed=7;


karatsuba16 uut(P,A,B);


initial begin
    $dumpfile("karatsuba16.vcd");
    $dumpvars(0, karatsuba16_tb);
    out = $fopen("output.csv");
    
    for(i=0; i<10; i=i+1)
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