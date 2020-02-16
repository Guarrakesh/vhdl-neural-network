----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2019 17:43:32
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
USE IEEE.std_logic_arith.all;

use work.defs.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_nodeb is
--  Port ( );
end tb_nodeb;

architecture Behavioral of tb_nodeb is

    constant clk_period: Time := 2 ns;
    constant number_of_periods: integer := 500;
    
    signal clk_signal : STD_LOGIC := '0';
    signal reset_signal : STD_LOGIC := '0';
    signal buttonEnable_signal : STD_LOGIC := '0';
    signal input_signal : std_logic_vector(7 downto 0);
    signal anodes_signal : std_logic_vector(7 downto 0);
    signal cathodes_signal : std_logic_vector(7 downto 0);
    signal pc_out_signal: unsigned (stateWidth-1 downto 0);
    
    component NeuralNetworkOnBoard is
       Port ( 
            clock: in std_logic;
            reset: in std_logic;
            buttonEnable: in std_logic;
            input: in std_logic_vector(7 downto 0);
            anodes : out  STD_LOGIC_VECTOR (7 downto 0);
            cathodes : out  STD_LOGIC_VECTOR (7 downto 0);
            pc_out: out unsigned (stateWidth-1 downto 0)
       );
    end component;

begin
    uut: NeuralNetworkOnBoard Port Map (clock => clk_signal, 
                                        reset => reset_signal, 
                                        buttonEnable => buttonEnable_signal, 
                                        input => input_signal,
                                        anodes => anodes_signal,
                                        cathodes => cathodes_signal,
                                        pc_out => pc_out_signal);

    clk_proc: process
    begin
        wait for clk_period;
        for i in 0 to number_of_periods-1 loop
            clk_signal <= not clk_signal;
            wait for clk_period;
        end loop;
        wait;
    end process;
    
    stim_proc: process
    begin
        wait for 3 ns;
        reset_signal <= '1';
        wait for 2 ns;
        reset_signal <= '0';
        wait for 8 ns;
        input_signal <= "01001000";
        buttonEnable_signal <= '1';
        wait for 6 ns;
        buttonEnable_signal <= '0';
        wait for 6 ns;
        input_signal <= "01111100";
        buttonEnable_signal <= '1';
        wait for 6 ns;
        buttonEnable_signal <= '0';
        wait for 6 ns;
        input_signal <= "10001101";
        buttonEnable_signal <= '1';
        wait for 6 ns;
        buttonEnable_signal <= '0';
        wait for 6 ns;
        input_signal <= "10000001";
        buttonEnable_signal <= '1';
        wait for 6 ns;
        buttonEnable_signal <= '0';
        wait for 6 ns;
        input_signal <= "01001101";
        buttonEnable_signal <= '1';
        wait for 6 ns;
        buttonEnable_signal <= '0';
        wait for 6 ns;
        input_signal <= "10000011";
        buttonEnable_signal <= '1';
        wait for 6 ns;
        buttonEnable_signal <= '0';
        wait for 6 ns;
        input_signal <= "10001100";
        buttonEnable_signal <= '1';
        wait for 6 ns;
        buttonEnable_signal <= '0';
        wait for 6 ns;
        input_signal <= "10110110";
        buttonEnable_signal <= '1';
        wait for 6 ns;
        buttonEnable_signal <= '0';
        wait for 6 ns;
        input_signal <= "10101001";
        buttonEnable_signal <= '1';
        wait for 6 ns;
        buttonEnable_signal <= '0';
        wait for 40 ns;
        reset_signal <= '1';
        wait for 2 ns;
        reset_signal <= '0';
        
        wait;
    end process;
end Behavioral;
