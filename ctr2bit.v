module ctr2bit( 
  input wire clk, 
  input wire clear,  
  output reg [1:0] state 
 ); 
   always @(posedge clk) begin 
     if (clear) begin 
       state <= 2'b00; 
     end 
     else begin 
       if (state == 2'b11) begin 
         state <= 2'b00; 
       end 
       else begin 
         state <= state + 1; 
       end 
     end 
   end 
endmodule 
