library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity file_reader is
    generic (
        FILENAME    : string := "D:\Git5\File_reader_writer\File_reader_writer.srcs\sim_1\new\data.txt";     -- Path to text file
        DATA_WIDTH  : integer := 23;            -- Width of I and Q
        INTERVAL    : integer := 10              -- Clock cycles between reads
    );
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        tdata   : out std_logic_vector(2*DATA_WIDTH-1 downto 0); -- Q (MSBs) & I (LSBs)
        tvalid  : out std_logic
    );
end entity;

architecture behavioral of file_reader is

    file data_file : text open read_mode is FILENAME;
    signal tdata_reg   : std_logic_vector(2*DATA_WIDTH-1 downto 0) := (others => '0');
    signal tvalid_reg  : std_logic := '0';
    signal clk_counter : integer := 0;

begin

    process(clk, rst)
        variable linebuf   : line;
    variable read_int_i : integer;
    variable read_int_q : integer;
    
    
    begin
        if rst = '1' then
            tdata_reg   <= (others => '0');
            tvalid_reg  <= '0';
            clk_counter <= 0;

        elsif rising_edge(clk) then
            if clk_counter = INTERVAL - 1 then
                clk_counter <= 0;

                if not endfile(data_file) then
                    -- Read real part (I)
                    readline(data_file, linebuf);
                    read(linebuf, read_int_i);

                    if not endfile(data_file) then
                        -- Read imaginary part (Q)
                        readline(data_file, linebuf);
                        read(linebuf, read_int_q);

                        -- Concatenate as Q (MSB) & I (LSB)
                        tdata_reg <= std_logic_vector(to_signed(read_int_q, DATA_WIDTH)) &
                                     std_logic_vector(to_signed(read_int_i, DATA_WIDTH));
                        tvalid_reg <= '1';
                    else
                        tvalid_reg <= '0'; -- Unexpected EOF
                    end if;
                else
                    tvalid_reg <= '0'; -- EOF
                end if;

            else
                clk_counter <= clk_counter + 1;
                tvalid_reg  <= '0'; -- Not a read cycle
            end if;
        end if;
    end process;

    tdata  <= tdata_reg;
    tvalid <= tvalid_reg;

end architecture;
