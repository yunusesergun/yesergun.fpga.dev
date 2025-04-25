`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Yunus ESERGUN
//
// Create Date: 11/18/2024 09:57:55 PM
// Design Name:
// Module Name: user_bufgmux_ctrl
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module user_bufgmux_ctrl(
        input   aclk_in1,
        input   aclk_in2,
        output  aclk_out,
        input   selection
    );


   // BUFGMUX_CTRL: 2-to-1 Global Clock MUX Buffer
   //               Artix-7
   // Xilinx HDL Language Template, version 2024.1

   BUFGMUX_CTRL BUFGMUX_CTRL_inst (
      .O    ( aclk_out  ),  // 1-bit output: Clock output
      .I0   ( aclk_in1  ),  // 1-bit input: Clock input (S=0)
      .I1   ( aclk_in2  ),  // 1-bit input: Clock input (S=1)
      .S    ( selection )   // 1-bit input: Clock select
   );

   // End of BUFGMUX_CTRL_inst instantiation

endmodule
