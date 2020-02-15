----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 15:55:57
-- Design Name: 
-- Module Name: Test_on_board - Structural
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

entity Test_on_board is
  Port ( 
        input1 : in std_logic_vector(7 downto 0);
        input2 : in std_logic_vector(7 downto 0);
--        input3 : std_logic_vector(1 downto 0);
--        input4 : std_logic_vector(1 downto 0);
--        input5 : std_logic_vector(1 downto 0);
--        input6 : std_logic_vector(1 downto 0);
--        input7 : std_logic_vector(1 downto 0);
--        input8 : std_logic_vector(1 downto 0);
        output : out std_logic_vector(15 downto 0)
        
        );
end Test_on_board;

architecture Structural of Test_on_board is
    signal input_temp: ByteArray;
    signal output_temp: signed(40 downto 0);
    
    component HiddenLayerNeuron is
    generic(
        bias : integer;
     --   lenght : integer;
        weights : HiddenLayerWeightArray
    );
    port ( inputArray : in ByteArray;                     -- input 
           outputValue: out signed(40 downto 0)           -- output
    );
    end component;
    
begin
    input_temp <= (input1, input2, "00000000", "00000000", "00000000", "00000000","00000000", "00000000","00000000");
    output <= std_logic_vector(output_temp(15 downto 0));
    
    hln: HiddenLayerNeuron generic map(
            bias => -8,
            weights => (conv_signed(27,32), conv_signed(-46,32), conv_signed(9,32), conv_signed(15,32), conv_signed(-15,32), conv_signed(-33,32),conv_signed(20,32), 
             conv_signed(30,32), conv_signed(-25,32))
            )
    Port Map(
                inputArray => input_temp,
                
                outputValue => output_temp
                );
                

end Structural;
