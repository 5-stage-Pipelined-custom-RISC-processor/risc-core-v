timescale 1ns / 1ps
module Control_Unit (
  input [3:0] opcode,
  output reg ALU_Src, EnRW, MW,
  output reg [1:0] ALU_Op,
  output reg MR, MReg
);
  initial begin
    MW = 0;
    MReg = 0;
  end
  always @ (*) begin
    MR = 0;
    MW = 0;
    EnRW = 0;
    ALU_Op = 2'b00;
    ALU_Src = 0;
  end
  always @ (*) begin
    case (opcode)
      4'b0000: begin // nor
        MR = 0;
        MReg = 0;
        MW = 0;
        EnRW = 1;
        ALU_Op = 2'b00;
        ALU_Src = 0;
      end
      4'b0001: begin // nand
        ALU_Src = 0;
        MW = 0;
        MR = 0;
        MReg = 0;
        EnRW = 1;
        ALU_Op = 2'b01;
      end
      4'b0011: begin // sw
        ALU_Src = 1;
        MW = 1;
        EnRW = 0;
        MR = 0;
        MReg = 0;
        ALU_Op = 2'b11;
      end
      4'b0111: begin // xnori
        ALU_Src = 1;
        MW = 0;
        EnRW = 1;
        MR = 0;
        MReg = 0;
        ALU_Op = 2'b10;
      end
      4'b1111: begin // add
        ALU_Src = 0;
        MW = 0;
        EnRW = 1;
        MR = 0;
        ALU_Op = 2'b11;
      end
      default: begin
        ALU_Src = 0;
        MW = 0;
        EnRW = 0;
        ALU_Op = 2'b00;
        MR = 0;
        MReg = 0;
      end
    endcase
  end
endmodule
