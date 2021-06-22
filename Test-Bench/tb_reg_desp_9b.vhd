------------------------------------------------------
-- Test Bench del REGISTRO DE DESPLAZAMIENTO DE 9 BITS
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

 
ENTITY tb_reg_desp_9b IS
END tb_reg_desp_9b;
 
ARCHITECTURE behavior OF tb_reg_desp_9b IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg_desp_9b
    PORT(
         CLK_1ms : IN  std_logic;
         DAT : IN  std_logic;
         EN : IN  std_logic;
         Q : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_1ms : std_logic := '0';
   signal DAT : std_logic := '0';
   signal EN : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(8 downto 0);

   -- Clock period definitions
   constant CLK_1ms_period : time := 1 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg_desp_9b PORT MAP (
          CLK_1ms => CLK_1ms,
          DAT => DAT,
          EN => EN,
          Q => Q
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
	   wait for 1 ms;
		DAT<='1';
      wait for 99 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		DAT<='0';
      wait for 99 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		DAT<='1';
      wait for 99 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		DAT<='0';
      wait for 99 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		DAT<='1';
      wait for 99 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		DAT<='0';
      wait for 99 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		DAT<='1';
      wait for 99 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		DAT<='0';
      wait for 99 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		DAT<='1';
      wait for 99 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		wait for 99 ms;	
   end process;

END;
