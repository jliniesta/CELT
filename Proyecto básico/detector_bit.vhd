----------------------------------------------------------------------------------
-- 
--  Detector de bits
--
--        JT02
--
-- JAVIER LPEZ INIESTA DAZ DEL CAMPO
-- ANDRS CASTILLEJO AMESCUA

--Determinar la presencia de un 0 un 1 mediante el criterio basado en la energía de la señal entrante
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity detector_bit is
    Port ( CLK_1ms : in  STD_LOGIC;    -- reloj
           LIN     : in  STD_LOGIC;    -- Lnea de datos
           BITS   : out  STD_LOGIC);   -- Bits detectados
end detector_bit;

architecture a_detector_bit of detector_bit is

constant UMBRAL0 : STD_LOGIC_VECTOR (7 downto 0) := "00000101"; --  5 umbral para el 0
constant UMBRAL1 : STD_LOGIC_VECTOR (7 downto 0) := "00101101"; -- 45 umbral para el 1

type estados is (E1, E0);
signal estado_actual: estados := E0;
signal estado_siguiente: estados := E0;

signal reg_desp : STD_LOGIC_VECTOR (49 downto 0):=(others=>'0'); --Registro de desplazamiento de 50 bits
signal energia  : STD_LOGIC_VECTOR (7 downto 0) :="00000000";    --Energía, 8 bits iniciados en un primer momento a 0
signal s_bits   : STD_LOGIC:='0';

begin

  process (CLK_1ms)
    begin

      if (CLK_1ms'event and CLK_1ms='1') then -- En cada flanco de subida de CLK_1ms
	 
        -- Calcular la suma de los elementos del registro (energa)
			if (reg_desp(49)='1' and LIN='1') then     --si sale un 1 y entra un 1, la energa se mantiene igual
				energia<= energia;
			elsif (reg_desp(49)='1' and LIN='0') then  -- si sale un 1 y entra un 0, la energa se decrementa en uno
				energia<=energia-'1';
			elsif (reg_desp(49)='0' and LIN='1') then  -- si sale un 0 y entra un 1, la energa aumenta en uno
				energia<=energia + '1';	
			elsif (reg_desp(49)='0' and LIN='0') then  -- si sale un 0 y entra un 0, la energa se mantiene igual
				energia<=energia;						
			end if;
			
			--Tambien se podría hacer:
			--	  energia<= energia + LIN - reg_desp(49);
			
         -- Desplazar los datos del registro capturando la nueva muestra que entra en el registro
			reg_desp(49 downto 1)<=reg_desp(48 downto 0);  --Los 49 bits de la derecha, se desplazan 1 hacia la izquierda
			reg_desp(0)<= LIN; --A la entrada del registro de desplazamiento entra la señal LIN

         -- Ver si la energa supera los umbrales y asignar a s_bits el valor adecuado
			if (energia > UMBRAL1) then  --Si la energía es mayor que 45, s_bits vale 1
				s_bits <= '1';
			elsif (energia < UMBRAL0) then --Si la energía es menor que 5, s_bits vale 0
				s_bits <= '0';
			end if; 
      end if;
    end process;
	 
  BITS<=s_bits;  --Se asigna s_bits a la salida BITS del detector_bit

  -- Asignacin de la salida en funcin del estado (Moore)
  process (estado_actual, energia)
  begin
		case estado_actual is 
			when E0 => --Cuando se encuentra en el estado 0
				if energia <= UMBRAL1 then 
					estado_siguiente <= E0; --Si la energa es menor o igual que el UMBRAL1 (45) se mantiene en el estado 0
				else 
					estado_siguiente <= E1; --Si la energa es mayor que el UMBRAL1 (45) pasa al estado 1
				end if;
			when E1 =>  -- Cuando se encuentra en el estado 1
				if energia >= UMBRAL0 then
					estado_siguiente <= E1;  --Si la energa es menor o igual que el UMBRAL0 (5) se mantiene en el estado 1
				else 
					estado_siguiente <= E0;  --Si la energa es mayor que el UMBRAL0 (5) pasa al estado 0
				end if;
		end case;
	end process;
  
end a_detector_bit;

