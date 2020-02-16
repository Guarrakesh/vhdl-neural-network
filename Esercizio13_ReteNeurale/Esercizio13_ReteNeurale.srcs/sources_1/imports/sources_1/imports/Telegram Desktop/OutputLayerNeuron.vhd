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

entity OutputLayerNeuron is
    generic(
        bias : integer;
        weights : OutputLayerWeightArray
    );
    port ( inputArray : in OutputArrayType;               -- input 
           outputValue: out unsigned(73 downto 0)           -- output 74 = 32 + 42
    );
end OutputLayerNeuron;

architecture Behavioural of OutputLayerNeuron is
    
    
    begin 
    neuronProcess: process(inputArray)

       variable sum : signed(73 downto 0) := (others => '0');
        
    begin
        sum := (others => '0');
        for i in 0 to 9 loop
            sum := sum + (inputArray(i) * weights(i));
        end loop;
        sum := sum + bias;

        -- RELU
        if (sum < 0) then
           sum := (others => '0');
        end if;

        outputValue <= unsigned(sum);

    end process;



end Behavioural;