module mux10to1( 
  input wire din_en, 
  input wire gout, 
  input wire [2:0] rout, 
  input wire [15:0] din, 
  input wire [15:0] r0,
  input wire [15:0] r1, 
  input wire [15:0] r2, 
  input wire [15:0] r3, 
  input wire [15:0] r4, 
  input wire [15:0] r5, 
  input wire [15:0] r6, 
  input wire [15:0] r7, 
  input wire [15:0] aluout, 
  output [15:0] buswires
); 
assign buswires = (din_en == 1'b1) ? din: 
  (gout == 1'b1) ? aluout :  
  (rout == 3'b000) ? r0 : 
  (rout == 3'b001) ? r1 : 
  (rout == 3'b010) ? r2 : 
  (rout == 3'b011) ? r3 : 
  (rout == 3'b100) ? r4 : 
  (rout == 3'b101) ? r5 : 
  (rout == 3'b110) ? r6 : 
  (rout == 3'b111) ? r7 : 16'bxxxxxxxxxxxxxxxx;  
endmodule  
