library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all; --Dont forget to include this library for file operations.

entity instruction_memory is
	port (
        ck: in std_logic;
		read_address: in STD_LOGIC_VECTOR (31 downto 0);
		instruction: out STD_LOGIC_VECTOR (31 downto 0)
	);
end instruction_memory;


architecture behavioral of instruction_memory is	  

    type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_mem: mem_array := (
        "00000000000000000000000000000000", -- initialize data memory
        "00000000000000000000000000000000", -- mem 1
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000", -- mem 10 
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",  
        "00000000000000000000000000000000", -- mem 20
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000", -- mem 30
        "00000000000000000000000000000000"
    );

    begin

    -- Read process
    process 
        file file_pointer : text;
        variable line_content : string(1 to 32);
        variable line_num : line;
        variable i: integer := 0;
        variable j : integer := 0;
        variable char : character:='0'; 
    
        begin
        --Open the file read.txt from the specified location for reading(READ_MODE).
        file_open(file_pointer,"test.txt",READ_MODE);    
        while not endfile(file_pointer) loop --till the end of file is reached continue.
            readline (file_pointer,line_num);  --Read the whole line from the file
            --Read the contents of the line from  the file into a variable.
            READ (line_num,line_content); 
            --For each character in the line convert it to binary value.
            --And then store it in a signal named 'bin_value'.
            for j in 1 to 32 loop        
                char := line_content(j);
                if(char = '0') then
                    data_mem(i)(32-j) <= '0';
                else
                    data_mem(i)(32-j) <= '1';
                end if; 
            end loop;
            i := i + 1;
        end loop;

        file_close(file_pointer);  --after reading all the lines close the file.  
        wait;
    end process;

    process(ck)
        begin
        if ck='1' and ck'event then
            instruction <= data_mem(to_integer(unsigned(read_address(31 downto 2))));
        end if;
    end process;

end behavioral;