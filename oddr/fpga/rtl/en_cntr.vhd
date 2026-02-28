----------------------------------------------------------------------------------
-- Company:
-- Engineer: Yunus ESERGUN
--
-- Create Date: 12/04/2025 07:07:23 PM
-- Design Name:
-- Module Name: en_cntr - Behavioral
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


entity en_cntr is
  port (
    aclk   : in std_logic;
    resetn : in std_logic;

    en   : out std_logic
  );
end en_cntr;

architecture Behavioral of en_cntr is

  signal cntr : integer   := 0;
  signal r_en : std_logic := '1';

begin

  process(aclk)
  begin
    if (rising_edge(aclk)) then
      if (resetn = '0') then
        cntr <= 0;
      else
        if (cntr < 512) then
          cntr <= cntr + 1;
        else
          cntr <= 0;
          r_en <= not(r_en);
        end if;
      end if;
    end if;
  end process;

en <= r_en;

end Behavioral;
