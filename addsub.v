module addsub( 
   input wire [15:0] A, 
   input wire [15:0] B, 
   input wire Add_Sub, 
   output [15:0] result 
 ); //wire 
   wire [15:0] B_in; 
   wire [15:0] B_select; 
   //combination 
   assign B_in = (~B) + 1; 
   assign B_select = Add_Sub ? B : B_in; 
   assign result = A + B_select; 
endmodule 
