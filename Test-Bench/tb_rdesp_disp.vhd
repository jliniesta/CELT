------------------------------------------------------
-- Test Bench del REGISTRO DE DESPLAZAMIENTO
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
 
ENTITY tb_rdesp_disp IS
END tb_rdesp_disp;
 
ARCHITECTURE behavior OF tb_rdesp_disp IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rdesp_disp
    PORT(
         CLK_1ms : IN  std_logic;
         EN : IN  std_logic;
         E : IN  std_logic_vector(7 downto 0);
         Q0 : OUT  std_logic_vector(7 downto 0);
         Q1 : OUT  std_logic_vector(7 downto 0);
         Q2 : OUT  std_logic_vector(7 downto 0);
         Q3 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_1ms : std_logic := '0';
   signal EN : std_logic := '0';
   signal E : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Q0 : std_logic_vector(7 downto 0);
   signal Q1 : std_logic_vector(7 downto 0);
   signal Q2 : std_logic_vector(7 downto 0);
   signal Q3 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_1ms_period : time := 1 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rdesp_disp PORT MAP (
          CLK_1ms => CLK_1ms,
          EN => EN,
          E => E,
          Q0 => Q0,
          Q1 => Q1,
          Q2 => Q2,
          Q3 => Q3
        );

   -- Clock process definitions
   CLK_1ms_process :process
   begin
		CLK_1ms <= '0';
		wait for CLK_1ms_period/2;
		CLK_1ms <= '1';
		wait for CLK_1ms_period/2;
   end process;
 


   stim_proc: process
   begin		
	 wait for 1 ms;
		E<="01011000";
      wait for 899 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		E<="01011011";
      wait for 899 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		E<="00110010";
      wait for 899 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		E<="00110000";
      wait for 899 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		E<="01010100";
      wait for 899 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
		E<="01001010";
      wait for 899 ms;	
      EN<='1';
		wait for 1 ms;
		EN<='0';
 
   end process;

END;
