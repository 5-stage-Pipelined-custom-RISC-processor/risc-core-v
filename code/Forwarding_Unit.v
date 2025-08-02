module Forwarding_Unit(
  input [3:0] opcode,
  input [3:0] EX_M_WN, ID_EX_RN1, ID_EX_RN2, //ID_EX_WN,
  input EX_M_EnRw, //ID_EX_EnRW,
  output FA, FB
);
  assign FA = (EX_M_EnRW && (EX_M_WN == ID_EX_RN1)) ? 1:0;
  assign FB = (EX_M_EnRW && (EX_M_WN == ID_EX_RN2))?1:0;
endmodule
