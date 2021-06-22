------------------------------------------------------
-- Test Bench del DIVISOR DE RELOJ
--
--        JT02
--
-- JAVIER LOPEZ INIESTA DIAZ DEL CAMPO
-- ANDRES CASTILLEJO AMESCUA

------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_div_reloj IS
END tb_div_reloj;
 
ARCHITECTURE behavior OF tb_div_reloj IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT div_reloj
    PORT(
         CLK : IN  std_logic;
         CLK_1ms : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';

 	--Outputs
   signal CLK_1ms : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
   constant CLK_1ms_period : time := 1 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: div_reloj PORT MAP (
          CLK => CLK,
          CLK_1ms => CLK_1ms
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
