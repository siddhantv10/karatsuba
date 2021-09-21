`timescale 10ms / 1ms

module radix4approx18bit(p,x,y);         

parameter N = 18;   //size of muliplicant and multiplier
parameter K = N/2;  //

input   [N-1 : 0]   x,y;
output  [N+N-1:0]   p;

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
integer  m = 16;        //number of bits to approximate

assign x_new = {2'b0,x};

always@(*)

begin
    //$display("---Middle mult------");
    
    //$display("X= %b",x);
    //$display("X New= %b",x_new);
    //$display("Y= %b",y);
    
    //$display("------");
    
    bits[0] = {y[1],y[0],1'b0};             //setting last bit -1 as 0
    /*$display("Bits(0)= %b",bits[0]);
    $display("------");
    */
    for(i=1; i<K+1; i=i+1) begin
            if(i == K)
                bits[i] = {2'b0,y[2*i-1]};
            else
                bits[i] = {y[2*i+1], y[2*i], y[2*i-1]};
            //$display("%b", bits[i]);

            //$display("Bits(%d)= %b",i,bits[i]);
            //$display("------");
            
        end

    //$display("Bits= %b",bits);    
    /*$display("BH= %b", BH);    
    $display("BL= %b",BL);    
    $display("M1= %b",M1);    
    $display("M2= %b",M2);    
    $display("S1= %b",S1);
    $display("S2= %b",S2);    
    $display("M3= %b",M3);    
    $display("---------");
    */

    for(i=0; i<K+1; i=i+1)
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
            PP[i][N+1] = neg[i];           //sign conservation

            for(t=0; t<N+1; t=t+1) begin
                if(t>=m) 
                begin
                    mux = (x_new[t] & ~two[i]) | (x_new[t-1] & two[i]);             
                    PP[i][t] = ~zero[i] & (neg[i] ^ mux);
                end

                else 
                begin
                    PP[i][t] = (~x_new[t] & neg[i]) | (x_new[t] & ~neg[i] & ~zero[i]);
                end

                
            end

            //$display("PP before (%d)= %b",i,PP[i]);
            //$display("------");


            //add neg[i]    
            PP[i] = PP[i] + neg[i];

            //$display("middle mult PP after (%d)= %b",i,PP[i]);
            //$display("------");

            ACC[i] = $signed(PP[i]);        //sign extension
            
            for(j=0; j<i; j=j+1)
                ACC[i] = {ACC[i],2'b00};        //shifting

            //$display("ACC(%d)= %b",i,ACC[i]);
            //$display("------");
        end

    ANS = ACC[0];
    //$display("ANS(0)= %b",ANS[0]);
    //$display("------");

    for(i=1; i<K+1; i=i+1)
    begin
        ANS = ANS+ACC[i];
        //$display("ANS(%d)= %b",i,ANS[i]);
        //$display("------");
    end
       
        
end


assign p = ANS;


endmodule
    