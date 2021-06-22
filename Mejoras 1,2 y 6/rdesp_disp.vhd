----------------------------------------------------------------------------------
-- 
-- Registro de desplazamiento para la visualizacion. 
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

entity rdesp_disp is 
  Port ( CLK_1ms : in   STD_LOGIC;                       -- entrada de reloj
         EN      : in   STD_LOGIC;                       -- enable         
         E       : in   STD_LOGIC_VECTOR (7 downto 0);   -- entrada de datos   
			R_aux2  : in STD_LOGIC;						         -- Seal reset aut_control					
         Q0      : out  STD_LOGIC_VECTOR (7 downto 0);   -- salida Q0           
         Q1      : out  STD_LOGIC_VECTOR (7 downto 0);   -- salida Q1           
         Q2      : out  STD_LOGIC_VECTOR (7 downto 0);   -- salida Q2          
         Q3      : out  STD_LOGIC_VECTOR (7 downto 0));  -- salida Q3
end rdesp_disp;

architecture a_rdesp_disp of rdesp_disp is

signal QS0 : STD_LOGIC_VECTOR (7 downto 0); -- seal que almacena el valor de Q0
signal QS1 : STD_LOGIC_VECTOR (7 downto 0); -- seal que almacena el valor de Q1
signal QS2 : STD_LOGIC_VECTOR (7 downto 0); -- seal que almacena el valor de Q2
signal QS3 : STD_LOGIC_VECTOR (7 downto 0); -- seal que almacena el valor de Q3

begin

  process (CLK_1ms, R_aux2)
    begin
	 if R_aux2='1' then --Si se ha detectado un reset (Manual o automtico)
		QS0<="00000000"; --Asignamos ceros a todas las salidas del regitstro de desplazamiento, para apagar los displays
		QS1<="00000000";
		QS2<="00000000";
		QS3<="00000000";

	elsif (EN ='1') then
      if (CLK_1ms'event and CLK_1ms='1') then   -- con cada flanco activo
        QS3<=QS2;		                           -- se desplazan todas las salidas 
        QS2<=QS1;                       
        QS1<=QS0;
        QS0<=E;                                 -- y se copia el valor de la entrada en Q0
      end if;  
	 end if;
  end process;
	 
  Q0<=QS0;                                      -- actualizacion de las salidas
  Q1<=QS1;
  Q2<=QS2;
  Q3<=QS3;
end a_rdesp_disp;