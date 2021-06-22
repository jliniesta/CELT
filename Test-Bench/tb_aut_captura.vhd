------------------------------------------------------
-- Test Bench del automata de captura  
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
 
 
ENTITY tb_aut_captura IS
END tb_aut_captura;
 
ARCHITECTURE behavior OF tb_aut_captura IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT aut_captura
    PORT(
         CLK_1ms : IN  std_logic;
         BITS : IN  std_logic;
         CAP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_1ms : std_logic := '0';
   signal BITS : std_logic := '0';

 	--Outputs
   signal CAP : std_logic;

   -- Clock period definitions
   constant CLK_1ms_period : time := 1 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: aut_captura PORT MAP (
          CLK_1ms => CLK_1ms,
          BITS => BITS,
          CAP => CAP
        );

   -- Clock process definitions
   CLK_1ms_process :process
   begin
		CLK_1ms <= '1';
		wait for CLK_1ms_period/2;
		CLK_1ms <= '0';
		wait for CLK_1ms_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
      BITS<='0';
		wait for 100 ms;	
		BITS<='1';       -- comienza SYNC
		wait for 100 ms;
      BITS<='0';
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
      BITS<='0';
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
		BITS<='1';
		wait for 100 ms;
		
		BITS<='1';        -- comienza A
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
		BITS<='1';
		wait for 100 ms;
      BITS<='0';
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
		BITS<='0';
		wait for 100 ms;
		BITS<='1';
		wait for 100 ms;
		
		
      wait;
   end process;

END;
