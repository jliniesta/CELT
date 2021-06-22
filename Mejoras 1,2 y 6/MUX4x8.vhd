----------------------------------------------------------------------------------
--
--  MUX4x8
--
--  Multiplexor de 4 entradas de datos de 8 bits
--
--        JT02
--
-- JAVIER LOPEZ INIESTA DIAZ DEL CAMPO
-- ANDRES CASTILLEJO AMESCUA
------------------------------------------------------ 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MUX4x8 is
    Port ( E0 : in  STD_LOGIC_VECTOR (7 downto 0);  -- Entrada de datos 0
           E1 : in  STD_LOGIC_VECTOR (7 downto 0);  -- Entrada de datos 1
           E2 : in  STD_LOGIC_VECTOR (7 downto 0);  -- Entrada de datos 2
           E3 : in  STD_LOGIC_VECTOR (7 downto 0);  -- Entrada de datos 3
           S : in  STD_LOGIC_VECTOR (1 downto 0);   -- Seal de control
           Y : out  STD_LOGIC_VECTOR (7 downto 0)); -- Salida
end MUX4x8;

architecture a_MUX4x8 of MUX4x8 is

begin

Y <= E0 when S="00" else  -- se selecciona la salida en funcion de las entradas de control
     E1 when S="01" else
     E2 when S="10" else
     E3 when S="11";	  
	  
end a_MUX4x8;

