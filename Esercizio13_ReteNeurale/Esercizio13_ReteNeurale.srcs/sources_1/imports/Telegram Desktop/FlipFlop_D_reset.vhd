----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2019 19:25:06
-- Design Name: 
-- Module Name: FlipFlop_D_reset - Dataflow
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


entity FlipFlop_D_reset is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           Q : out STD_LOGIC);
end FlipFlop_D_reset;

architecture Dataflow of FlipFlop_D_reset is

begin
    ff_d: process (clk, reset)
    begin
        
        if(reset ='1') then
            Q <= '0';
                                
        elsif(clk 'event and clk='0') then
            Q <= D;
        end if;
        
    end process;
    
end Dataflow;




