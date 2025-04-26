//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
//Date        : Sat Mar 22 13:07:10 2025
//Host        : dolfin-yunus running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk_in,
    uart_rxd,
    uart_txd);
  input clk_in;
  input uart_rxd;
  output uart_txd;

  wire clk_in;
  wire uart_rxd;
  wire uart_txd;

  design_1 design_1_i
       (.clk_in(clk_in),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd));
endmodule
