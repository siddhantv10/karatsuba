`timescale 10ms/1ms
`include "radix4acc.v"
`include "radix4approx.v"
`include "radix4approx10bit.v"
`include "adder8.v"

module karatsuba16(P,A,B);


parameter N = 16;   //size of muliplicant and multiplier
parameter K = N/2;  //

input   [N-1 : 0]   A,B;
output  [N+N-1:0]   P;

wire [K-1:0] AH, AL, BH, BL;

wire reg    [N-1:0]     M1, M2;
wire reg    [K:0]       S1, S2;
wire reg    [9:0]       c,d;
wire reg    [19:0]      M3;

reg [19:0] M4, M5, M6;

reg     [19:0]   A1, A2, A3;


reg [N+N-1:0]   ACC     [2:0];
reg [N+N-1:0] ANS;
integer i;


assign AH = A[N-1:K];
assign AL = A[K-1:0];

assign BH = B[N-1:K];
assign BL = B[K-1:0];



radix4acc ACC1(.p(M1), .x(AH), .y(BH));
radix4approx APP1(.p(M2), .x(AL), .y(BL));


adder8 ADD1(.s(S1), .a(AH), .b(AL));
adder8 ADD2(.s(S2), .a(BH), .b(BL));

assign c = (S1);
assign d = (S2);

radix4approx10bit APP2(.p(M3), .x(c), .y(d));


always@(*)
begin
    
    M4 = $signed(M1);
    M5 = $signed(M2);
    
    M6 = M3 - M4 - M5;

    ACC[0] = $signed(M6);
    ACC[0] = {ACC[0], {8{1'b0}}};

    ACC[1] = $signed(M2);
    
    ACC[2] = $signed(M1);
    ACC[2] = {ACC[2], {16{1'b0}}};

    ANS = ACC[0];
    for(i=1; i<3; i=i+1)
        ANS = ANS+ACC[i];
end

assign P = ANS;

endmodule

