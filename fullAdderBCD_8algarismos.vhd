library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fullAdderBCD_8algarismos is
port (A,B : in std_logic_vector (31 downto 0);
		C   : out std_logic_vector (31 downto 0));
		
end fullAdderBCD_8algarismos;

architecture arc of fullAdderBCD_8algarismos is

	type arraySoma is array (7 downto 0) of std_logic_vector (3 downto 0);
	
	signal arrA : arraySoma := (A (31 downto 28), A (27 downto 24), A (23 downto 20), A (19 downto 16), A (15 downto 12), A (11 downto 8), A (7 downto 4), A (3 downto 0));
	signal arrB : arraySoma := (B (31 downto 28), B (27 downto 24), B (23 downto 20), B (19 downto 16), B (15 downto 12), B (11 downto 8), B (7 downto 4), B (3 downto 0));
	signal arrS : arraySoma;
	
	signal c_aux1, c_aux2, c_aux3, c_aux4, c_aux5, c_aux6, c_aux7, c_aux8 : std_logic;
	
	component fullAdderBCD
		port (A,B   : in std_logic_vector (3 downto 0);
				C     : out std_logic_vector (3 downto 0);
				carryIn  : in std_logic;
				carryOUT : out std_logic);
				
	end component;
	
	begin
	S0 : fullAdderBCD port map (arrA (0), arrB (0), arrs (0), '0', c_aux1);
	S1 : fullAdderBCD port map (arrA (1), arrB (1), arrs (1), c_aux1, c_aux2);
	S2 : fullAdderBCD port map (arrA (2), arrB (2), arrs (2), c_aux2, c_aux3);
	S3 : fullAdderBCD port map (arrA (3), arrB (3), arrs (3), c_aux3, c_aux4);
	S4 : fullAdderBCD port map (arrA (4), arrB (4), arrs (4), c_aux4, c_aux5);
	S5 : fullAdderBCD port map (arrA (5), arrB (5), arrs (5), c_aux5, c_aux6);
	S6 : fullAdderBCD port map (arrA (6), arrB (6), arrs (6), c_aux6, c_aux7);
	S7 : fullAdderBCD port map (arrA (7), arrB (7), arrs (7), c_aux7, c_aux8);
	
	C <= arrs (7) & arrs (6) & arrs (5) & arrs (4) & arrs (3) & arrs (2) & arrs (1) & arrs (0);
	
end arc;