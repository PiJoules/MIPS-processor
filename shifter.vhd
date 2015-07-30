------------------------------------------------------
-- The Shift Left component
-- 
-- For all your left shifting needs.
-- Right shfting? We don't do that here. Get out.
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shifter is
	generic (n: natural:= 32; k: natural:= 2);
	port (
		x: in std_logic_vector(n-1 downto 0);
		y: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture beh of shifter is
	begin
	y <= std_logic_vector(shift_left(signed(x), k));
end beh;