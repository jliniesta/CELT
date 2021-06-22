------------------------------------------------------
-- Test Bench del DETECTOR DE BITS
--
--        JT02
--
-- JAVIER LOPEZ INIESTA DIAZ DEL CAMPO
-- ANDRES CASTILLEJO AMESCUA

------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_detector_bit IS
END tb_detector_bit;
 
ARCHITECTURE behavior OF tb_detector_bit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT detector_bit
    PORT(
         CLK_1ms : IN  std_logic;
         LIN : IN  std_logic;
         BITS : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_1ms : std_logic := '0';
   signal LIN : std_logic := '0';

 	--Outputs
   signal BITS : std_logic;

   -- Clock period definitions
   constant CLK_1ms_period : time := 1 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: detector_bit PORT MAP (
          CLK_1ms => CLK_1ms,
          LIN => LIN,
          BITS => BITS
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
      wait for 100 ms;
		LIN<='1';
		wait for 2 ms;
		LIN<='0';
		wait for 1 ms;
		LIN<='1';
		wait for 97 ms;
		LIN<='0';
		wait for 2 ms;
		LIN<='1';
		wait for 1 ms;
		LIN<='0';
		wait for 97 ms;
   end process;

END;
