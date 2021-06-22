----------------------------------------------------------------------------------
-- 
-- M�dulo de visualizaci�n, descripci�n estructural: cableado
--
--        JT02
--
-- JAVIER L�PEZ INIESTA D�AZ DEL CAMPO
-- ANDR�S CASTILLEJO AMESCUA
------------------------------------------------------ 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity visualizacion is
    
  Port ( E0   : in  STD_LOGIC_VECTOR (7 downto 0);   -- Entrada siguiente car�cter
         EN   : in  STD_LOGIC;                       -- Activaci�n para desplazamiento
         CLK_1ms  : in  STD_LOGIC;                   -- Entrada de reloj de refresco  
			R_aux2  : in STD_LOGIC;								-- Se�al de reset
			error2 : in STD_LOGIC;
         SEG7 : out  STD_LOGIC_VECTOR (0 to 7);      -- Salida para los displays 
         AN   : out  STD_LOGIC_VECTOR (3 downto 0)); -- Activaci�n individual
end visualizacion;


architecture a_visualizacion of visualizacion is

-- COMPONENTES
--------------

component MUX4x8
  Port (   E0 : in  STD_LOGIC_VECTOR (7 downto 0); -- Entrada de datos 0
           E1 : in  STD_LOGIC_VECTOR (7 downto 0); -- Entrada de datos 1
           E2 : in  STD_LOGIC_VECTOR (7 downto 0); -- Entrada de datos 2
           E3 : in  STD_LOGIC_VECTOR (7 downto 0); -- Entrada de datos 3
           S : in  STD_LOGIC_VECTOR (1 downto 0);  -- Se�al de control
           Y : out  STD_LOGIC_VECTOR (7 downto 0)); -- Salida
end component;

component rdesp_disp
  Port ( CLK_1ms : in   STD_LOGIC;                       -- entrada de reloj
         EN      : in   STD_LOGIC;                       -- enable         
         E       : in   STD_LOGIC_VECTOR (7 downto 0);   -- entrada de datos    
			R_aux2   : in  STD_LOGIC;						      -- Se�al reset aut_control	
			error2   : in  STD_LOGIC;
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
    Port ( CODIGO    : in  STD_LOGIC_VECTOR (7 downto 0);   -- c�digo ASCII
           SEGMENTOS : out  STD_LOGIC_VECTOR (0 to 7));     -- Salidas al display
end component;

-- SE�ALES
----------
signal 	q_0, q_1, q_2, q_3, y_mux: STD_LOGIC_VECTOR(7 downto 0);
signal 	s_refresco: STD_LOGIC_VECTOR(1 downto 0);

begin

--INTERCONEXI�N DE M�DULOS
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
								R_aux2=>R_aux2,
								error2=>error2,
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


