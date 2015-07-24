library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
	port(
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

	signal four: std_logic_vector(31 downto 0):= "00000000000000000000000000000100";
	signal pc: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";

	begin

	IM: instruction_memory port map (pc, ck, out_32);

	process (ck)
		begin
		if ck='1' and ck'event then
			pc <= pc + four;
		end if;
	end process;
end beh;