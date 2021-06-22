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
			  RESET : in STD_LOGIC;								  -- Seal de reset
			  R_aux1 : out STD_LOGIC; 							  -- Salida reset rdesp_disp
			  error1 : out STD_LOGIC;
			  led :    out STD_LOGIC;
           VALID_DISP : out  STD_LOGIC);                -- Salida para validar el display
	
end aut_control;

architecture a_aut_control of aut_control is

constant SYNC : STD_LOGIC_VECTOR (8 downto 0) := "100000001"; -- carcter SYNC
constant ESPACIO : STD_LOGIC_VECTOR (8 downto 0) := "100100000"; -- carcter espacio

type STATE_TYPE is (ESP_SYNC,ESP_CHAR,VALID_CHAR,ERROR);
signal ST : STATE_TYPE:=ESP_SYNC;
signal cont : STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
signal mal  : STD_LOGIC:='0';

begin

	process (CLK_1ms)
	begin


      if (CLK_1ms'event and CLK_1ms='1') then
        case ST is
          when ESP_SYNC =>
			   cont<="0000000000000000";
				led<='0';
				error1<='0';
				mal<='0';
            if ASCII=SYNC then   -- Esperar por el SYNC
              ST<=ESP_CHAR;
            else
              ST<=ESP_SYNC;
            end if;	
			R_aux1<='0';
          when ESP_CHAR =>
            cont<=cont+1;
				if cont>=898 then
              ST<=VALID_CHAR;
            else
              ST<=ESP_CHAR;
            end if;
				
				
          when VALID_CHAR =>
            cont<="0000000000000000";
					 if ((ASCII(7)='0') and (ASCII(6 downto 0)/="0000000")) then
						mal<='1';
					 elsif (ASCII="110010000") then
						mal<='0';
					 elsif (ASCII="010010000") then
						mal<='0';
					 elsif (("110011000"<=ASCII) and (ASCII<="110011100")) then
						mal<='0';
					 elsif (("010011000"<=ASCII) and (ASCII<="010011100")) then
						mal<='0';
					 elsif (("010100000"<=ASCII) and (ASCII<="010101101")) then
						mal<='0';
					 elsif (("110100000"<=ASCII) and (ASCII<="110101101")) then
						mal<='0';
					 else 
						mal<='1';
					 end if;	
					 
					if mal='1' then
					  ST<=ERROR;
					end if;
					ST<=ESP_CHAR;	

			when ERROR =>
				error1<='1';
				led<='1';
				if	RESET='1' then 
				  ST<=ESP_SYNC;
				  R_aux1<='1';

				end if;
				
         end case;	
      end if;
    end process;
	 
with ST select VALID_DISP <= 
	'1' when VALID_CHAR, -- Asignacion de la salida
	'0' when others;
 
end a_aut_control;

