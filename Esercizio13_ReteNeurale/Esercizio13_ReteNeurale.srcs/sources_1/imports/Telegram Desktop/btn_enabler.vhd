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


entity btn_enabler is
    Port ( btn_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           btn_out : out STD_LOGIC);
end btn_enabler;

architecture Behavioral of btn_enabler is

begin

    
    
    btn_proc: process (clk)
         variable temp_btn : STD_LOGIC := '0';
         variable check_enable : STD_LOGIC := '0';
    begin
       
              
        if(clk 'event and clk='1') then
            if(check_enable = '1') then
                btn_out <= '0';
                check_enable := '0';
            elsif (temp_btn = '1' and btn_in = '0') then
                btn_out <= '1';
                check_enable := '1';
            else
                btn_out <= '0';
            end if;
            temp_btn := btn_in;    
        end if;
        
    end process;
    
end Behavioral;
