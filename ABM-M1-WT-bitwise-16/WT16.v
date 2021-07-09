`timescale 10ms/1ms
`include "radix4acc.v"
`include "radix4approx.v"

module WT16(P,A,B);


parameter N = 16;   //size of muliplicant and multiplier
parameter K = N/2;  //

input   [N-1 : 0]   A,B;
output  [N+N-1:0]   P;

wire [K-1:0] AH, AL, BH, BL;

wire reg [N-1:0] M1, M2, M3, M4;

reg     [N:0]   A1, A2, A3;

reg [N+N-1:0]   ACC     [2:0];
reg [N+N-1:0] ANS;
integer i;


assign AH = A[N-1:K];
assign AL = A[K-1:0];

assign BH = B[N-1:K];
assign BL = B[K-1:0];

radix4approx APP1(.p(M1), .x(AL), .y(BL));

radix4acc ACC1(.p(M2), .x(AH), .y(BH));

radix4approx APP2(.p(M3), .x(AH), .y(BL));
radix4approx APP3(.p(M4), .x(AL), .y(BH));


always@(*)
begin

    A1 =  M3+M4;
    ACC[0] = $signed(A1);
    ACC[0] = {ACC[0], {8{1'b0}}};

    A2 = M1;
    ACC[1] = $signed(A2);
    
    A3 = M2;
    ACC[2] = $signed(A3);
    ACC[2] = {ACC[2], {16{1'b0}}};

    ANS = ACC[0];
    for(i=1; i<3; i=i+1)
        ANS = ANS+ACC[i];

    
end

assign P = ANS;

endmodule

