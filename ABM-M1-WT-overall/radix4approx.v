`timescale 10ms / 1ms

module radix4approx(p,x,y);         //16 bit multiplier to give 32 bit product

parameter N = 8;   //size of muliplicant and multiplier
parameter K = N/2;  //

input   [N-1 : 0]   x,y;
output  [N+N-1:0]   p;

reg [2:0]   bits    [K-1:0];
//reg [2:0]   MBE     [K-1:0];


reg [N:0]       PP      [K-1:0];
reg [N+N-1:0]   ACC     [K-1:0];
reg [N+N-1:0]   ANS;

integer i , j;

wire [N:0] xbar;
assign xbar = {~x[N-1], ~x} + 1'b1;         //2's complement retaining the sign bit

always@(*)

begin
    bits[0] = {y[1],y[0],1'b0};             //setting last bit -1 as 0

    for(i=1; i<K; i=i+1)
        bits[i] = {y[2*i+1], y[2*i], y[2*i-1]};


    for(i=0; i<K; i=i+1)
        begin
            case(bits[i])

            //3'b000, 3'b111: MBE[i] = 3'b001;

            3'b001, 3'b010, 3'b011:         //adding the case of +2A 
            begin
                //MBE[i] = 3'b000; 
                PP[i] = {x[N-1], x};
            end

            
            3'b101, 3'b110, 3'b100:         //adding the case of -2A
            begin 
                //MBE[i] = 3'b100;
                PP[i] = xbar;
            end
         
            default: 
            begin
                //MBE[i] = 3'b001;
                PP[i]  = 0;
            end

            endcase

            ACC[i] = $signed(PP[i]);        //sign extension

            for(j=0; j<i; j=j+1)
                ACC[i] = {ACC[i],2'b00};        //shifting

        
        end

    ANS = ACC[0];

    for(i=1; i<K; i=i+1)
        ANS = ANS+ACC[i];

    ANS[7:2] = 1'b1;            //hybrid approximation
    //ANS = {ANS[N+N-1],ANS[N+N-3:0],1'b0};
        
end


assign p = ANS;

endmodule
    