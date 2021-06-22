----------------------------------------------------------------------------------
--
-- Circuito que refresca los displays periódicamente
--
--        JT02
--
-- JAVIER LÓPEZ INIESTA DÍAZ DEL CAMPO
-- ANDRÉS CASTILLEJO AMESCUA
------------------------------------------------------ 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity refresco is
    Port ( CLK_1ms : in  STD_LOGIC;                  -- reloj de refresco
           S : out  STD_LOGIC_VECTOR (1 downto 0);   -- Control para el mux
           AN : out  STD_LOGIC_VECTOR (3 downto 0)); -- Control displays individuales
end refresco;

architecture a_refresco of refresco is

signal SS  : STD_LOGIC_VECTOR (1 downto 0); 

begin

process (CLK_1ms)
  begin
  if (CLK_1ms'event and CLK_1ms='1') then  
    SS<=SS+1;                      -- genera la secuencia 00,01,10 y 11
  end if;
  end process;

S<=SS;
AN<="0111" when SS="00" else   -- activa cada display en function del valor de SS
    "1011" when SS="01" else
    "1101" when SS="10" else
    "1110" when SS="11";

end a_refresco;