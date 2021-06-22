----------------------------------------------------------------------------------
--
-- Automata de captura de bits
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

entity aut_captura is
    Port ( CLK_1ms : in  STD_LOGIC;  -- Reloj del sistema
           BITS : in  STD_LOGIC;     -- Bits de entrada
			  RESET : in STD_LOGIC;		 -- Seal reset manual
           CAP : out  STD_LOGIC);    -- Seal para el registro de captura
end aut_captura;

architecture a_aut_captura of aut_captura is
type STATE_TYPE is (ESP0,ESP1,DESP25,CAPT,DESP100);

signal ST : STATE_TYPE := ESP0;
signal cont : STD_LOGIC_VECTOR (7 downto 0):="00000000";

begin
  process (CLK_1ms, RESET)
    begin
      if CLK_1ms'event and CLK_1ms='1' then
        case ST is
          when ESP0 =>
			   cont<="00000000"; --Se reinicia el contador (en caso de reset)
            if BITS='1' then
              ST<=ESP0;
            else
              ST<=ESP1;
            end if;

          when ESP1 =>
            if	RESET='1' then  --Si pulsamos el reset manual, volvemos al estado inicial ESP0
				  ST<=ESP0;
				elsif BITS='1' then
              ST<=DESP25;
            else
              ST<=ESP1;
            end if;
				
          when DESP25 =>
            cont<=cont+1;
            if	RESET='1' then --Si pulsamos el reset manual, volvemos al estado inicial ESP0
				  ST<=ESP0;
				elsif cont>=25 then
              ST<=CAPT;
            else
              ST<=DESP25;
            end if;
   
          when CAPT =>
            cont<="00000000";
				if	RESET='1' then --Si pulsamos el reset manual, volvemos al estado inicial ESP0
					ST<=ESP0;
				end if;
            ST<=DESP100;
			
          when DESP100 =>
            cont<=cont+1;
            if	RESET='1' then --Si pulsamos el reset manual, volvemos al estado inicial ESP0
				  ST<=ESP0;
				elsif cont>=98 then
              ST<=CAPT;
            else
              ST<=DESP100;
            end if;			
 
         end case;		
       end if;
    end process;
	 
  with ST select CAP <= 
	'1' when CAPT,
	'0' when others;
  
end a_aut_captura;

