------------------------------------------------------
-- Test Bench del AUTOMATA DE CONTROL
--
--        JT02
--
-- JAVIER LOPEZ INIESTA DIAZ DEL CAMPO
-- ANDRES CASTILLEJO AMESCUA

------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

 
ENTITY tb_aut_control IS
END tb_aut_control;
 
ARCHITECTURE behavior OF tb_aut_control IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT aut_control
    PORT(
         CLK_1ms : IN  std_logic;
         ASCII : IN  std_logic_vector(8 downto 0);
         VALID_DISP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_1ms : std_logic := '0';
   signal ASCII : std_logic_vector(8 downto 0) := (others => '0');

 	--Outputs
   signal VALID_DISP : std_logic;
 
   -- Clock period definitions
   constant CLK_1ms_period : time := 1 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: aut_control PORT MAP (
          CLK_1ms => CLK_1ms,
          ASCII => ASCII,
          VALID_DISP => VALID_DISP
        );

   -- Clock process definitions
   CLK_1ms_process :process
   begin
		CLK_1ms <= '0';
		wait for CLK_1ms_period/2;
		CLK_1ms <= '1';
		wait for CLK_1ms_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 201 ms;
		ASCII<="000000001";
		wait for 100 ms;
		ASCII<="000000010";
		wait for 100 ms;
		ASCII<="000000100";
		wait for 100 ms;
		ASCII<="000001000";
		wait for 100 ms;
		ASCII<="000010000";
		wait for 100 ms;
		ASCII<="000100000";
		wait for 100 ms;
		ASCII<="001000000";
		wait for 100 ms;
		ASCII<="010000000";
		wait for 100 ms;
		ASCII<="100000001";
		wait for 100 ms;     -- SYNC
		
		ASCII<="000000011";
		wait for 100 ms;
		ASCII<="000000110";
		wait for 100 ms;
		ASCII<="000001101";
		wait for 100 ms;
		ASCII<="000011010";
		wait for 100 ms;
		ASCII<="000110100";
		wait for 100 ms;
		ASCII<="001101000";
		wait for 100 ms;
		ASCII<="011010000";
		wait for 100 ms;
		ASCII<="110100000";
		wait for 100 ms;
		ASCII<="101000001";  -- A
		wait for 100 ms;
		
		ASCII<="010000011";
		wait for 100 ms;
		ASCII<="100000110";
		wait for 100 ms;
		ASCII<="000001101";
		wait for 100 ms;
		ASCII<="000011010";
		wait for 100 ms;
		ASCII<="000110100";
		wait for 100 ms;
		ASCII<="001101000";
		wait for 100 ms;
		ASCII<="011010000";
		wait for 100 ms;
		ASCII<="110100001";
		wait for 100 ms;
		ASCII<="101000010";  -- B
		wait for 100 ms;
		
		
   end process;

END;
