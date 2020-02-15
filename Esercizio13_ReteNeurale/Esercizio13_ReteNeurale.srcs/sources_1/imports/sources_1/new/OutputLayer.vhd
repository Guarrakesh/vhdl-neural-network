----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 17:00:14
-- Design Name: 
-- Module Name: OutputLayer - Structural
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

entity OutputLayer is Port ( 
         inputValue: in OutputArrayType;
         outputValue: out ArrayLayerOutput
);
end OutputLayer;

architecture Structural of OutputLayer is
    constant BiasArray: ArrayIntegerBiasOutput := (12,23,41,4,-4,4,-9);--(0,0,0,0,0,0,0,0,0,0);
    constant WeightArrayofArray: ArrayWeightsConstantOutput := ((conv_signed(0,32), conv_signed(0,32), conv_signed(-92336,32), conv_signed(0,32), conv_signed(-257680,32), conv_signed(208260,32),conv_signed(0,32), 
                                                           conv_signed(0,32), conv_signed(-97752,32), conv_signed(468988,32)),
                                                          (conv_signed(0,32), conv_signed(0,32), conv_signed(70048,32), conv_signed(0,32), conv_signed(141724,32), conv_signed(-65949,32),conv_signed(0,32), 
                                                           conv_signed(0,32), conv_signed(-138482,32), conv_signed(177892,32)),
                                                           (conv_signed(0,32), conv_signed(0,32), conv_signed(-19104,32), conv_signed(0,32), conv_signed(-109514,32), conv_signed(107601,32),conv_signed(0,32), 
                                                           conv_signed(0,32), conv_signed(-93679,32), conv_signed(315354,32)),
                                                           (conv_signed(0,32), conv_signed(0,32), conv_signed(60496,32), conv_signed(0,32), conv_signed(328542,32), conv_signed(-121485,32),conv_signed(0,32), 
                                                           conv_signed(0,32), conv_signed(-52949,32), conv_signed(40430,32)),
                                                           (conv_signed(0,32), conv_signed(0,32), conv_signed(63680,32), conv_signed(0,32), conv_signed(-380078,32), conv_signed(86775,32),conv_signed(0,32), 
                                                           conv_signed(0,32), conv_signed(-52949,32), conv_signed(355784,32)),
                                                           (conv_signed(0,32), conv_signed(0,32), conv_signed(130544,32), conv_signed(0,32), conv_signed(173934,32), conv_signed(-135369,32),conv_signed(0,32), 
                                                           conv_signed(0,32), conv_signed(-114044,32), conv_signed(64688,32)),
                                                           (conv_signed(0,32), conv_signed(0,32), conv_signed(-41392,32), conv_signed(0,32), conv_signed(193260,32), conv_signed(118014,32),conv_signed(0,32), 
                                                           conv_signed(0,32), conv_signed(166993,32), conv_signed(-493246,32)));
    
    component OutputLayerNeuron is
        generic(
            bias : integer;
            weights : OutputLayerWeightArray
        );
        port ( inputArray : in OutputArrayType;               -- input 
               outputValue: out unsigned(73 downto 0)           -- output 74 = 32 + 42
        );
    end component;
    
begin
    
    neurons0to9: for i in 0 to 6 generate
            n: OutputLayerNeuron generic map(
                bias => BiasArray(i),
                weights => WeightArrayofArray(i)
            )
            port map( inputArray => inputValue,               -- input 
                      outputValue => outputValue(i)         -- output 74 = 32 + 42
        );
    end generate;

end Structural;
