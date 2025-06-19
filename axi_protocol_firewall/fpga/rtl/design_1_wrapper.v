//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
//Date        : Wed Jun 11 20:50:29 2025
//Host        : dolfin-yunus running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (UART_rxd,
    UART_txd,
    clk_en,
    clock,
    rstn_switch);
  input UART_rxd;
  output UART_txd;
  input clk_en;
  input clock;
  input rstn_switch;

  wire UART_rxd;
  wire UART_txd;
  wire clk_en;
  wire clock;
  wire rstn_switch;

  design_1 design_1_i
       (.UART_rxd(UART_rxd),
        .UART_txd(UART_txd),
        .clk_en(clk_en),
        .clock(clock),
        .rstn_switch(rstn_switch));
endmodule
