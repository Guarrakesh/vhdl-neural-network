----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 17:37:06
-- Design Name: 
-- Module Name: Network - Structural
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

use work.defs.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Network is
  Port ( 
    inputArray : in ByteArray;
    outputValue: out ArrayLayerOutput
  );
end Network;

architecture Structural of Network is
    signal int_output: OutputArrayType;
    
    component HiddenLayer is Port ( 
           inputArray : in ByteArray;                     -- input 
           outputValue: out OutputArrayType               --output
           );         
    end component;
    
    component OutputLayer is Port ( 
         inputValue: in OutputArrayType;
         outputValue: out ArrayLayerOutput
);
    end component;
    
begin
    
    HL: HiddenLayer Port map(
            inputArray => inputArray,
            outputValue => int_output
            );
     
    OL: OutputLayer Port map(
            inputValue => int_output,
            outputValue => outputValue
            );
        

end Structural;
