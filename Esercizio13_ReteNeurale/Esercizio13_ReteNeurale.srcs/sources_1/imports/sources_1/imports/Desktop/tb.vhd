----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 11:51:23
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
signal input : ByteArray;
signal output : signed(40 downto 0);

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

    
    uut: HiddenLayerNeuron generic map(
            bias => -8,
            weights => (conv_signed(27,32), conv_signed(-46,32), conv_signed(9,32), conv_signed(15,32), conv_signed(-15,32), conv_signed(-33,32),conv_signed(20,32), 
             conv_signed(30,32), conv_signed(-25,32))
            )
    Port Map(
                inputArray => input, 
                outputValue => output
                );
                
     stim_proc: process
     begin
  
        wait for 5 ns;
--       input <= (conv_std_logic_vector(59,8), conv_std_logic_vector(125,8), conv_std_logic_vector(112,8), conv_std_logic_vector(129,8), conv_std_logic_vector(88,8), conv_std_logic_vector(131,8),conv_std_logic_vector(125,8), 
--           conv_std_logic_vector(164,8), conv_std_logic_vector(155,8));
        
        input <= (conv_std_logic_vector(59,8), conv_std_logic_vector(0,8), conv_std_logic_vector(0,8), conv_std_logic_vector(0,8), conv_std_logic_vector(0,8), conv_std_logic_vector(0,8),conv_std_logic_vector(0,8), 
          conv_std_logic_vector(0,8), conv_std_logic_vector(0,8));
           
           --27*59+112*9=2601
        
        wait for 5 ns;
        --1593-5750+1008+1935-1320-4323+2500+4920-3875-8=3320
        
        wait;
        
    end process;
                


--1593-5750+1008+2322-1320-4323+2500+4920-3875-8 = -2933 = 0


end Behavioral;


