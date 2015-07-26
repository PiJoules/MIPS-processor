------------------------------------------------------
-- Control component
--
-- Decides a bunch of things
-- - reg_dest: should use rd as detsination register
-- - jump: should jump to address
-- - branch: should branch off current address
-- - mem_read: should read from data memory
-- - mem_to_reg: should write value from data memory to a register
-- - mem_write: should write to data memory
-- - alu_src: should use immediate as second parameter of alu
-- - reg_write: should write to a register
-- - alu_op: command to use in alu control
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control is
	port (
		ck: in std_logic;
		opcode: in std_logic_vector(5 downto 0);
		reg_dest,jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: out std_logic;
		alu_op: out std_logic_vector(1 downto 0)
	);
end control;

architecture beh of control is
	begin

	process(ck)
		begin
		if ck='1' and ck'event then
			case opcode is
				when "000000" => -- R type
					reg_dest <= '1';
					jump <= '0';
					branch <= '0';
					mem_read <= '0';
					mem_to_reg <= '0';
					mem_write <= '0';
					alu_src <= '0';
					reg_write <= '1';
					alu_op <= "10";
				when others =>
					null;
			end case;
		end if;
	end process;
end beh;