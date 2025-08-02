timescale 1ns / 1ps
module Register_File(
  input clk,
  input M_WB_EnRW, // 1
  input rst,
  input M_WB_MReg, //0
  input [3:0] RN1,
  input [3:0] RN2,
  input [3:0] M_WB_WN,
  input [31:0] Mem_Data_1,
  input [31:0] ALU_Result_2,
  output [31:0] RD1,
  output [31:0] RD2,
  output [31:0] reg4
);
  wire [31:0] WD;
  reg [31:0] Register [15:0];
  assign M_WB_EnRW = 1;
  assign M_WB_MReg =0;
  //initial Register [M_WB_WN] = 32'b0; // to Don't Cares in the initial stage
  assign WD=M_WB_MReg ? Mem_Data_1: ALU_Result_2;//stage 5 pipeline
  initial begin
    Register [0] = 32'b0;
    Register [1] = 32'b0;
    Register [2] = 32'h863EE;
    Register [3] = 32'h430A1;
    Register [4]= 32'b0;
    Register [5] = 32'h906AF;
    Register [6] = 32'h5;
    Register [7]= 32'h89A57;
    Register [8] = 32'b0;
    Register [9] = 32'b0;
    Register [10] = 32'b0;
    Register [11] = 32'b0;
    Register [12] = 32'b0;
    Register [13] = 32'b0;
    Register [14] = 32'b0;
    Register [15] = 32'b0;
  end
  assign RD1 = Register [RN1];
  assign RD2 = Register [RN2];
  always @ (negedge clk) begin
    if(M_WB_EnRW && (M_WB_WN != 4'b0))
      Register [M_WB_WN] <= ALU_Result_2;
  end
  assign reg4 = Register [4];
endmodule
