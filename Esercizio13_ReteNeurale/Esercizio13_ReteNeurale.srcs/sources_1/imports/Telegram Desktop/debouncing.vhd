----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2019 14:46:27
-- Design Name: 
-- Module Name: debouncing - Structural
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

entity debouncing is
    Port ( button : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           button_result : out STD_LOGIC);
end debouncing;

architecture Structural of debouncing is
    signal signal_clk_int : STD_LOGIC :='0';  --segnale interno per prendere il clock in uscita dal clock filter
    signal signal_n_reset : STD_LOGIC :='0';  --segnale interno per passare il reset negato al clock filter
    
    component FlipFlop_D_reset is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           Q : out STD_LOGIC);
    end component;
   
begin                      
       
      
      ffd : FlipFlop_D_reset Port map(
                       D => button,
                       clk => signal_clk_int,
                       reset => reset,
                       Q => button_result
                       );            
    
    signal_n_reset <= not reset; 
 
 end Structural;
