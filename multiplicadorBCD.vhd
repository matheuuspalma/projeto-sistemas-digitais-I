library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiplicadorBCD is
port (A,B          : in std_logic_vector (15 downto 0);
		clock, start : in std_logic;
		saida        : out std_logic_vector (31 downto 0));
		
end multiplicadorBCD;

architecture logica of multiplicadorBCD is
	component fullAdderBCD_8algarismos
		port (A,B : in std_logic_vector (31 downto 0);
				S   : out std_logic_vector (31 downto 0));
	end component;
	
				
	component fullAdderBCD_4algarismos
		port (A,B : in std_logic_vector (15 downto 0);
				C   : out std_logic_vector (19 downto 0));
	end component;
	
	
	type estado_type is (calculando, aguardando);
	signal estado : estado_type := aguardando;
	
	signal contador     : std_logic_vector (15 downto 0);
	signal contador_res : std_logic_vector (19 downto 0);
	signal A8alg        : std_logic_vector (31 downto 0);
	signal aux_mult     : std_logic_vector (31 downto 0);
	signal aux_res      : std_logic_vector (31 downto 0);
	
begin
	aux_soma    : fullAdderBCD_8algarismos port map (aux_mult, A8alg, aux_res);
	aux_contador: fullAdderBCD_4algarismos port map (contador, "0000000000000001", contador_res);
	
	process (clock)
		begin
		if rising_edge (clock) then
			if (start = '0') then
				A8alg    <= "0000000000000000" & A;
				aux_mult <= "00000000000000000000000000000000";
				contador <= "0000000000000000";
				estado <= calculando;
			elsif (estado = calculando and (A = "0000000000000000" or B = "0000000000000000")) then
				saida <= "00000000000000000000000000000000";
				estado <= aguardando;
			elsif (estado = calculando and contador = B) then
				saida <= aux_mult;
				estado <= aguardando;
			elsif (estado = calculando) then
				aux_mult <= aux_res;
				contador <= contador_res (15 downto 0);
			end if;
		end if;
	end process;
end logica;