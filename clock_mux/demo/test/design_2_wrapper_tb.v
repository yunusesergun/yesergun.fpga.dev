`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 09:00:10 PM
// Design Name: 
// Module Name: design_2_wrapper_tb
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


module design_2_wrapper_tb();


    reg     aclk_in =   1'b0;


    design_2_wrapper  design_2_wrapper_inst(
        .CLK100MHZ  ( aclk_in   )
    );


    // Clock 1: 10 MHz (Period = 10 ns)
    always #10 aclk_in = ~aclk_in;


endmodule
