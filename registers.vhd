------------------------------------------------------
-- Register Memory Block
-- 
-- Contains all the registers.
-- 
-- Memory is kept in rows of 32 bits to represent 32-bit
-- registers.
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registers is 
	port (
        ck: in std_logic;
		reg_write: in std_logic;
		read_reg_1, read_reg_2, write_reg: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(31 downto 0);
		read_data_1, read_data_2: out std_logic_vector(31 downto 0)
	);
end registers;

architecture beh of registers is

    -- 128 byte register memory (32 rows * 4 bytes/row)
    type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal reg_mem: mem_array := (
        "00000000000000000000000000000000", -- $zero
        "00000000000000000000000000000001", -- mem 1
        "00000000000000000000000000000010",
        "00000000000000000000000000000011",
        "00000000000000000000000000000100",
        "00000000000000000000000000000101",
        "00000000000000000000000000000110",
        "00000000000000000000000000000111",
        "00000000000000000000000000001000", -- test add
        "00000000000000000000000000001001", -- test add
        "00000000000000000000000000001010", -- mem 10 
        "00000000000000000000000000001011", 
        "00000000000000000000000000001100",
        "00000000000000000000000000001101",
        "00000000000000000000000000001110",
        "00000000000000000000000000001111",
        "00000000000000000000000000010000",
        "00000000000000000000000000010001",
        "00000000000000000000000000010010",
        "00000000000000000000000000010011",  
        "00000000000000000000000000010100", -- mem 20
        "00000000000000000000000000010101",
        "00000000000000000000000000010110",
        "00000000000000000000000000010111",
        "00000000000000000000000000011000", 
        "00000000000000000000000000011001",
        "00000000000000000000000000011010",
        "00000000000000000000000000011011",
        "00000000000000000000000000011100",
        "00000000000000000000000000011101", 
        "00000000000000000000000000011110", -- mem 30
        "00000000000000000000000000011111"
    );

	begin

    read_data_1 <= reg_mem(to_integer(unsigned(read_reg_1)));
    read_data_2 <= reg_mem(to_integer(unsigned(read_reg_2)));

    process(ck)
        begin
        if ck='0' and ck'event and reg_write='1' then
            -- write to reg. mem. when the reg_write flag is set and on a falling clock
            reg_mem(to_integer(unsigned(write_reg))) <= write_data;
        end if;
    end process;

end beh;