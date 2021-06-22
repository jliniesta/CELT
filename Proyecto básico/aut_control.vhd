----------------------------------------------------------------------------------
--
-- Autmata de control
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

entity aut_control is
    Port ( CLK_1ms : in  STD_LOGIC;                     -- Reloj del sistema
           ASCII : in  STD_LOGIC_VECTOR (8 downto 0);   -- Datos de entrada del registro
           VALID_DISP : out  STD_LOGIC);                -- Salida para validar el display
	
end aut_control;

architecture a_aut_control of aut_control is

constant SYNC : STD_LOGIC_VECTOR (8 downto 0) := "100000001"; -- carcter SYNC

type STATE_TYPE is (ESP_SYNC,ESP_CHAR,VALID_CHAR);
signal ST : STATE_TYPE:=ESP_SYNC;
signal cont : STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";

begin
  process (CLK_1ms)
    begin
      if (CLK_1ms'event and CLK_1ms='1') then --En cada flanco de subida de CLK_1ms
        case ST is
          when ESP_SYNC => --Espera que la entrada (de 9 bits) sea igual al valor de SYNC (100000001)
            if ASCII=SYNC then   -- Esperar los bits sincronismo
              ST<=ESP_CHAR;	   -- Si se reciben dichos bits, se pasa al estado ESP_CHAR
            else
              ST<=ESP_SYNC;
            end if;	

          when ESP_CHAR => --Espera 900 ms
            cont<=cont+1;  -- Incrementa un contador
            if cont>=898 then --Repite el estado hasta que llega a 898
              ST<=VALID_CHAR; --Cuando llega a 898 pasa a VALID_CHAR
            else
              ST<=ESP_CHAR;
            end if;	
				
          when VALID_CHAR => --Válida el cáracter en el display)
            cont<="0000000000000000"; --Pone a 0 el contador
            ST<=ESP_CHAR;		        --Pasa al estado ESP_CHAR		
         end case;	
      end if;
    end process;
	 
with ST select VALID_DISP <= -- Asignación de la salida
	'1' when VALID_CHAR, --Activa la señal VALID_DISP en el estado VALID_CHAR
	'0' when others;	   --Para el resto de estados VALID_DISP vale 0
 
end a_aut_control;

