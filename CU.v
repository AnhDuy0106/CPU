`include "decoder3to8.v"
module CU(
  //input
  input wire clk,
  input wire Run,
  input wire resetn,
  input wire [15:0] din,
  input wire [1:0] state,
  //output
  output wire [8:0] ir, 
  output reg ain, 
  output reg gin,
  output reg sub, 
  output reg [7:0] rin,
  output reg [2:0] rout,  
  output reg gout,  
  output reg ir_en,
  output reg din_en,
  output reg clear, 
  output reg done 
);
 parameter T0 = 2'b00, T1 = 2'b01, T2 = 2'b10, T3 = 2'b11;
 parameter mv = 3'b000, mvi = 3'b001, Add = 3'b010, Sub = 3'b011; 
  wire [2:0] opcode; 
  wire [2:0] rx_address_undecoded; 
  wire [2:0] ry_address_undecoded; 
  wire [7:0] rx_address_decoded; 
  wire [8:0] ir_reg; 
  assign opcode = ir[8:6];
  assign rx_address_undecoded = ir[5:3];
  assign ry_address_undecoded = ir[2:0];
  assign ir = ir_reg; 
  
decoder3to8 U(
  .in(rx_address_undecoded),
  .out(rx_address_decoded)
  );
mem9bit IR(
  .clk(clk),
  .rin(ir_en),
  .buswires(din[15:7]),
  .r(ir_reg)
);
always @(*) begin 
  if (~resetn) begin 
    //ir   <= 9'h00; 
    ain  <= 1'b0; 
    gin  <= 1'b0; 
    sub  <= 1'b0; 
    din_en  <= 1'b0; 
    ir_en  <= 1'b0; 
    clear  <= 1'b0; 
    done  <= 1'b0; 
    rin  <= 8'h0; 
    rout <= 3'h0; 
    gout <= 1'b0; 
  end 
  else begin   
  //ir   <= 9'h00; 
    ain  <= 1'b0; 
    gin  <= 1'b0; 
    sub  <= 1'b0; 
    din_en  <= 1'b0; 
    ir_en  <= 1'b0; 
    clear  <= 1'b0; 
    done  <= 1'b0; 
    rin  <= 8'h0; 
    rout <= 3'h0; 
    gout <= 1'b0;
    case(state)
      T0: begin
        ir_en <= 1'b1;
      end
  T1: begin 
    ir_en <= 1'b1;                   
         case(opcode) 
           mv: begin       //Ryout, Rxin, Done 
             rout <= ry_address_undecoded;  //chọn thanh ghi r0 -> r7 được đọc ra 
             rin  <= rx_address_decoded;    //chọn thanh ghi r0 -> r7 được ghi vào 
             done <= 1'b1; 
           end 
           mvi: begin       //DINout, Rxin, Done 
             din_en <= 1'b1; 
             rin    <= rx_address_decoded; 
             done   <= 1'b1; 
           end 
           Add: begin
             rout <= rx_address_undecoded; 
             ain  <= 1'b1; 
           end 
           Sub: begin //Rxout, Ain 
             rout <= rx_address_undecoded; 
             ain  <= 1'b1; 
           end 
         endcase 
  end 
      T2: begin       //Ryout, Gin, AddSub      
        rout <= ry_address_undecoded;       
        if (opcode == Add) begin 
          sub <= 1'b1; 
        end 
        else begin 
          sub <= 1'b0; 
        end
        gin <= 1'b1; 
      end 
      T3: begin   //Gout, Rxin, Done 
        gout <= 1'b1; 
        rin  <= rx_address_decoded; 
        done <= 1'b1; 
      end 
    endcase
  end 
end 
endmodule 
