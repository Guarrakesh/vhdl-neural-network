----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2020 06:14:43 PM
-- Design Name: 
-- Module Name: Max - Behavioral
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

entity Max is
      Port ( 
            input: in ArrayLayerOutput;
            output: out std_logic_vector(2 downto 0)
      );
end Max;

architecture Behavioral of Max is
    signal currentMaxIndexDef: integer range 0 to 6 := 0;
begin

    calculateMax: process(input)
        
        variable currentMaxIndex: integer range 0 to 6 := 0;
        variable currentMax: unsigned(73 downto 0) := (others => '0');
        
        begin
        
        currentMax := input(0);
        currentMaxIndex := 0;
        
        for i in 1 to 6 loop
            if (input(i) > currentMax) then
                currentMax := input(i);
                currentMaxIndex := i;
            end if;
        end loop;
        
        currentMaxIndexDef <= currentMaxIndex + 1;
        
        
        
    end process;
    output <= conv_std_logic_vector(currentMaxIndexDef, 3);

end Behavioral;
