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

entity tb2 is
--  Port ( );
end tb2;

architecture Behavioral of tb2 is
signal input : ByteArray;
signal output : ArrayLayerOutput;

    component Network is
      Port ( 
        inputArray : in ByteArray;
        outputValue: out ArrayLayerOutput
      );
    end component;
begin

    
    uut: Network Port Map(
                inputArray => input, 
                outputValue => output
            );
                
     stim_proc: process
     begin
  
        wait for 5 ns;

 --   input <= (conv_std_logic_vector(59,8), conv_std_logic_vector(125,8), conv_std_logic_vector(112,8), conv_std_logic_vector(129,8), conv_std_logic_vector(88,8), conv_std_logic_vector(131,8),conv_std_logic_vector(125,8), 
              -- conv_std_logic_vector(164,8), conv_std_logic_vector(155,8));
--      input <= (conv_std_logic_vector(72,8), conv_std_logic_vector(124,8), conv_std_logic_vector(141,8), conv_std_logic_vector(129,8), conv_std_logic_vector(77,8), conv_std_logic_vector(131,8),conv_std_logic_vector(140,8), 
--                 conv_std_logic_vector(182,8), conv_std_logic_vector(169,8));
           --        input <= (conv_std_logic_vector(1,8), conv_std_logic_vector(0,8), conv_std_logic_vector(0,8), conv_std_logic_vector(0,8), conv_std_logic_vector(0,8), conv_std_logic_vector(0,8),conv_std_logic_vector(0,8), 
--          conv_std_logic_vector(0,8), conv_std_logic_vector(0,8
--            input <= (conv_std_logic_vector(67,8), conv_std_logic_vector(124,8), conv_std_logic_vector(122,8), conv_std_logic_vector(129,8), conv_std_logic_vector(98,8), conv_std_logic_vector(131,8),conv_std_logic_vector(128,8), 
--              conv_std_logic_vector(157,8), conv_std_logic_vector(147,8));     
--                input <= (conv_std_logic_vector(26,8), conv_std_logic_vector(124,8), conv_std_logic_vector(110,8), conv_std_logic_vector(129,8), conv_std_logic_vector(88,8), conv_std_logic_vector(131,8),conv_std_logic_vector(147,8), 
--              conv_std_logic_vector(164,8), conv_std_logic_vector(149,8));   
             --test7
--               input <= (conv_std_logic_vector(149,8), conv_std_logic_vector(124,8), conv_std_logic_vector(133,8), conv_std_logic_vector(129,8), conv_std_logic_vector(79,8), conv_std_logic_vector(131,8),conv_std_logic_vector(85,8), 
--              conv_std_logic_vector(178,8), conv_std_logic_vector(179,8));     
        --test 23
         input <= (conv_std_logic_vector(203,8), conv_std_logic_vector(124,8), conv_std_logic_vector(173,8), conv_std_logic_vector(129,8), conv_std_logic_vector(105,8), conv_std_logic_vector(131,8),conv_std_logic_vector(82,8), 
                  conv_std_logic_vector(160,8), conv_std_logic_vector(161,8));   
           --27*59+112*9=2601
        
        wait for 5 ns;
        --1593-5750+1008+1935-1320-4323+2500+4920-3875-8=3320
        
        wait;
        
    end process;
                


--1593-5750+1008+2322-1320-4323+2500+4920-3875-8 = -2933 = 0


end Behavioral;


