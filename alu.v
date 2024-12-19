`include  "addsub.v"

module alu( 
  input wire [15:0] buswires, 
  input wire clk, 
  input wire ain, 
  input wire gin, 
  input wire sub, 
  output wire [15:0] aluout 
);
//wire 
  wire [15:0] raout; 
  wire [15:0] result; 
  wire [15:0] r_from_gin_reg; 
  assign aluout = r_from_gin_reg; 
mem_16bit ain_reg( 
  .clk(clk), 
  .rin(ain), 
  .buswires(buswires), 
  .r(raout)
);
addsub u1( 
   .A(raout),
   .B(buswires), 
   .Add_Sub(sub), 
   .result(result) 
 );   
mem_16bit gin_reg( 
  .clk(clk), 
  .rin(gin), 
  .buswires(result), 
  .r(r_from_gin_reg) 
); 
endmodule 
