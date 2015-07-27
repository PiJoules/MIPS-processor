library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is 
	port (
		ck: in std_logic;
		in_1, in_2: std_logic_vector(31 downto 0);
		alu_control_fuct: in std_logic_vector(3 downto 0);
		zero: out std_logic;
		alu_result: out std_logic_vector(31 downto 0)
	);
end alu;

architecture beh of alu is
	signal add: std_logic_vector(3 downto 0):= "0010";
	signal subtract: std_logic_vector(3 downto 0):= "0110";
	signal and_op: std_logic_vector(3 downto 0):= "0000";
	signal or_op: std_logic_vector(3 downto 0):= "0001";
	signal set_on_less_than: std_logic_vector(3 downto 0):= "0111";

	begin

	process (ck)
		if ck='1' and ck'event then
			case alu_control_fuct is
				when add =>
					alu_result <= in_1 + in_2;
				when subtract =>
					alu_result <= in_1 - in_2;
				when and_op =>
					alu_result <= in_1 and in_2;
				when or_op =>
					alu_result <= in_1 or in_2;
				when set_on_less_than =>
					
				when others =>
					null;
			end case;
		end if;
	end process;
end beh;
