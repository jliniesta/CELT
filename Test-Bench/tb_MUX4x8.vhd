------------------------------------------------------
-- Test Bench del MULTIPLEXOR 
--
--        JT02
--
-- JAVIER LOPEZ INIESTA DIAZ DEL CAMPO
-- ANDRES CASTILLEJO AMESCUA

------------------------------------------------------ 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY tb_MUX4x8 IS
END tb_MUX4x8;
 
ARCHITECTURE behavior OF tb_MUX4x8 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX4x8
    PORT(
         E0 : IN  std_logic_vector(7 downto 0);
         E1 : IN  std_logic_vector(7 downto 0);
         E2 : IN  std_logic_vector(7 downto 0);
         E3 : IN  std_logic_vector(7 downto 0);
         S : IN  std_logic_vector(1 downto 0);
         Y : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal E0 : std_logic_vector(7 downto 0) := (others => '0');
   signal E1 : std_logic_vector(7 downto 0) := (others => '0');
   signal E2 : std_logic_vector(7 downto 0) := (others => '0');
   signal E3 : std_logic_vector(7 downto 0) := (others => '0');
   signal S : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Y : std_logic_vector(7 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX4x8 PORT MAP (
          E0 => E0,
          E1 => E1,
          E2 => E2,
          E3 => E3,
          S => S,
          Y => Y
        );

E0<="01010101";
E1<="00001111";
E2<="00110011";
E3<="10101010";

S<="00" after 1 ms,
	"01" after 2 ms,
	"10" after 3 ms,
	"11" after 4 ms,
	"00" after 5 ms,
	"01" after 6 ms,
	"10" after 7 ms,
	"11" after 8 ms,
	"00" after 9 ms,
	"01" after 10 ms,
	"10" after 11 ms,
	"11" after 12 ms;
END;
