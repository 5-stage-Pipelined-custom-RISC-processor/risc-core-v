timescale 1ns/1ps
module ALU_Unit(
  input [31:0] RD1_1,
  input [31:0] RD2_1,
  input [31:0] SignExtended_1,
  input [3:0] opcode,
  input FA,
  input FB,
  input ID_EX_ALU_Src,
  input ID_EX_MW,
  input [1:0] ID_EX_ALU_Op,
  input [31:0] ALU_Result_1, // after ex/mew reg // this is for the data forwarding logic
  output reg [31:0]
  ALU_Result, ALU_srcA, ALU_srcB,
  output reg [31:0] RD2_2
);
  wire [31:0] ALU_inA, ALU_inB, MUXtoMUX, SWin;
  assign ALU_inA = FA? ALU_Result_1: RD1_1;
  assign MUXtoMUX = ID_EX_ALU_Src ? SignExtended_1: RD2_1;
  assign SWin = ID_EX_ALU_Src ? SignExtended_1: ALU_Result_1;
  assign ALU_inB = FB ? SWin : MUXtoMUX;
  always (*) begin
    ALU_srcA = ALU_inA;
    ALU_srcB = ALU_inB;
  end
  always @ (*) begin
    case (ID_EX_ALU_Op)
      2'b00: ALU_Result = (ALU_inA | ALU_inB);//nor
      2'b01: ALU_Result = (ALU_inA & ALU_inB);//nand
      2'b10: ALU_Result = (ALU_inA ^ ALU_inB);//xnort
      2'b11: ALU_Result = (ALU_inA + ALU_inB);//add, sw
      default: ALU_Result = 0;
    endcase
  end
  always @ (*) begin
    if (FB && ID_EX_MW)
      RD2_2 = ALU_Result_1;
    else
      RD2_2 = RD2_1;
  end
endmodule
