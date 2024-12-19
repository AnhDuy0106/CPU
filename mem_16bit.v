module mem_16bit(
  input wire rin,
  input wire clk,
  input wire [15:0] buswires,
  output wire[15:0] r
);
reg [15:0] mem16;
always @(posedge clk) begin
  if (rin) begin
    mem16 <= buswires;
  end
end
  assign r = mem16;
endmodule
  
