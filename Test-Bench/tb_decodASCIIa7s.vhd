------------------------------------------------------
-- Test Bench del DESCODIFICADOR ASCII A 7 SEGMENTOS
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
 
 
ENTITY tb_decodASCIIa7s IS
END tb_decodASCIIa7s;
 
ARCHITECTURE behavior OF tb_decodASCIIa7s IS 
 
 
    COMPONENT decodASCIIa7s
    PORT(
         CODIGO : IN  std_logic_vector(7 downto 0);
         SEGMENTOS : OUT  std_logic_vector(0 to 6)
        );
    END COMPONENT;
    

   --Inputs
   signal CODIGO : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal SEGMENTOS : std_logic_vector(0 to 6);
 
BEGIN
 
   uut: decodASCIIa7s PORT MAP (
          CODIGO => CODIGO,
          SEGMENTOS => SEGMENTOS
        );

   stim_proc: process
   begin		
		CODIGO<="01011000";
		wait for 900 ms;
		CODIGO<="01001010";
		wait for 900 ms;
		CODIGO<="01010100";
		wait for 900 ms;
		CODIGO<="00110000";
		wait for 900 ms;
		CODIGO<="00110010";
		wait for 900 ms;

   end process;

END;
