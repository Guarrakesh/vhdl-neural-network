----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2020 06:32:30 PM
-- Design Name: 
-- Module Name: DisplayManager - Behavioral
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

entity DisplayManager is
    Port (
        enable : in std_logic; 
        input : in std_logic_vector(2 downto 0);
        anodes : out  STD_LOGIC_VECTOR (7 downto 0);
        cathodes : out  STD_LOGIC_VECTOR (7 downto 0)
    );
end DisplayManager;

architecture rtl of DisplayManager is


    --attivazione anodo relativo alla prima cifra del display
    constant first_digit_enabled : std_logic_vector(7 downto 0) := "11111110";
    
    --configurazioni catodi relativi ai 16 numeri esadecimali
    constant zero   : std_logic_vector(7 downto 0) := "11000000"; 
    constant one    : std_logic_vector(7 downto 0) := "11111001"; 
    constant two    : std_logic_vector(7 downto 0) := "10100100"; 
    constant three  : std_logic_vector(7 downto 0) := "10110000"; 
    constant four   : std_logic_vector(7 downto 0) := "10011001"; 
    constant five   : std_logic_vector(7 downto 0) := "10010010"; 
    constant six    : std_logic_vector(7 downto 0) := "10000010"; 
    constant seven  : std_logic_vector(7 downto 0) := "11111000"; 
    
    --in caso di valori non ben definiti di tensione si spengono tutti i led
    constant error  : std_logic_vector(7 downto 0) := "11111111";

begin


    anodes <= first_digit_enabled when enable = '1' else "11111111";
    
    with input select
        cathodes <= zero    when "000",
                    one     when "001",
                    two     when "010",
                    three   when "011",
                    four    when "100",
                    five    when "101",
                    six     when "110",
                    seven   when "111",

                    error   when others;
 
end rtl;
