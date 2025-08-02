module Data_Memory(
  input clk,
  input rst,
  input [31:0] ALU_Result_1,
  input [31:0] Write_Data,
  input EX_M_MR,
  input EX_M_MW,
  output reg [31:0] Mem_Data
);
  reg [31:0] DMem [14:0];
  assign EX_M_MR = 0;
  initial begin
    DMem [0] = 32'b0;
    DMem [1] = 32'b0;
    DMem [2] = 32'b0;
    DMem [3] = 32'b0;
    DMem [4] = 32'b0;
    DMem [5] = 32'b0;
    DMem [6] = 32'b0;
    DMem [7] = 32'b0;
    DMem [8] = 32'b0;
    DMem [9] = 32'b0;
    DMem [10] = 32'b0;
    DMem [11] = 32'b0;
    DMem [12] = 32'b0;
    DMem [13] = 32'b0;
    DMem [14] = 32'b0;
  end
  always @(posedge clk or posedge rst) begin
    if(rst)
      DMem[ALU_Result_1] <= 0;
    else if(EX_M_MW)
      DMem[ALU_Result_1] <= Write_Data;
    else if (EX_M_MR)
      Mem_Data <= DMem[ALU_Result_1];
  end
endmodule
