`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Yunus ESERGUN
//
// Create Date: 11/18/2024 10:38:58 PM
// Design Name:
// Module Name: user_glitch_bufgctrl
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


module user_glitch_bufgctrl(
        input   aclk_in1,
        input   aclk_in2,
        output  aclk_out,
        input   selection
    );


   // BUFGCTRL: Global Clock Control Buffer
   //           Artix-7
   // Xilinx HDL Language Template, version 2024.1

   BUFGCTRL #(
      .INIT_OUT     ( 0         ),  // Initial value of BUFGCTRL output ($VALUES;)
      .PRESELECT_I0 ( "FALSE"   ),  // BUFGCTRL output uses I0 input ($VALUES;)
      .PRESELECT_I1 ( "FALSE"   )   // BUFGCTRL output uses I1 input ($VALUES;)
   )
   BUFGCTRL_inst (
      .O        ( aclk_out      ),  // 1-bit output: Clock output
      .CE0      ( 1'b1          ),  // 1-bit input: Clock enable input for I0
      .CE1      ( 1'b1          ),  // 1-bit input: Clock enable input for I1
      .I0       ( aclk_in1      ),  // 1-bit input: Primary clock
      .I1       ( aclk_in2      ),  // 1-bit input: Secondary clock
      .IGNORE0  ( 1'b1          ),  // 1-bit input: Clock ignore input for I0
      .IGNORE1  ( 1'b1          ),  // 1-bit input: Clock ignore input for I1
      .S0       ( !selection    ),  // 1-bit input: Clock select for I0
      .S1       ( selection     )   // 1-bit input: Clock select for I1
   );

   // End of BUFGCTRL_inst instantiation


endmodule
