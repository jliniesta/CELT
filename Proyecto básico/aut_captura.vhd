----------------------------------------------------------------------------------
--
-- Autmata de captura de bits
--
--        JT02
--
-- JAVIER LPEZ INIESTA DAZ DEL CAMPO
-- ANDRS CASTILLEJO AMESCUA
------------------------------------------------------ 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity aut_captura is
    Port ( CLK_1ms : in  STD_LOGIC;  -- Reloj del sistema
           BITS : in  STD_LOGIC;     -- Bits de entrada
           CAP : out  STD_LOGIC);    -- Señal para el registro de captura
end aut_captura;

architecture a_aut_captura of aut_captura is
type STATE_TYPE is (ESP0,ESP1,DESP25,CAPT,DESP100);

signal ST : STATE_TYPE := ESP0;
signal cont : STD_LOGIC_VECTOR (7 downto 0):="00000000";

begin

--automata

  process (CLK_1ms)
    begin
      if CLK_1ms'event and CLK_1ms='1' then
        case ST is
          when ESP0 => --Espera por un bit a '0'.Si lo recibe pasa a ESP1
            if BITS='1' then
              ST<=ESP0;
            else
              ST<=ESP1;
            end if;

          when ESP1 => --Espera por un bit a '1'. Si lo recibe pasa a DESP25
            if BITS='1' then
              ST<=DESP25;
            else
              ST<=ESP1;
            end if;
				
          when DESP25 => --Desplazamiento de 25 ms
            cont<=cont+1; --Incrementa un contador
            if cont>=25 then -- cuando el contador llega a 25 pasa a CAPT
              ST<=CAPT;  
            else
              ST<=DESP25; --Se repite el estado hasta que el contador llega a 25
            end if;
   
          when CAPT =>
            cont<="00000000"; --Pone el contador a 0
            ST<=DESP100; -- Pasa siempre a DESP100
						
          when DESP100 => --Desplazamiento de 100 ms
            cont<=cont+1; --Incrementa un contador
            if cont>=98 then --Espera 98 ms (98 ciclos de reloj, porque los desplazamientos hacia y desde el estado CAPT implican 
              ST<=CAPT;      --2 ms más, totalizando los 100 ms que son necesarios) utilizando el contador
            else
              ST<=DESP100;
            end if;			
 
         end case;		
       end if;
    end process;

--asignación de salida	 
  with ST select CAP <= 
	'1' when CAPT, --Cuando se encuentra en el estado CAPT, activa la señal CAP
	'0' when others; --En los demás estados CAP=0
  
end a_aut_captura;

