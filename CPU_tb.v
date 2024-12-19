`timescale 1ns/1ns 
`include "CPU.v"
module CPU_tb(); 
 
// Input 
reg tb_clk; 
reg tb_resetn; 
reg tb_Run; 
reg [15:0] tb_dataIn; 
 
// Ouput 
wire [15:0] tb_dataOut; 
wire tb_done; 
 
// Instantiate module 
CPU CPU_inst( 
 .clk(tb_clk), 
 .resetn(tb_resetn), 
 .Run(tb_Run), 
 .dataIn(tb_dataIn), 
 .dataOut(tb_dataOut), 
 .done(tb_done) 
); 
 
// Clock generation 
parameter CLOCK_PERIOD = 10; 
always 
 begin : Clock_Generator 
  #((CLOCK_PERIOD) / 2) tb_clk <= ~tb_clk; 
 end 
// Initial  
initial begin 
 tb_clk <= 1'b0; 
 tb_resetn <= 1'b0; 
 tb_Run <= 1'b1; 
 tb_dataIn <= 16'h0000; 
end 
 
// Test case 
initial begin 
 #2 
 @(negedge tb_clk); 
 tb_Run <= 1'b0; 
 tb_resetn <= 1'b1; 
 //tb_dataIn <= 16'hFFFF; 
 
 // #(CLOCK_PERIOD) 
 // tb_dataIn <= 16'h1F1F; 
 
 //#20 
 tb_dataIn <= 16'h3F1F; 
 //#20 
 //tb_dataIn <= 16'h5F1F; 
 //#20
  //tb_dataIn <= 16'h7F1F; 
#50 
$display("complete!!!"); 
$finish; 
end 
initial begin 
$dumpfile("dump.vcd");  
$dumpvars; 
end 
endmodule
