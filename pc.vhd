------------------------------------------------------
-- Program Counter component
--
-- Points to address of next instruction to run and returns
-- that address in next_address.
------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
	port(
		ck: in std_logic;
		next_address: out std_logic_vector(31 downto 0)
	);
end pc;

architecture beh of pc is

	signal four: std_logic_vector(31 downto 0):= "00000000000000000000000000000100";
	signal address: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";

	begin

	process(ck)
		begin
		if ck='1' and ck'event then
			address <= address + four; -- could not think of a way to do something like address+"...0100"
		end if;
	end process;

	next_address <= address;

end beh;
