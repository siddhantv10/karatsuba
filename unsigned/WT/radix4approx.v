`timescale 10ms / 1ms

module radix4approx(p,x,y);         //16 bit multiplier to give 32 bit product

parameter N = 8;   //size of muliplicant and multiplier
parameter K = N/2;  //

input   [N-1 : 0]   x,y;
output  [N+N-1:0]   p;

reg [2:0]   bits    [K-1:0];
reg   neg     [K-1:0];
reg   two     [K-1:0];
reg   zero     [K-1:0];


reg [N:0]       PP      [K-1:0];
reg [N+N-1:0]   ACC     [K-1:0];
reg [N+N-1:0]   ANS;
reg mux;

integer i , j, t,m=6;

wire [N:0] xbar;
assign xbar = {~x[N-1], ~x} + 1'b1;         //2's complement retaining the sign bit

always@(*)

begin
    bits[0] = {y[1],y[0],1'b0};             //setting last bit -1 as 0

    for(i=1; i<K; i=i+1)
        bits[i] = {y[2*i+1], y[2*i], y[2*i-1]};


    for(i=0; i<K; i=i+1)
        begin                               //approximated 2A as A introduced error
            case(bits[i])

            
            3'b001, 3'b010:         
            begin
                neg[i] = 1'b0;
                two[i] = 1'b0;
                zero[i] = 1'b0;
            end

            3'b011:
            begin
                neg[i] = 1'b0;
                two[i] = 1'b1;
                zero[i] = 1'b0;
            end

            3'b101, 3'b110:         
            begin 
               neg[i] = 1'b1;
                two[i] = 1'b0;
                zero[i] = 1'b0;
            end

            3'b100:
            begin
                neg[i] = 1'b1;
                two[i] = 1'b1;
                zero[i] = 1'b0;
            end
         
            default: 
            begin
                neg[i] = 1'b0;
                two[i] = 1'b0;
                zero[i] = 1'b1;
            end

            endcase

            PP[i] = 0;
            PP[i][N] = x[N-1]^neg[i];           //sign conservation

            for(t=0; t<N; t=t+1) begin
                if(t>=m) 
                begin
                    mux = (x[t] & ~two[i]) | (x[t-1] & two[i]);             
                    PP[i][t] = ~zero[i] & (neg[i] ^ mux);
                end

                else 
                begin
                    PP[i][t] = (~x[t] & neg[i]) | (x[t] & ~neg[i] & ~zero[i]);
                end
            end

            PP[i][0] = PP[i][0] | neg[i];

            ACC[i] = $signed(PP[i]);        //sign extension
            
            for(j=0; j<i; j=j+1)
                ACC[i] = {ACC[i],2'b00};        //shifting

        
        end

    ANS = ACC[0];

    for(i=1; i<K; i=i+1)
        ANS = ANS+ACC[i];
        
end


assign p = ANS;

endmodule
    