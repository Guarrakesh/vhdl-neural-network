----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 23:02:56
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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
USE IEEE.std_logic_arith.all;

use work.defs.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit is
  Port (
    clock: in STD_LOGIC;
    resetEnable: in STD_LOGIC;                 -- Brings into start state
    buttonEnable: in STD_LOGIC;                -- Loads input
    counter: in std_logic_vector(3 downto 0);  -- Input counter
    --networkDone: in STD_LOGIC;
    reset          : out std_logic;            -- Reset
    count          : out std_logic;            -- Count signal
    enableNetwork  : out std_logic;            -- Bit triggers neural network calculation
    terminate      : out std_logic             -- Bit high when max value is calculated and cycle is finished (can enable display or LED)
   );
end ControlUnit;

architecture Behavioral of ControlUnit is

    component MicroRom is 
        Port (
           PC             : in unsigned (stateWidth-1 downto 0);   -- Program Counter
           PC_Next        : out unsigned (stateWidth-1 downto 0);  -- Next state
           reset          : out std_logic;                         -- Reset
           count          : out std_logic;                         -- Count signal
           counterCheck   : out std_logic;                         -- Bit high when check needed for all inputs loading
           --operationCheck : out std_logic;                         -- Bit high when check needed for neural network finishes operations
           triggerCheck   : out std_logic;                         -- Bit high when check needed for trigger (button pressing)
           enableNetwork  : out std_logic;                         -- Bit triggers neural network calculation
           terminate      : out std_logic                          -- Bit high when max value is calculated and cycle is finished                        
        );
    end component;

    signal pcNext, pc: unsigned (stateWidth-1 downto 0);
    signal counterCheck, operationCheck, triggerCheck: STD_LOGIC;
    
    begin
    
    ROM: MicroRom Port Map (
            PC => pc,
            PC_Next => pcNext,
            reset => reset,
            count => count,
            counterCheck => counterCheck,
            --operationCheck => operationCheck,
            triggerCheck => triggerCheck,
            enableNetwork => enableNetwork,
            terminate => terminate
    );
    
    cuProcess: process(clock)

    begin
    
    if (clock'event and clock = '0') then
        if (resetEnable = '1') then 
            pc <= "001";                    -- Go to Start state
        elsif (counterCheck = '0') then     -- if no need to check counter go normally to next state
            pc <= pcNext;
        else
            if (counter = "1001") then      -- if counterCheck = '1' check counter value. If 9, all inputs are loaded, next state is set to Operation (100)
                pc <= "100";
            else
                pc <= pcNext;
            end if;
        end if;
        
--        elsif (triggerCheck='1' and counterCheck='1') then -- input loading state , check if inputs are fully or partially loaded
--            if (buttonEnable = '1' and counter = 9) then 
--                pc <= "010"; -- fully loaded, go to loaded state
--            else 
--                counter := counter + 1; -- partially loaded, keep the state
--                pc <= pcNext;   
--            end if;
--        elsif (counterCheck = '0' and triggerCheck = '1' and counter = 9) then -- input loaded state, check if start operation button is pressed
--            if (buttonEnable = '1') then
--                pc <= "011";
--            else pc <= pcNext;
--            end if;
--        elsif (operationCheck = '1') then -- operation state, check if network has finished calculating
--            if (networkDone = '1') then 
--                pc <= "100"; -- go to Max state
--            else pc <= pcNext;
--            end if;
--        else pc <= pcNext;
--        end if;
     
    end if;
    
    end process;
    
    count <= buttonEnable when triggerCheck = '1' else '0';     -- count signal is linked to button signal if triggerCheck equals to '1'. Otherwise is 0
   

end Behavioral;
