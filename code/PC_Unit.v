timescale 1ns / 1ps
module PC_Register(
  input clk,
  input rst,
  output reg [31:0] Instr_Address
);
  //always @(posedge clk or posedge rst) begin
  if (rst)
    Instr_Address <= 32'b0;
  else begin
    //if(PC_Write)
    Instr_Address <= Instr_Address + 4;
  end
  //end
endmodule

module Instruction_Memory(
  input clk,
  input rst,
  input EnIM,
  input [31:0] Instr_Address,
  output reg [31:0] Instruction
);
  reg [7:0] IMem [31:0];
  assign EnIM = 1;
  initial begin
    IMem [0] = 8'b0000_0000;
    IMem [1] = 8'b0010_0011;
    IMem [2] = 8'b0000_0000;
    IMem [3] = 8'b0000_0000;
    IMem [4] = 8'b0001_0100;
    IMem [5] = 8'b0001_0101;
    IMem [6] = 8'b0000_0000;
    IMem [7] = 8'b0000_0000;
    IMem [8] = 8'b0011_0000;
    IMem [9] = 8'b0110_0100;
    IMem [10] = 8'b0000_0000;
    IMem [11] = 8'b0000_0111;
    IMem [12] = 8'b0111_1000;
    IMem [13] = 8'b0111_0000;
    IMem [14] = 8'b0101_1001;
    IMem [15] = 8'b1010_1011;
    IMem [16] = 8'b1111_1001;
    IMem [17] = 8'b1000_0100;
    IMem [18] = 8'b0000_0000;
    IMem [19] = 8'b0000_0000;
    IMem [20] = 8'b0;
    IMem [21] = 8'b0;
    IMem [22] = 8'b0;
    IMem [23] = 8'b0;
    IMem [24] = 8'b0;
    IMem [25] = 8'b0;
    IMem [26] = 8'b0;
    IMem [27] = 8'b0;
    IMem [28] = 8'b0;
    IMem [29] = 8'b0;
    IMem [30] = 8'b0;
    IMem [31] = 8'b0;
  end
  always @(posedge clk) begin
    if(EnIM)
      Instruction <= {IMem[Instr_Address+3], IMem[Instr_Address+2], IMem[Instr_Address+1], IMem[Instr_Address]};
  end
endmodule
