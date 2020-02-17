----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:49:41 09/16/2012 
-- Design Name: 
-- Module Name:    counter_mod4 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CounterMod16 is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   count : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (3 downto 0));
end CounterMod16;

architecture Behavioral of CounterMod16 is

    signal c : std_logic_vector (3 downto 0) := (others => '0');

begin

    counter <= c;

    counter_process: process(clock, reset, c)
    begin
	
	   if reset = '1' then
		  c <= (others => '0');
	   elsif clock'event AND clock = '1' AND count = '1' then
	       c <= std_logic_vector(unsigned(c) + 1);
	   end if;
	
    end process;

end Behavioral;

