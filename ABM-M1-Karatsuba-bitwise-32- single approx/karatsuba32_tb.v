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
    out = $fopen("single-results.csv");

/*
        A = 65536;
        B = 18;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;

        A = 48584;
        B = 54471;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;

        A = 128420;
        B = 61995;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;

        A = 52843;
        B = 248135;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;

        A = 119167;
        B = 120565;
        #1;
        $fwrite(out, "%d, %d, %d\n", A,B,P);
        #4;
*/

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
        B = $urandom(seed) %200 + 65535;
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