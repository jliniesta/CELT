----------------------------------------------------------------------------------
--
-- Automata de control
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
			  RESET : in STD_LOGIC;								  -- Seal de reset
			  R_aux1 : out STD_LOGIC; 							  -- Salida reset cableada con rdesp_disp
           VALID_DISP : out  STD_LOGIC);                -- Salida para validar el display
	
end aut_control;

architecture a_aut_control of aut_control is

constant SYNC : STD_LOGIC_VECTOR (8 downto 0) := "100000001"; -- caracter SYNC

type STATE_TYPE is (ESP_SYNC,ESP_CHAR,VALID_CHAR);
signal ST : STATE_TYPE:=ESP_SYNC;
signal cont : STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";

begin
  process (CLK_1ms, RESET)
    begin
      if (CLK_1ms'event and CLK_1ms='1') then
        case ST is
          when ESP_SYNC =>
			   cont<="0000000000000000"; --Se reinicia el contador (en caso de RESET), ya que inicialmente siempre vale 0
            if ASCII=SYNC then   -- Esperar por el SYNC
              ST<=ESP_CHAR;
            else
              ST<=ESP_SYNC;
            end if;	
				
			R_aux1<='0'; --Seal para apagar displays, inicialmente a nivel bajo
			
          when ESP_CHAR =>
            cont<=cont+1;
            if	RESET='1' then --Si el RESET manual esta activo, volvemos al estado inicial, ESP_SYNC
				  ST<=ESP_SYNC;
				  R_aux1<='1'; -- Activamos la seal R_aux1 para apagar los displays
				elsif ASCII="000000000" then --Si se detecta una cadena de 9 ceros
				  ST<=ESP_SYNC; --Se vuelve al estado inicial, ESP_SYNC
				  R_aux1<='1';-- Activamos la seal R_aux1 para apagar los displays
				elsif cont>=898 then
              ST<=VALID_CHAR;
            else
              ST<=ESP_CHAR;
            end if;
								
          when VALID_CHAR =>
            cont<="0000000000000000";
            if	RESET='1' then  --Si el RESET manual esta activo, volvemos al estado inicial, ESP_SYNC
				  ST<=ESP_SYNC;
				  R_aux1<='1'; -- Activamos la seal R_aux1 para apagar los displays
				elsif ASCII="000000000" then --Si se detecta una cadena de 9 ceros
				  ST<=ESP_SYNC; --Se vuelve al estado inicial, ESP_SYNC
				  R_aux1<='1';-- Activamos la seal R_aux1 para apagar los displays
				end if;
				ST<=ESP_CHAR;	

         end case;	
      end if;
    end process;
	 
with ST select VALID_DISP <= 
	'1' when VALID_CHAR, -- Asignacion de la salida
	'0' when others;
 
end a_aut_control;

