module IF_ID(
  input rst,
  input clk,
  //input IF_ID_Write,
  input [31:0] Instruction,
  output [3:0] opcode,
  output [3:0] WN, RN1, RN2,
  output [15:0] Immediate
);
  reg [31:0] IF_ID;
  //assign IF_ID_Write = 1;
  always @ (posedge clk or posedge rst) begin
    if (rst)
      IF_ID <= 32'b0;
    else begin
      //if (IF_ID_Write) begin
      IF_ID [31:28] = Instruction [31:28];
      IF_ID [27:24] = Instruction [27:24];
      IF_ID [23:20] = Instruction [23:20];
      IF_ID [19:16] = Instruction [19:16];
      IF_ID [15:0] = Instruction [15:0];
      //
    end
  end
  assign opcode = IF_ID [31:28];
  assign WN=IF_ID [27:24];
  assign RN1 = IF_ID [23:20];
  assign RN2 = IF_ID [19:16];
  assign Immediate = IF_ID [15:0];
endmodule

module ID_EX(
  input clk, rst,
  input ALU_Src, //FA, FB,
  input [1:0] ALU_Op,
  input MR, MW,
  input MReg, EnRW,
  input [3:0] WN, RN1, RN2,
  input [31:0] RD1, RD2, SignExtended,
  output [31:0] RD1_1, RD2_1, SignExtended_1,
  output [1:0] ID_EX_ALU_Op,
  output ID_EX_ALU_Src, //ID_EX_FA, ID_EX_FB,
  output ID_EX_MR, ID_EX_MW,
  output ID_EX_MReg, ID_EX_EnRW,
  output [3:0] ID_EX_WN, ID_EX_RN1, ID_EX_RN2
);
  reg [114:0] ID_EX;
  always @ (posedge clk or posedge rst) begin
    if (rst)
      ID_EX <= 32'b0;
    else begin
      ID_EX[114:112] = {ALU_Op, ALU_Src};
      ID_EX[111:110] = {MR, MW};
      ID_EX [109:108] = {MReg, EnRW};
      ID_EX[107:76] = RD1;
      ID_EX [75:44] = RD2;
      ID_EX[43:12] = SignExtended;
      ID_EX [11:0] = {WN, RN1, RN2};
    end
  end
  assign ID_EX_ALU_Op = ID_EX[114:113];
  assign ID_EX_ALU_Src = ID_EX[112];
  assign ID_EX_MR = ID_EX[111];
  assign ID_EX_MW = ID_EX [110];
  assign ID_EX_MReg = ID_EX [109];
  assign ID_EX_EnRW = ID_EX [108];
  assign RD1_1 = ID_EX [107:76];
  assign RD2_1= ID_EX[75:44];
  assign SignExtended_1 = ID_EX[43:12];
  //forwarding
  assign ID_EX_WN = ID_EX [11:8];
  assign ID_EX_RN1 = ID_EX[7:4];
  assign ID_EX_RN2 = ID_EX [3:0];
endmodule

module EX_M(
  input clk, rst,
  input ID_EX_MR, ID_EX_MW,
  input ID_EX_MReg, ID_EX_EnRW,
  input [31:0] ALU_Result,
  input [31:0] RD2_2,
  input [3:0] ID_EX_WN,
  output [31:0] ALU_Result_1,
  output [31:0] Write_Data, // address for SW
  output EX_M_MR, EX_M_MW,
  output EX_M_MReg, EX_M_EnRW,
  output [3:0] EX_M_WN
);
  reg [71:0] EX_M;
  always @ (posedge clk or posedge rst) begin
    if (rst)
      EX_M <= 71'b0;
    else begin
      EX_M [71] = ID_EX_MR;
      EX_M [70] = ID_EX_MW;
      EX_M [69] = ID_EX_MReg;
      EX_M [68] = ID_EX_EnRW;
      EX_M [67:36] = ALU_Result;
      EX_M [35:4] = RD2_2;
      EX_M [3:0] = ID_EX_WN;
    end
  end
  assign EX_M_MR = EX_M[71];
  assign EX_M_MW = EX_M [70];
  assign EX_M_MReg = EX_M [69];
  assign EX_M_EnRW = EX_M [68];
  assign ALU_Result_1 = EX_M [67:36];
  assign Write_Data = EX_M[35:4];
  assign EX_M_WN = EX_M [3:0];
endmodule

module M_WB (
  input clk, rst,
  input EX_M_MReg, EX_M_EnRW,
  input [3:0] EX_M_WN,
  input [31:0] ALU_Result_1, Mem_Data,
  output [31:0] ALU_Result_2, Mem_Data_1,
  output M_WB_MReg, M_WB_EnRW,
  output [3:0] M_WB_WN
);
  reg [69:0] M_WB;
  always @ (posedge clk or posedge rst) begin
    if (rst) M_WB = 70'b0;
    else begin
      M_WB [69] = EX_M_MReg;
      M_WB [68] = EX_M_EnRW;
      M_WB [67:36] = ALU_Result_1;
      M_WB [35:4] = Mem_Data;
      M_WB [3:0] = EX_M_WN;
    end
  end
  assign M_WB_MReg = M_WB [69];
  assign M_WB_EnRW = M_WB [68];
  assign ALU_Result_2 = M_WB [67:36];
  assign Mem_Data_1 = M_WB [35:4];
  assign M_WB_WN = M_WB [3:0];
endmodule
