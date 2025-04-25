`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Yunus ESERGUN
//
// Create Date: 11/18/2024 08:38:50 PM
// Design Name:
// Module Name: user_glitchless_mux
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


module user_glitchless_mux(
        input   aclk_in1,
        input   aclk_in2,
        output  aclk_out,
        input   selection
    );


    // Clock domain synchronization flip-flops for clock domain 1
    reg sel_sync_ff1_clk1 = 1'b0; // First stage flip-flop in clock domain 1
    reg sel_sync_ff2_clk1 = 1'b0; // Second stage flip-flop in clock domain 1

    // Clock domain synchronization flip-flops for clock domain 2
    reg sel_sync_ff1_clk2 = 1'b0; // First stage flip-flop in clock domain 2
    reg sel_sync_ff2_clk2 = 1'b0; // Second stage flip-flop in clock domain 2

    // Synchronization logic for clock domain 1
    always @(posedge aclk_in1) begin
        sel_sync_ff1_clk1 <= !sel_sync_ff2_clk2 && !selection;  // Sync selection signal
        sel_sync_ff2_clk1 <= sel_sync_ff1_clk1;                 // Propagate to second stage
    end

    // Synchronization logic for clock domain 2
    always @(posedge aclk_in2) begin
        sel_sync_ff1_clk2 <= !sel_sync_ff2_clk1 && selection;   // Sync inverted selection signal
        sel_sync_ff2_clk2 <= sel_sync_ff1_clk2;                 // Propagate to second stage
    end

    // Output logic
    assign aclk_out = (sel_sync_ff2_clk1 && aclk_in1) || (sel_sync_ff2_clk2 && aclk_in2);


endmodule
