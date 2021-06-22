------------------------------------------------------
-- DIVISOR DE RELOJ
--
--        JT02
--
-- JAVIER LPEZ INIESTA DAZ DEL CAMPO
-- ANDRS CASTILLEJO AMESCUA

--Genera una señal cuadrada de 1KHz
------------------------------------------------------ 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_reloj is
    Port ( CLK : in  STD_LOGIC;        -- Entrada de reloj de la FPGA de 50 Mhz
           CLK_1ms : out  STD_LOGIC);  -- Salida reloj a 1 KHz
end div_reloj;

architecture a_div_reloj of div_reloj is

signal contador : STD_LOGIC_VECTOR (15 downto 0):=(others=>'0'); --contador de 16 bits, inicializado a 0
signal frec_div : STD_LOGIC:='0'; --seal de frecuencia dividida,inicializado a 0

begin

	process(CLK)
    begin
	   if (CLK'event and CLK='1') then  --En cada flanco de subida de CLK
			contador<=contador + '1';	   --Se incrementa el contador en 1
      if (contador>=25000) then	      --Si llega al valor de 25000 ciclos de reloj((50MHz/1KHz)/2)
		  contador<=(others=>'0');       --poner el contador a 0
        frec_div<=not frec_div;	      --y conmutar el valor de frec_div
      end if;	 
    end if;	
	 
   end process;
	 
  CLK_1ms<=frec_div;                   --frec_div esta cableada con la salida
  
end a_div_reloj;

