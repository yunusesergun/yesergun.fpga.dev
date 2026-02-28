//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
//Date        : Sat Feb 28 12:24:15 2026
//Host        : yesergun running 64-bit Ubuntu 22.04.5 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk_in,
    clk_out,
    en);
  input clk_in;
  output clk_out;
  output [0:0]en;

  wire clk_in;
  wire clk_out;
  wire [0:0]en;

  design_1 design_1_i
       (.clk_in(clk_in),
        .clk_out(clk_out),
        .en(en));
endmodule
