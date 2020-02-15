----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:06:01 10/22/2012 
-- Design Name: 
-- Module Name:    clock_filter - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_filter is
	 generic(
				clock_frequency_in : integer := 100000000;
				clock_frequency_out_display : integer := 1;
				clock_frequency_out_components : integer := 1
				);
    Port ( clock_in : in  STD_LOGIC;
		   reset : in STD_LOGIC;
           clockOutDisplay : out  STD_LOGIC;
           clockOutComponents : out std_logic
           );
           
end clock_filter;

architecture Behavioral of clock_filter is

signal clockfxDisplay : std_logic := '0';
signal clockfxComponents : std_logic := '0';

constant count_max_value_display : integer := clock_frequency_in/(clock_frequency_out_display)-1;
constant count_max_value_components : integer := clock_frequency_in/(clock_frequency_out_components)-1;

begin

clockOutComponents <= clockfxComponents;
clockOutDisplay <= clockfxDisplay;


count_for_division: process(clock_in, reset)
    variable counter : integer range 0 to count_max_value_display := 0;
begin

	if reset = '1' then
		counter := 0;
		clockfxDisplay <= '0';
	elsif clock_in'event and clock_in = '1' then
		if counter = count_max_value_display then
			clockfxDisplay <=  '1';
			counter := 0;
		else
			clockfxDisplay <=  '0';
			counter := counter + 1;
		end if;
	end if;

end process;


count_for_division_compoents: process(clock_in, reset)
    variable counter : integer range 0 to count_max_value_components := 0;
begin

	if reset = '1' then
		counter := 0;
		clockfxComponents <= '0';
	elsif clock_in'event and clock_in = '1' then
		if counter = count_max_value_display then
			clockfxComponents <=  '1';
			counter := 0;
		else
			clockfxComponents <= '0';
			counter := counter + 1;
		end if;
	end if;

end process;


end Behavioral;

