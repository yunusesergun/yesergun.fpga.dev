`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Yunus ESERGUN
//
// Create Date: 11/18/2024 10:11:21 PM
// Design Name:
// Module Name: user_bufgmux
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


module user_bufgmux(
        input   aclk_in1,
        input   aclk_in2,
        output  aclk_out,
        input   selection
    );


   // BUFGMUX: Global Clock Mux Buffer
   //          Artix-7
   // Xilinx HDL Language Template, version 2024.1

   BUFGMUX #(
   )
   BUFGMUX_inst (
      .O    ( aclk_out  ),  // 1-bit output: Clock output
      .I0   ( aclk_in1  ),  // 1-bit input: Clock input (S=0)
      .I1   ( aclk_in2  ),  // 1-bit input: Clock input (S=1)
      .S    ( selection )   // 1-bit input: Clock select
   );

   // End of BUFGMUX_inst instantiation


endmodule
