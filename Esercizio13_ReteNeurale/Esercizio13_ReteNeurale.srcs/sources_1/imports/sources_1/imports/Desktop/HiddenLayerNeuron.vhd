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

--type ByteArray is array (0 to 8) of std_logic_vector(7 downto 0);

entity HiddenLayerNeuron is
    generic(
        bias : integer;
     --   lenght : integer;
        weights : HiddenLayerWeightArray
    );
    port ( inputArray : in ByteArray;                     -- input 
           outputValue: out unsigned(40 downto 0)           -- output
    );
end HiddenLayerNeuron;

architecture Behavioural of HiddenLayerNeuron is
    
            

    
    begin 
    neuronProcess: process(inputArray)

       variable sum : signed(40 downto 0) := (others => '0');

        
    begin
        sum := (others =>'0');
        for i in 0 to 8 loop
            sum := sum + (unsigned(inputArray(i)) * weights(i));
        end loop;
        sum := sum + bias;

       if (sum < 0) then
           sum := (others => '0');
       end if;

        outputValue <= unsigned(sum);

    end process;



end Behavioural;