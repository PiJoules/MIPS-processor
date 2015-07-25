library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use STD.textio.all;

entity main is
	port(
		out_32: out std_logic_vector(31 downto 0);
		ck: in std_logic
	);
end main;

architecture beh of main is

	signal instr_address: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
	type state is (loading, ready); -- enum for checking if the instructions have loaded
	signal s: state:= loading;
	signal en: std_logic:= '0';

	component instruction_memory
		port (
			ck: in std_logic;
			read_address: in STD_LOGIC_VECTOR (31 downto 0);
			instruction: out STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	component pc
		port (
			ck: in std_logic;
			next_address: out std_logic_vector(31 downto 0)
		);
	end component;

	begin

	process(ck)
		begin
		case s is
			when loading =>
				s <= ready; -- give 1 cycle to load the instructions into memory
			when ready =>
				en <= ck;
		end case;
	end process;

	IM: instruction_memory port map (en, instr_address, out_32);
	Prog_Count: pc port map (en, instr_address); 

end beh;