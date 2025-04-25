`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Yunus ESERGUN
//
// Create Date: 11/18/2024 10:12:45 PM
// Design Name:
// Module Name: user_bufgmux_tb
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


module user_bufgmux_tb();


    reg     aclk_in1    =   1'b0;
    reg     aclk_in2    =   1'b0;
    reg     selection   =   1'b0;

    wire    aclk_out;


    user_bufgmux  user_bufgmux_inst(
        .aclk_in1   ( aclk_in1  ),
        .aclk_in2   ( aclk_in2  ),
        .aclk_out   ( aclk_out  ),
        .selection  ( selection )
    );


    // Clock 1: 50 MHz (Period = 20 ns)
    always #10 aclk_in1 = ~aclk_in1;

    // Clock 2: 75 MHz (Period ≈ 13.33 ns)
    always #6.67 aclk_in2 = ~aclk_in2;

    // Change selection signal periodically
    initial begin
        selection = 1'b0;
        #1000000 selection = ~selection;
        #1001 selection = ~selection;
        #1002 selection = ~selection;
        #1003 selection = ~selection;
        #1004 selection = ~selection;
        #1005 selection = ~selection;
        #1006 $stop;
    end


endmodule
