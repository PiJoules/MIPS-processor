library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity main is
	port(
		pc: in std_logic_vector(31 downto 0);
		out_32: out std_logic_vector(31 downto 0);
		ck: in std_logic
	);
end main;

architecture beh of main is
	component instruction_memory
		port (
			read_address: in STD_LOGIC_VECTOR (31 downto 0);
			ck: in STD_LOGIC;
			instruction: out STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	begin

	IM1: instruction_memory port map(pc, ck, out_32);

	process (ck)
		begin
		if ck='1' and ck'event then
			pc <= pc + 4;
		end if;
	end process;
end beh;