timescale 1ns / 1ps
module Sign_Extender(
  input [15:0] Immediate,
  output [31:0] SignExtended
);
  assign SignExtended = {{16{Immediate [15]}}, Immediate};
endmodule
