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

	-- dummy vectors
	signal dummy_vector: std_logic_vector(31 downto 0);

	signal instr_address: std_logic_vector(31 downto 0); -- Address of the next instruction
	signal instruction: std_logic_vector(31 downto 0); -- The actual instruction to run
	signal opcode: std_logic_vector(5 downto 0);
	signal rs, rt, rd, write_reg: std_logic_vector(4 downto 0);
	signal reg_dest,jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: std_logic;
	signal alu_op: std_logic_vector(1 downto 0);

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
	component registers
		port (
			ck: in std_logic;
			reg_write: in std_logic;
			read_reg_1, read_reg_2, write_reg: in std_logic_vector(4 downto 0);
			write_data: in std_logic_vector(31 downto 0);
			read_data_1, read_data_2: out std_logic_vector(31 downto 0)
		);
	end component;
	component control
		port (
			ck: in std_logic;
			opcode: in std_logic_vector(5 downto 0);
			reg_dest,jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: out std_logic;
			alu_op: out std_logic_vector(1 downto 0)
		);
	end component;
	component mux
		generic (n: natural:= 1);
		port (
			x,y: in std_logic_vector(n-1 downto 0);
			s: in std_logic;
			z: out std_logic_vector(n-1 downto 0)
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

	rs <= instruction(25 downto 21);
	rt <= instruction(20 downto 16);
	rd <= instruction(15 downto 11);

	Prog_Count: pc port map (en, instr_address); 
	IM: instruction_memory port map (en, instr_address, instruction);
	CONTOL: control port map (en, opcode, reg_dest,jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, alu_op);
	-- The mux going into Register's Write Register port; chooses between rt and rd
	MUX1: mux generic map(5) port map (
		x => rt, 
		y => rd, 
		s => reg_dest,
		z => write_reg
	);
	REG: registers port map (
		en,
		reg_write => reg_write,
		read_reg_1 => rs,
		read_reg_2 => rt,
		write_reg => write_reg, 
		write_data => dummy_vector, 
		read_data_1 => dummy_vector, 
		read_data_2 => dummy_vector
	);

end beh;