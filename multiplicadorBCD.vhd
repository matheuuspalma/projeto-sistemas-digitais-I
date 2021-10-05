library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiplicadorBCD is
port (A,B          : in std_logic_vector (15 downto 0);
		clock : in std_logic;
		C       : out std_logic_vector (31 downto 0));
		
end multiplicadorBCD;

architecture logica of multiplicadorBCD is

	component fullAdderBCD_8algarismos
		port (A,B : in std_logic_vector (31 downto 0);
				C   : out std_logic_vector (31 downto 0));
	end component;
	
				
	component fullAdderBCD_4algarismos
		port (A,B : in std_logic_vector (15 downto 0);
				C   : out std_logic_vector (19 downto 0));
	end component;
	
	
	type estado_type is (calculando, aguardando);

	signal estado : estado_type := calculando;

	signal cont     	: std_logic_vector (15 downto 0) := "0000000000000000";
	signal next_cont	: std_logic_vector (19 downto 0);
	signal A_aux        : std_logic_vector (31 downto 0) := ("0000000000000000" & A);
	signal aux_mult     : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";
	signal resultado    : std_logic_vector (31 downto 0);
	
begin
	soma    	: fullAdderBCD_8algarismos port map (A_aux, aux_mult, resultado);
	soma_cont	: fullAdderBCD_4algarismos port map (cont, "0000000000000001", next_cont);
	
	process (clock, estado, aux_mult, resultado, next_cont, A, B)
		begin
		if rising_edge(clock)  then
			if (estado = calculando and (A = "0000000000000000" or B = "0000000000000000")) then
				C <= "00000000000000000000000000000000";
				estado <= aguardando;
			elsif (estado = calculando and cont = B) then
				C <= aux_mult;
				estado <= aguardando;
			elsif (estado = calculando) then
				aux_mult <= resultado;
				cont <= next_cont (15 downto 0);
				estado <= calculando;
			end if;
		end if;
	end process;
end logica;