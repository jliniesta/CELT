----------------------------------------------------------------------------------
--
-- Módulo principal, descripción estructural: cableado.
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


entity main is
    Port ( CLK : in  STD_LOGIC;                      -- Entrada del reloj principal de 50 MHz
           LIN : in  STD_LOGIC;                      -- Entrada de datos del circuito analógico
           SEG7 : out  STD_LOGIC_VECTOR (0 to 6);    -- Salidas para los segmentos del display
           AN : out  STD_LOGIC_VECTOR (3 downto 0)); -- Salidas de activación de los displays 
end main;

architecture a_main of main is

-- COMPONENTES

component div_reloj 
    Port ( CLK : in  STD_LOGIC;           -- Entrada reloj de la FPGA 50 MHz
           CLK_1ms : out  STD_LOGIC);     -- Salida reloj a 1 KHz
end component;

component detector_bit
    Port ( CLK_1ms : in  STD_LOGIC;    -- reloj
           LIN     : in  STD_LOGIC;    -- Línea de datos
           BITS   : out  STD_LOGIC);   -- Bits detectados
end component;

component aut_captura
    Port ( CLK_1ms : in  STD_LOGIC;  -- Reloj del sistema
           BITS : in  STD_LOGIC;     -- Bits de entrada
           CAP : out  STD_LOGIC);    -- Señal para el registro de captura
end component;

component reg_desp_9b
    Port ( CLK_1ms : in  STD_LOGIC;  -- Reloj del sistema
           DAT : in  STD_LOGIC;      -- Entrada de datos
           EN : in  STD_LOGIC;       -- Entrada de ENABLE     
           Q : out  STD_LOGIC_VECTOR (8 downto 0)); --Salida paralelo
end component;

component aut_control
    Port ( CLK_1ms : in  STD_LOGIC;                     -- Reloj del sistema
           ASCII : in  STD_LOGIC_VECTOR (8 downto 0);   -- Datos de entrada del registro
           VALID_DISP : out  STD_LOGIC);                -- Salida para validar el display
end component;

component visualizacion
  Port ( E0   : in  STD_LOGIC_VECTOR (7 downto 0);   -- Entrada siguiente carácter
         EN   : in  STD_LOGIC;                       -- Activación para desplazamiento
         CLK_1ms  : in  STD_LOGIC;                   -- Entrada de reloj de refresco       
         SEG7 : out  STD_LOGIC_VECTOR (0 to 6);      -- Salida para los displays 
         AN   : out  STD_LOGIC_VECTOR (3 downto 0)); -- Activación individual
end component;

-- SEÑALES
signal s_clk_1ms, s_bits, s_cap, s_valid_disp : STD_LOGIC;
signal s_q: STD_LOGIC_VECTOR(8 downto 0);

begin

-- INTERCONEXIÓN DE MÓDULOS

U1 : div_reloj     port map  (CLK=>CLK,
										CLK_1ms=>s_clk_1ms);
				
U2: detector_bit   port map (LIN=>LIN,
									  CLK_1ms=>s_clk_1ms,
									  BITS=>s_bits);
									  
U3: aut_captura    port map (BITS=>s_bits,
								     CLK_1ms=>s_clk_1ms,
								     CAP=>s_cap);

U4: reg_desp_9b port map (EN=>s_cap,
								  CLK_1ms=>s_clk_1ms,
								  DAT=>s_bits,
								  Q=>s_q);

U5: aut_control port map (ASCII=>s_q,
								  CLK_1ms=>s_clk_1ms,
								  VALID_DISP=>s_valid_disp);

U6: visualizacion port map (EN=>s_valid_disp,
								CLK_1ms=>s_clk_1ms,
								E0=>s_q(7 downto 0),
								SEG7=>SEG7,
								AN=>AN);
						
end a_main;

