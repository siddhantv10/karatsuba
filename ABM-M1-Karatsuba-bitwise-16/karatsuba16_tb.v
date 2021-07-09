`timescale 10ms / 1ms
`include "karatsuba16.v"

module karatsuba16_tb();

reg unsigned [15:0] A,B;
wire unsigned [31:0] P;
integer i, out, seed=7;


karatsuba16 uut(P,A,B);


initial begin
    $dumpfile("karatsuba16.vcd");
    $dumpvars(0, karatsuba16_tb);
    out = $fopen("karatsuba_output.csv");
    
    for(i=0; i<500; i=i+1)
    begin
        A = $urandom(seed) %65535;
        B = $urandom(seed) %65535;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end
    
    $finish;
end




endmodule