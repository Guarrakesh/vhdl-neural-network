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

entity MicroROM is 
    port ( PC             : in unsigned (stateWidth-1 downto 0);   -- Program Counter
           PC_Next        : out unsigned (stateWidth-1 downto 0);  -- Next state
           reset          : out std_logic;                         -- Reset
           count          : out std_logic;                         -- Count signal
           counterCheck   : out std_logic;                         -- Bit high when check needed for all inputs loading
           --operationCheck : out std_logic;                         -- Bit high when check needed for neural network finishes operations
           triggerCheck   : out std_logic;                         -- Bit high when check needed for trigger (button pressing)
           enableNetwork  : out std_logic;                         -- Bit triggers neural network calculation
           terminate      : out std_logic                          -- Bit high when max value is calculated and cycle is finished
    );
end MicroROM;


architecture Behavioural of MicroROM is

    type ControlType is record
        PC_Next        : unsigned (stateWidth-1 downto 0);  -- Next state
        reset          : std_logic;                         -- Reset
        count          : std_logic;                         -- Count signal
        counterCheck   : std_logic;                         -- Bit high when check needed for all inputs loading
        --operationCheck : std_logic;                         -- Bit high when check needed for neural network finishes operations
        triggerCheck   : std_logic;                         -- Bit high when check needed for trigger (button pressing)
        enableNetwork  : std_logic;                         -- Neural network enabler
        terminate      : std_logic;                         -- Bit high when max value is calculated and cycle is finished
    end record;

    constant Idle: ControlType := (             -- Idle: all signals set to '0'
        PC_Next        => "000",
        reset          => '0',
        count          => '0',
        counterCheck   => '0',
        --operationCheck => '0',
        triggerCheck   => '0',                  
        enableNetwork  => '0',
        terminate      => '1'
    );
    
     constant Start: ControlType := (             -- Start: temporary state, resets all components
        PC_Next        => "010",
        reset          => '1',
        count          => '0',
        counterCheck   => '0',
        --operationCheck => '0',
        triggerCheck   => '0',                  
        enableNetwork  => '0',
        terminate      => '0'
    );

    constant InputLoading: ControlType := (                 
        PC_Next        => "010",                -- Next state is same state, but will be corrected to "010" (InputLoaded) when counter = Number of Inputs (managed by CU)
        reset          => '0',
        count          => '0',                  -- To be converted to 1 if button is pressed
        counterCheck   => '1',                  -- Flag high because need to check counter value 
        --operationCheck => '0',  
        triggerCheck   => '1',                  -- Flag high because need to check button pression
        enableNetwork  => '0',
        terminate      => '0'
    );

    constant Operation: ControlType := (
        PC_Next        => "100",                -- Next state is same state, but will be corrected to "100" (Max) when calculation is finished
        reset          => '0',
        count          => '0',
        triggerCheck   => '0',
        counterCheck   => '0',
        --operationCheck => '1',                -- Flag high because need to check if operation is finished
        enableNetwork  => '1',                  -- Neural Network is enabled
        terminate      => '0'
    );

    constant Final: ControlType := (
        PC_Next        => "000",                 -- Next state is "000" (Idle)
        reset          => '0',                   
        count          => '0',
        triggerCheck   => '0',
        counterCheck   => '0',
        --operationCheck => '0',
        enableNetwork  => '0',
        terminate      => '1'                    -- Terminate signal is enabled, a decision is taken after neural network output evaluation
    );

    type ROMType is array(0 to 4) of ControlType;
    
    -- Loading ROM with sequences for each state
    constant ROM: RomType := (
        0 => Idle,
        1 => Start,
        2 => InputLoading,
        3 => Operation,
        4 => Final
    );

    signal control : ControlType;
        
    begin

        -- Loading PC slice of ROM with PC input value 
        control <= ROM(conv_integer(PC));
        
        -- Generate ROM output
        PC_next <= control.PC_next;
        reset <= control.reset;
        triggerCheck <= control.triggerCheck;
        counterCheck <= control.counterCheck;
        --operationCheck <= control.operationCheck;
        terminate <= control.terminate;

end Behavioural;