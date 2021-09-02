`timescale 10ms / 1ms
`include "karatsuba32.v"

module karatsuba32_tb();

reg unsigned [31:0] A,B;
wire unsigned [63:0] P;
integer i, out, seed=7;


karatsuba32 uut(P,A,B);


initial begin
    $dumpfile("karatsuba32.vcd");
    $dumpvars(0, karatsuba32_tb);
    out = $fopen("karatsuba_output.csv");
    
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