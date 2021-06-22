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
           CAP : out  STD_LOGIC);    -- Seal para el registro de captura
end aut_captura;

architecture a_aut_captura of aut_captura is
type STATE_TYPE is (ESP0,ESP1,DESP25,CAPT,DESP100);

signal ST : STATE_TYPE := ESP0;
signal cont : STD_LOGIC_VECTOR (7 downto 0):="00000000";

begin
  process (CLK_1ms)
    begin
      if CLK_1ms'event and CLK_1ms='1' then
        case ST is
          when ESP0 =>
            if BITS='1' then
              ST<=ESP0;
            else
              ST<=ESP1;
            end if;

          when ESP1 =>
				if BITS='1' then
              ST<=DESP25;
            else
              ST<=ESP1;
            end if;
				
          when DESP25 =>
            cont<=cont+1;
				if cont>=25 then
              ST<=CAPT;
            else
              ST<=DESP25;
            end if;
   
          when CAPT =>
            cont<="00000000";
            ST<=DESP100;
			
          when DESP100 =>
            cont<=cont+1;
				if cont>=98 then
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

