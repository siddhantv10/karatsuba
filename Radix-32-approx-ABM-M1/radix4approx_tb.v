`timescale 10ms / 1ms
`include "radix4approx.v"

module radix4approx_tb();

reg unsigned [31:0] A,B;
wire unsigned [63:0] P;
integer i, out, seed=7;


radix4approx uut(P,A,B);


initial begin
    $dumpfile("radix4approx.vcd");
    $dumpvars(0, radix4approx_tb);
    out = $fopen("testing.csv");

    for(i=0; i<100; i=i+1)                       //10 test cases A and B: 1-100 
    begin
        A = $urandom(seed) %200 + 65536;
        B = $urandom(seed) %200;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end

    for(i=0; i<100; i=i+1)                       //10 test cases A: 1-100 B: till 2^15
    begin
        A = $urandom(seed) %200;
        B = $urandom(seed) %32768 + 65536;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end

    for(i=0; i<100; i=i+1)                       //10 test cases B: 1-100 A: till 2^32
    begin
        A = $urandom(seed) %4294967295;
        B = $urandom(seed) %200 + 1024;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end


    for(i=0; i<200; i=i+1)                       //50 cases : till 1024 A: 2^10 B: 2^20
    begin
        A = $urandom(seed) %1024;
        B = $urandom(seed) %1048576;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end

    for(i=0; i<500; i=i+1)                       //500 cases : till 32768 which is 2^15
    begin
        A = $urandom(seed) %65536 + 65536;
        B = $urandom(seed) %32768;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end

    for(i=0; i<500; i=i+1)                       //500 cases : till 2^20
    begin
        A = $urandom(seed) %1048576;
        B = $urandom(seed) %1048576;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end

    for(i=0; i<500; i=i+1)                       //50 cases : till 1024 A: 2^32 B: 2^20
    begin
        A = $urandom(seed) %4294967295;
        B = $urandom(seed) %1048576;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
    end

    for(i=0; i<500; i=i+1)                          //50 cases till 2^32
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