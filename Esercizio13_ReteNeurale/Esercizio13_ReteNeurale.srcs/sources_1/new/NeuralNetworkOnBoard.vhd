----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2020 11:33:55 AM
-- Design Name: 
-- Module Name: NeuralNetworkOnBoard - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

USE IEEE.std_logic_arith.all;

use work.defs.all;

entity NeuralNetworkOnBoard is
   Port ( 
        clock: in std_logic;
        reset: in std_logic;
        buttonEnable: in std_logic;
        input: in std_logic_vector(7 downto 0);
        anodes : out  STD_LOGIC_VECTOR (7 downto 0);
        cathodes : out  STD_LOGIC_VECTOR (7 downto 0)
   );
end NeuralNetworkOnBoard;

architecture Behavioral of NeuralNetworkOnBoard is

    component ControlUnit is
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
    end component;
    
    component CounterMod16 is
        Port ( clock : in  STD_LOGIC;
               reset : in  STD_LOGIC;
    		   count : in STD_LOGIC;
               counter : out  STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component DisplayManager is
        Port (
            enable : in std_logic; 
            input : in std_logic_vector(2 downto 0);
            anodes : out  STD_LOGIC_VECTOR (7 downto 0);
            cathodes : out  STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
--    component display_seven_segments is
--	Generic( 
--				clock_frequency_in : integer := 100000000; --parametri da customizzare, questo � il valore di default
--				clock_frequency_out : integer := 1000000
--				);
--    Port ( clock : in  STD_LOGIC;
--           reset_n : in  STD_LOGIC;
--           value : in  STD_LOGIC_VECTOR (31 downto 0);
--           enable : in  STD_LOGIC_VECTOR (7 downto 0);
--           dots : in  STD_LOGIC_VECTOR (7 downto 0);
--           anodes : out  STD_LOGIC_VECTOR (7 downto 0);
--           cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
--    end component;
    
    component InputManager is
        Port (
              clock: in std_logic;
              reset: in std_logic; 
              buttonEnable: in std_logic;                   -- Enabled for each input
              enableNetwork: in std_logic;                  -- Enabled when all input are loaded
              countValue: in std_logic_vector(3 downto 0);  -- CounterValue to access input index
              input: in std_logic_vector(7 downto 0);       -- Actual input
              networkInput: out ByteArray                   -- Array to be sent to Neural Network
        );
    end component;
    
    component Max is
          Port ( 
                input: in ArrayLayerOutput;
                output: out std_logic_vector(2 downto 0)
          );
    end component;
    
    component clock_filter is
    	 generic(
    				clock_frequency_in : integer := 100000000;
    				clock_frequency_out_debouncing : integer := 100;
    				clock_frequency_out_components : integer := 1
    				);
        Port ( clock_in : in  STD_LOGIC;
    		   reset : in STD_LOGIC;
               clockOutDebouncing : out  STD_LOGIC;
               clockOutComponents : out std_logic
               );

    end component;
    
    component Network is
      Port ( 
        inputArray : in ByteArray;
        outputValue: out ArrayLayerOutput
      );
    end component;
    
    component debouncing is
    Port ( button : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           button_result : out STD_LOGIC);
    end component;
    
    component btn_enabler is
    Port ( btn_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           btn_out : out STD_LOGIC);
    end component;
    
    
    -- internal signals for clock
    signal clockDebouncing: std_logic := '0';
    signal clockComponents: std_logic := '0';
    
    -- internal signals for inputManager
    signal internalEnableNetwork: std_logic := '0';
    signal internalCountValue: std_logic_vector(3 downto 0) := (others => '0');
    signal internalNetworkInput: ByteArray := (others => (others => '0'));
    
    -- internal signals for counter
    signal internalReset: std_logic := '0';
    signal internalCount: std_logic := '0';
    
    signal internalDisplayEnabler: std_logic := '0';
    signal internalNetworkOutput: ArrayLayerOutput;
    
    signal internalOutputIndex: std_logic_vector(2 downto 0) := (others => '0');

    signal internalButton: std_logic := '0';
    signal internalButtonFixed: std_logic := '0';
    
begin


    clockFilter: clock_filter generic map (
        clock_frequency_in => 100000000,
    	clock_frequency_out_debouncing => 100,
    	clock_frequency_out_components => 10000
    )
    port map (
        clock_in => clock,
        reset => reset,
        clockOutDebouncing => clockDebouncing,
        clockOutComponents => clockComponents
    );
    
    debouncingComponent: debouncing
        Port map ( 
            button => buttonEnable,
            clk => clockDebouncing,
            reset => internalReset,
            button_result => internalButton
     );
     
     buttonEnabler: btn_enabler
     Port map ( 
            btn_in => internalButton,
            clk => clockComponents,
            btn_out => internalButtonFixed
     );
    
    inputManagerComponent: InputManager 
        Port map (
              clock => clockComponents,
              reset => internalReset, 
              buttonEnable => internalButtonFixed,                         -- Enabled for each input
              enableNetwork => internalEnableNetwork,                 -- Enabled when all input are loaded
              countValue => internalCountValue,                        -- CounterValue to access input index
              input => input,                                           -- Actual input
              networkInput => internalNetworkInput                   -- Array to be sent to Neural Network
        );
        
     
     counterComponent: CounterMod16
        Port map(
             clock => clockComponents,
             reset => internalReset,
    		 count => internalCount,
             counter => internalCountValue
    );
    
     controlUnitComponent: ControlUnit
      Port map (
            clock => clockComponents,
            resetEnable => reset,                       -- Brings into start state
            buttonEnable => internalButtonFixed,               -- Loads input
            counter => internalCountValue,              -- Input counter
            --networkDone: in STD_LOGIC;
            reset => internalReset,                     -- Reset
            count => internalCount,                     -- Count signal
            enableNetwork => internalEnableNetwork,     -- Bit triggers neural network calculation
            terminate => internalDisplayEnabler         -- Bit high when max value is calculated and cycle is finished (can enable display or LED)
       );
       
       
     neuralNetworkComponent: Network
        Port map ( 
            inputArray => internalNetworkInput,
            outputValue => internalNetworkOutput
     );
      
      
     maxComponent: Max
        Port map ( 
            input => internalNetworkOutput,
            output => internalOutputIndex
     );
     
     displayManagerComponent: DisplayManager
        Port map (
            enable => internalDisplayEnabler,
            input => internalOutputIndex,
            anodes => anodes,
            cathodes => cathodes
        );


      
      
    
    
    

end Behavioral;
