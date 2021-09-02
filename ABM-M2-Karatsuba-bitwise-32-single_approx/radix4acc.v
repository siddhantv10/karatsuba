`timescale 10ms / 1ms

module radix4acc(p,x,y);         //8 bit multiplier to give 16 bit product

parameter N = 16;   //size of muliplicant and multiplier
parameter K = N/2;  //

input [N-1 : 0]   x,y;
output [N+N-1:0]   p;

reg [2:0]   bits    [K:0];
reg   neg     [K:0];
reg   two     [K:0];
reg   zero     [K:0];

wire [N+1:0] x_new;
reg [N+1:0]       PP      [K:0]; //riyaj 
reg [N+N-1:0]   ACC     [K:0];
reg [N+N-1:0]   ANS;
reg mux;

integer i , j, t;

assign x_new = {2'b0,x};

always@(*)

begin
    bits[0] = {y[1],y[0],1'b0};             //setting last bit -1 as 0
    //$display("%b", bits[0]);
    for(i=1; i<K+1; i=i+1) begin
        if(i == K)
            bits[i] = {2'b0,y[2*i-1]};
        else
            bits[i] = {y[2*i+1], y[2*i], y[2*i-1]};
        //$display("%b", bits[i]);
        
    end

    for(i=0; i<K+1; i=i+1)
        begin                                      //accurate cases
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
            
            //$display("%b %b %b", neg[i], two[i], zero[i]);
            
            PP[i] = 0;
            PP[i][N+1] = neg[i];           //sign conservation

            for(t=0; t<N+1; t=t+1) begin
                if(t==0) 
                    mux = (x_new[t] & ~two[i]) | (1'b0 & two[i]);
                
                else
                    mux = (x_new[t] & ~two[i]) | (x_new[t-1] & two[i]);

                
                PP[i][t] = ~zero[i] & (neg[i] ^ mux);       
            end

            PP[i] = PP[i] + neg[i];             //correction term added
            
            //$display("%b", PP[i]);

            ACC[i] = $signed(PP[i]);        //sign extension
            //$display("%b", ACC[i]);

            for(j=0; j<i; j=j+1)
                ACC[i] = {ACC[i],2'b00};        //shifting

        
        end

    ANS = ACC[0];

    for(i=1; i<K+1; i=i+1)
        ANS = ANS+ACC[i];
        
    
end


assign p = ANS;

endmodule
    