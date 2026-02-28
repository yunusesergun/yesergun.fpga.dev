----------------------------------------------------------------------------------
-- Company:
-- Engineer: Yunus ESERGUN
--
-- Create Date: 12/04/2025 06:46:10 PM
-- Design Name:
-- Module Name: oddr_wrapper - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.vcomponents.all;


entity oddr_wrapper is
  Port (
    clk_in : in std_logic;
    clk_en : in std_logic;

    clk_out : out std_logic
  );
end oddr_wrapper;

architecture Behavioral of oddr_wrapper is

begin


   -- ODDR: Output Double Data Rate Output Register with Set, Reset
   --       and Clock Enable.
   --       Artix-7
   -- Xilinx HDL Language Template, version 2024.1

   ODDR_inst : ODDR
   generic map(
      DDR_CLK_EDGE => "OPPOSITE_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE"
      INIT => '0',                 -- Initial value for Q port ('1' or '0')
      SRTYPE => "SYNC")            -- Reset Type ("ASYNC" or "SYNC")
   port map (
      Q  => clk_out, -- 1-bit DDR output
      C  => clk_in,  -- 1-bit clock input
      CE => clk_en,  -- 1-bit clock enable input
      D1 => '1',     -- 1-bit data input (positive edge)
      D2 => '0',     -- 1-bit data input (negative edge)
      R  => '0',     -- 1-bit reset input
      S  => '0'      -- 1-bit set input
   );


end Behavioral;
