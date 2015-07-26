------------------------------------------------------
-- ALU Control component
-- 
-- Used for deciding which operation the alu shoud perform.
--
-- add: 0010
-- subtract: 0110
-- and: 0000
-- or: 0001
-- set-on-less-than: 0111
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_control is
	port (
		ck: in std_logic;
		funct: in std_logic_vector(5 downto 0);
		alu_op: in std_logic_vector(1 downto 0);
		alu_control_fuct: out std_logic_vector(3 downto 0)
	);
end alu_control;

architecture beh of alu_control is
	signal add: std_logic_vector(3 downto 0):= "0010";
	signal subtract: std_logic_vector(3 downto 0):= "0110";
	signal and_op: std_logic_vector(3 downto 0):= "0000";
	signal or_op: std_logic_vector(3 downto 0):= "0001";
	signal set_on_less_than: std_logic_vector(3 downto 0):= "0111";

	begin

	process(ck)
		begin
		if ck='1' and ck'event then 
			case alu_op is
				when "00" =>
					alu_control_fuct <= add;
				when "01" =>
					alu_control_fuct <= subtract;
				when "10" =>
					case funct is
						when "100000" =>
							alu_control_fuct <= add;
						when "100010" =>
							alu_control_fuct <= subtract;
						when "100100" =>
							alu_control_fuct <= and_op;
						when "100101" =>
							alu_control_fuct <= or_op;
						when "101010" =>
							alu_control_fuct <= set_on_less_than;
						when others =>
							null;
					end case;
				when others =>
					null;
			end case;
		end if;
	end process;
end beh;