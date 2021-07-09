`timescale 10ms / 1ms
`include "WT16.v"

module WT16_tb();

reg [15:0] A,B;
wire [31:0] P;


WT16 uut(P,A,B);

initial begin
    $dumpfile("WT16.vcd");
    $dumpvars(0, WT16_tb);

    A = 20345; B = 7654; #20;
    
    A = -29123; B = 8574; #20;
    
    A = -6589; B = -24321; #20;
    
    A = 10670; B = 21921; #20;
    
    A = 11548; B = -30105; #20;
    
    $finish;
end

endmodule