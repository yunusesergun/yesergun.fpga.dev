`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Yunus ESERGUN
//
// Create Date: 11/18/2024 08:20:23 PM
// Design Name:
// Module Name: user_glitch_mux
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


module user_glitch_mux(
        input   aclk_in1,
        input   aclk_in2,
        output  aclk_out,
        input   selection
    );

    assign  aclk_out    =   !selection  ?   aclk_in1    :   aclk_in2;

endmodule
