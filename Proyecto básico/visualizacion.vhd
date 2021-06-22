----------------------------------------------------------------------------------
-- 
-- Mdulo de visualizacin, descripcin estructural: cableado
--
--        JT02
--
-- JAVIER LPEZ INIESTA DAZ DEL CAMPO
-- ANDRS CASTILLEJO AMESCUA

--Representa un carácter en el display de la derecha, desplazando todos los demás una posición hacia la izquierda
------------------------------------------------------ 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity visualizacion is
    
  Port ( E0   : in  STD_LOGIC_VECTOR (7 downto 0);   -- Entrada siguiente carcter
         EN   : in  STD_LOGIC;                       -- Activacin para desplazamiento
         CLK_1ms  : in  STD_LOGIC;                   -- Entrada de reloj de refresco       
         SEG7 : out  STD_LOGIC_VECTOR (0 to 6);      -- Salida para los displays 
         AN   : out  STD_LOGIC_VECTOR (3 downto 0)); -- Activacin individual
end visualizacion;


architecture a_visualizacion of visualizacion is

-- COMPONENTES
--------------

component MUX4x8
  Port (   E0 : in  STD_LOGIC_VECTOR (7 downto 0); -- Entrada de datos 0
           E1 : in  STD_LOGIC_VECTOR (7 downto 0); -- Entrada de datos 1
           E2 : in  STD_LOGIC_VECTOR (7 downto 0); -- Entrada de datos 2
           E3 : in  STD_LOGIC_VECTOR (7 downto 0); -- Entrada de datos 3
           S : in  STD_LOGIC_VECTOR (1 downto 0);  -- Seal de control
           Y : out  STD_LOGIC_VECTOR (7 downto 0)); -- Salida
end component;

component rdesp_disp
  Port ( CLK_1ms : in   STD_LOGIC;                       -- entrada de reloj
         EN      : in   STD_LOGIC;                       -- enable         
         E       : in   STD_LOGIC_VECTOR (7 downto 0);   -- entrada de datos    
         Q0      : out  STD_LOGIC_VECTOR (7 downto 0);   -- salida Q0           
         Q1      : out  STD_LOGIC_VECTOR (7 downto 0);   -- salida Q1           
         Q2      : out  STD_LOGIC_VECTOR (7 downto 0);   -- salida Q2          
         Q3      : out  STD_LOGIC_VECTOR (7 downto 0));  -- salida Q3
end component;

component refresco 
    Port ( CLK_1ms : in  STD_LOGIC;                  -- reloj de refresco
           S : out  STD_LOGIC_VECTOR (1 downto 0);   -- Control para el mux
           AN : out  STD_LOGIC_VECTOR (3 downto 0)); -- Control displays individuales
end component;

component decodASCIIa7s
    Port ( CODIGO    : in  STD_LOGIC_VECTOR (7 downto 0);   -- cdigo ASCII
           SEGMENTOS : out  STD_LOGIC_VECTOR (0 to 6));     -- Salidas al display
end component;

-- SEÑALES
----------
signal 	q_0, q_1, q_2, q_3, y_mux: STD_LOGIC_VECTOR(7 downto 0);
signal 	s_refresco: STD_LOGIC_VECTOR(1 downto 0);

begin

--INTERCONEXION DE MODULOS
--------------------------

U1: MUX4x8   port map (E3=>q_3,
							  E2=>q_2,
							  E1=>q_1,
							  E0=>q_0,
							  S=>s_refresco,
							  Y=>y_mux);

U2: rdesp_disp port map (EN=>EN,
								CLK_1ms=>CLK_1ms,
								E=>E0,
								Q0=>q_0,
								Q1=>q_1,
								Q2=>q_2,
								Q3=>q_3);
								

U3: refresco port map (CLK_1ms=>CLK_1ms,
							  S=>s_refresco,
							  AN=>AN);

U4: decodASCIIa7s port map (CODIGO=>y_mux,
									 SEGMENTOS=>SEG7);


end a_visualizacion;


