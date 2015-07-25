------------------------------------------------------
-- This is the main script that is run when simulating
-- in modelsim.
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
	port(
		out_32: out std_logic_vector(31 downto 0); -- visually displaying some output
		ck: in std_logic
	);
end main;

architecture beh of main is

	signal instr_address: std_logic_vector(31 downto 0); -- Address of the next instruction
	signal instruction: std_logic_vector(31 downto 0); -- The actual instruction to run

	 -- Enum for checking if the instructions have loaded
	type state is (loading, ready);
	signal s: state:= loading;

	-- The clock for the other components; starts when the state is ready
	signal en: std_logic:= '0';

	-- Load the other components
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
				en <= ck; -- ready to run the program
		end case;
	end process;

	Prog_Count: pc port map (en, instr_address); 
	IM: instruction_memory port map (en, instr_address, instruction);

end beh;