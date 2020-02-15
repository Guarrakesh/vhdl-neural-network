----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 16:24:36
-- Design Name: 
-- Module Name: HiddenLayer - Structural
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

entity HiddenLayer is Port ( 
           inputArray : in ByteArray;                     -- input 
           outputValue: out OutputArrayType               --output
           );         
    end HiddenLayer;

architecture Structural of HiddenLayer is
    constant BiasArray: ArrayIntegerBiasHidden := (-8,2,-14,-2,-8,6,-11,-5,-9,14);--(0,0,0,0,0,0,0,0,0,0);
    constant WeightArrayofArray: ArrayWeightsConstantHidden := (
                                                          (conv_signed(27,32), conv_signed(-46,32), conv_signed(9,32), conv_signed(15,32), conv_signed(-15,32), conv_signed(-33,32),conv_signed(20,32), 
                                                           conv_signed(30,32), conv_signed(-25,32)),
                                                          (conv_signed(61,32), conv_signed(54,32), conv_signed(-46,32), conv_signed(-50,32), conv_signed(-29,32), conv_signed(17,32), conv_signed(-33,32),
                                                           conv_signed(-17,32), conv_signed(49,32)),
                                                          (conv_signed(-45,32), conv_signed(37,32), conv_signed(29,32), conv_signed(-39,32), conv_signed(18,32), conv_signed(3,32), conv_signed(-13,32), 
                                                          conv_signed(20,32), conv_signed(-6,32)),
                                                          (conv_signed(45,32), conv_signed(-3,32), conv_signed(47,32), conv_signed(-53,32), conv_signed(31,32), conv_signed(-40,32), conv_signed(20,32),
                                                          conv_signed(-30,32), conv_signed(4,32)),
                                                          (conv_signed(17,32), conv_signed(26,32), conv_signed(16,32), conv_signed(-54,32), conv_signed(-40,32), conv_signed(-51,32), conv_signed(36,32),
                                                           conv_signed(38,32),conv_signed(37,32)),
                                                          (conv_signed(-78,32), conv_signed(-34,32), conv_signed(19,32), conv_signed(42,32), conv_signed(-8,32), conv_signed(5,32), conv_signed(56,32),
                                                           conv_signed(-7,32), conv_signed(-13,32)),
                                                          (conv_signed(-36,32), conv_signed(-20,32), conv_signed(17,32), conv_signed(11,32), conv_signed(-17,32), conv_signed(41,32), conv_signed(-5,32),
                                                          conv_signed(-45,32), conv_signed(18,32)),
                                                          (conv_signed(4,32), conv_signed(41,32), conv_signed(-11,32), conv_signed(-19,32), conv_signed(14, 32), conv_signed(-22,32), conv_signed(-42,32), conv_signed(-26,32), conv_signed(13,32)),
                                                          (conv_signed(43,32), conv_signed(24,32), conv_signed(8,32), conv_signed(41,32), conv_signed(15,32), conv_signed(0,32), conv_signed(-49,32), conv_signed(4,32), conv_signed(-23,32)),
                                                          (conv_signed(53,32), conv_signed(65,32), conv_signed(-27,32), conv_signed(-38,32), conv_signed(38,32), conv_signed(-17,32), conv_signed(-13,32), conv_signed(13,32), conv_signed(23,32)));

    component HiddenLayerNeuron is
        generic(
            bias : integer;
         --   lenght : integer;
            weights : HiddenLayerWeightArray
        );
        port ( inputArray : in ByteArray;                       -- input 
               outputValue: out unsigned(40 downto 0)           -- output
        );
    end component;

begin
    
    neurons0to9: for i in 0 to 9 generate
        n: HiddenLayerNeuron generic map(
            bias => BiasArray(i),
            weights => WeightArrayofArray(i))
                Port Map(inputArray => inputArray,
                         outputValue => outputValue(i));
            
    end generate;

end Structural;
