`include  "ctr2bit.v"
`include  "CU.v"
`include  "alu.v"
`include  "mem_16bit.v"
`include  "mux10to1.v"

module CPU( 
  input wire clk, 
  input wire resetn, 
  input wire Run, 
  input wire [15:0] dataIn, 
  output wire [15:0] dataOut, 
  output wire done 
);
 //wire control 
  wire Ain, Gin, AddSub, din_en, gout, done_reg; 
  wire [7:0]  rin; 
  wire [2:0]  rout; 
  wire [15:0] aluout, dataOut_bus; 
  wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7; 
  wire [1:0]  state; 
  assign dataOut = dataOut_bus ; 
  assign done = done_reg;  
  //Control Unit 
CU u1( 
    .clk(clk), 
    .Run(Run), 
    .resetn(resetn), 
    .din(dataIn), 
    .state(state), 
    .ir(), 
    .ain(Ain), 
    .gin(Gin), 
    .sub(AddSub), 
    .rin(rin), 
    .rout(rout), 
    .din_en(din_en), 
    .gout(gout), 
    .ir_en(), 
    .clear(), 
    .done(done_reg) 
  ); 
  //ALU
alu u2( 
    .clk(clk), 
    .buswires(dataOut_bus), 
    .ain(Ain), 
    .gin(Gin), 
    .sub(AddSub), 
    .aluout(aluout) 
); 
  //Register 
  mem_16bit R0(.clk(clk), .rin(rin[0]), .buswires(dataOut_bus), .r(r0)); 
  mem_16bit R1(.clk(clk), .rin(rin[1]), .buswires(dataOut_bus), .r(r1)); 
  mem_16bit R2(.clk(clk), .rin(rin[2]), .buswires(dataOut_bus), .r(r2)); 
  mem_16bit R3(.clk(clk), .rin(rin[3]), .buswires(dataOut_bus), .r(r3)); 
  mem_16bit R4(.clk(clk), .rin(rin[4]), .buswires(dataOut_bus), .r(r4)); 
  mem_16bit R5(.clk(clk), .rin(rin[5]), .buswires(dataOut_bus), .r(r5)); 
  mem_16bit R6(.clk(clk), .rin(rin[6]), .buswires(dataOut_bus), .r(r6)); 
  mem_16bit R7(.clk(clk), .rin(rin[7]), .buswires(dataOut_bus), .r(r7));
              
//Multiplexers 
mux10to1 u3( 
   .din_en(din_en), 
   .gout(gout), 
   .rout(rout), 
   .din(dataIn), 
   .r0(r0), 
   .r1(r1), 
   .r2(r2), 
   .r3(r3), 
   .r4(r4), 
   .r5(r5), 
   .r6(r6), 
   .r7(r7), 
   .aluout(aluout), 
   .buswires(dataOut_bus) 
); 
  // counter
ctr2bit u4( 
   .clk(clk), 
   .clear(Run), 
   .state(state) 
); 
endmodule
