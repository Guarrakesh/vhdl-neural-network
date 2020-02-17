----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2020 06:53:29 PM
-- Design Name: 
-- Module Name: InputManager - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
USE IEEE.std_logic_arith.all;

use work.defs.all;

entity InputManager is
    Port (
          clock: in std_logic;
          reset: in std_logic; 
          --buttonEnable: in std_logic;                   -- Enabled for each input
          enableNetwork: in std_logic;                  -- Enabled when all input are loaded
          count_in: in std_logic;  -- CounterValue to access input index
          input: in std_logic_vector(7 downto 0);       -- Actual input
          networkInput: out ByteArray                   -- Array to be sent to Neural Network
    );
end InputManager;

architecture Behavioral of InputManager is

signal internalInputArray : ByteArray := (others => (others =>'0'));

begin

    main: process(clock)
        variable counter: integer range 0 to 9 := 0;
    begin
	   if clock'event and clock = '1' then
	   	   if reset = '1' then
	           internalInputArray <= (others => (others =>'0'));                   -- reset all
	           networkInput <= (others => (others =>'0'));
	           counter := 0;
	       elsif count_in = '1' then           
	           internalInputArray(counter) <= input;    -- assign input to index specified by counter
	           counter := counter + 1;
	       elsif enableNetwork = '1' then                                          -- enableNetwork is high when all input are loaded, specified into Control Unit
	           networkInput <= internalInputArray;                                 -- Send inputs to Neural Network
	       end if; 
	   end if;

    end process;




end Behavioral;
