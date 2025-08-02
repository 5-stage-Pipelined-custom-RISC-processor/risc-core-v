timescale 1ns / 1ps
module Top();
  reg clk, rst;
  initial begin
    clk = 1;
    rst = 1;
    #5 rst = 0;
    #15 $finish;
  end
  always #5 clk = ~clk;
  wire [31:0] Instr_Address, Instruction;
  wire [3:0] opcode;
  wire [1:0] ID_EX_ALU_Op;
  wire [3:0] RN1, RN2, M_WB_WN;
  wire [31:0] ALU_srcA, ALU_srcB, ALU_Result, ALU_Result_1, ALU_Result_2;
  wire [31:0] reg4;
  wire FA, FB;
  wire M_WB_EnRW;
  wire ID_EX_ALU_Src;
  wire EX_M_WN;
  wire emptyline1;
  wire MReg, ID_EX_MReg, EX_M_MReg, M_WB_MReg;
  wire EnRW, ID_EX_EnRW, EX_M_EnRW;
  wire ALU_Src;
  wire MR, ID_EX_MR, EX_M_MR;
  wire MW, ID_EX_MW;
  wire [31:0] RD1, RD2, SignExtended, RD1_1, RD2_1, SignExtended_1, Write_Data;
  wire [15:0] Immediate;
  wire [3:0] WN, ID_EX_WN, EX_M_WN;
  wire [3:0] ID_EX_RN1, ID_EX_RN2;
  wire [1:0] ALU_Op;
  wire [31:0] Mem_Data, Mem_Data_1;
  assign emptyline1 = 1'b1;
  PC_Register uPC_Register(
    .clk(clk),
    .rst(rst),
    .Instr_Address(Instr_Address)
  );
  Instruction_Memory uInstruction_Memory(
    .clk(clk),
    .rst(rst),
    .EnIM(1),
    .Instr_Address(Instr_Address),
    .Instruction(Instruction)
  );
  Register_File uRegister_File(
    .clk(clk),
    .M_WB_EnRW(1),
    .rst(rst),
    .M_WB_MReg(0),
    .M_WB_WN(M_WB_WN),
    .RN1(RN1),
    .RN2(RN2),
    .Mem_Data_1(Mem_Data_1),
    .ALU_Result_2(ALU_Result_2),
    .RD1(RD1),
    .RD2(RD2),
    .reg4(reg4)
  );
  Sign_Extender uSign_Extender(
    .Immediate(Immediate),
    .SignExtended(SignExtended)
  );
  IF_ID uIF_ID(
    .rst(rst),
    .clk(clk),
    .Instruction(Instruction),
    .opcode(opcode),
    .WN(WN), .RN1(RN1), .RN2(RN2),
    .Immediate(Immediate)
  );
  ID_EX uID_EX(
    .clk(clk), .rst(rst),
    .ALU_Src(ALU_Src),
    .ALU_Op(ALU_Op),
    .MR(MR), .MW(MW),
    .MReg(MReg), .EnRW(EnRW),
    .WN(WN), .RN1(RN1), .RN2(RN2),
    .RD1(RD1), .RD2(RD2), .SignExtended(SignExtended),
    .RD1_1(RD1_1), .RD2_1(RD2_1), .SignExtended_1(SignExtended_1),
    .ID_EX_ALU_Op(ID_EX_ALU_Op),
    .ID_EX_ALU_Src(ID_EX_ALU_Src),
    .ID_EX_MR(ID_EX_MR), .ID_EX_MW(ID_EX_MW),
    .ID_EX_MReg(ID_EX_MReg), .ID_EX_EnRW(ID_EX_EnRW),
    .ID_EX_WN(ID_EX_WN), .ID_EX_RN1(ID_EX_RN1), .ID_EX_RN2(ID_EX_RN2)
  );
  EX_M uEX_M(
    .clk(clk), .rst(rst),
    .ID_EX_MR(ID_EX_MR), .ID_EX_MW(ID_EX_MW),
    .ID_EX_MReg(ID_EX_MReg), .ID_EX_EnRW(ID_EX_EnRW),
    .ALU_Result(ALU_Result),
    .RD2_2(RD2_2),
    .ID_EX_WN(ID_EX_WN),
    .ALU_Result_1(ALU_Result_1),
    .Write_Data(Write_Data),
    .EX_M_MR(EX_M_MR), .EX_M_MW(EX_M_MW),
    .EX_M_MReg(EX_M_MReg), .EX_M_EnRW(EX_M_EnRW),
    .EX_M_WN(EX_M_WN)
  );
  M_WB uM_WB(
    .clk(clk), .rst(rst),
    .EX_M_MReg(EX_M_MReg), .EX_M_EnRW(EX_M_EnRW),
    .EX_M_WN(EX_M_WN),
    .ALU_Result_1(ALU_Result_1), .Mem_Data(Mem_Data),
    .ALU_Result_2(ALU_Result_2), .Mem_Data_1(Mem_Data_1),
    .M_WB_MReg(M_WB_MReg), .M_WB_EnRW(M_WB_EnRW),
    .M_WB_WN(M_WB_WN)
  );
  Forwarding_Unit uForwarding_Unit(
    .EX_M_WN(EX_M_WN), .ID_EX_RN1(ID_EX_RN1), .ID_EX_RN2(ID_EX_RN2),
    .EX_M_EnRw(EX_M_EnRW),
    .FA(FA), .FB(FB)
  );
  Data_Memory uData_Memory(
    .clk(clk),
    .rst(rst),
    .ALU_Result_1(ALU_Result_1),
    .Write_Data(Write_Data),
    .EX_M_MR(EX_M_MR),
    .EX_M_MW(EX_M_MW),
    .Mem_Data(Mem_Data)
  );
  Control_Unit uControl_Unit(
    .opcode(opcode),
    .ALU_Src(ALU_Src),
    .MW(MW), .EnRW(EnRW),
    .ALU_Op(ALU_Op),
    .MR(MR), .MReg(MReg)
  );
  ALU_Unit uALU_Unit(
    .RD1_1(RD1_1),
    .RD2_1(RD2_1),
    .SignExtended_1(SignExtended_1),
    .opcode(opcode),
    .RD2_2(RD2_2),
    .FA(FA),
    .FB(FB),
    .ID_EX_ALU_Src(ID_EX_ALU_Src),
    .ID_EX_ALU_Op(ID_EX_ALU_Op),
    .ID_EX_MW(ID_EX_MW),
    .ALU_Result_1(ALU_Result_1),
    .ALU_Result(ALU_Result),
    .ALU_srcA(ALU_srcA),
    .ALU_srcB(ALU_srcB)
  );
endmodule
