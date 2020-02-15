----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 11:03:04
-- Design Name: 
-- Module Name: defs - Behavioral
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
use IEEE.STD_LOGIC_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package defs is

--subtype inputByte is std_logic_vector(7 downto 0);
type ByteArray is array (0 to 8) of std_logic_vector(7 downto 0);
type HiddenLayerWeightArray is array (0 to 8) of signed (31 downto 0);
type SignedArray is array (0 to 9) of signed (31 downto 0);
type OutputArrayType is array (0 to 9) of unsigned(40 downto 0);
type OutputLayerWeightArray is array (0 to 9) of signed (31 downto 0);
type ArrayIntegerBiasHidden is array (0 to 9) of integer;
type ArrayWeightsConstantHidden is array (0 to 9) of HiddenLayerWeightArray;
type ArrayLayerOutput is array(0 to 6) of unsigned(73 downto 0);
type ArrayIntegerBiasOutput is array (0 to 6) of integer;
type ArrayWeightsConstantOutput is array (0 to 6) of OutputLayerWeightArray;

constant stateWidth : positive := 3;

end package defs;
