`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Yunus ESERGUN
//
// Create Date: 11/18/2024 10:25:48 PM
// Design Name:
// Module Name: user_bufgmux1_tb
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


module user_bufgmux1_tb();


    reg     aclk_in1    =   1'b0;
    reg     aclk_in2    =   1'b0;
    reg     selection   =   1'b0;

    wire    aclk_out;


    user_bufgmux1  user_bufgmux1_inst(
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
        #100000 selection = ~selection;
        #1000 selection = ~selection;
        #1000 selection = ~selection;
        #1000 selection = ~selection;
        #1000 selection = ~selection;
        #1000 selection = ~selection;
        #1000 $stop;
    end


endmodule
