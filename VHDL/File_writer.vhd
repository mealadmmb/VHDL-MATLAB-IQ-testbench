library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity file_writer is
    generic (
        FILENAME    : string := "D:/output_data.txt";
        DATA_WIDTH  : integer := 16  -- Width of I and Q each
    );
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        tdata   : in  std_logic_vector(2*DATA_WIDTH-1 downto 0); -- Q (MSB) & I (LSB)
        tvalid  : in  std_logic
    );
end entity;

architecture behavioral of file_writer is

    file out_file : text open write_mode is FILENAME;
    
begin

    process(clk, rst)
        variable outline  : line;
        variable int_i    : integer;
        variable int_q    : integer;
        variable signed_i : signed(DATA_WIDTH-1 downto 0);
        variable signed_q : signed(DATA_WIDTH-1 downto 0);
    begin
        if rst = '1' then
            -- Do nothing on reset (optional: clear file content if needed)
        elsif rising_edge(clk) then
            if tvalid = '1' then
                -- Extract Q and I from tdata
                signed_q := signed(tdata(2*DATA_WIDTH-1 downto DATA_WIDTH));
                signed_i := signed(tdata(DATA_WIDTH-1 downto 0));

                int_q := to_integer(signed_q);
                int_i := to_integer(signed_i);

                -- Write I to file
                write(outline, int_i);
                writeline(out_file, outline);

                -- Write Q to file
                write(outline, int_q);
                writeline(out_file, outline);
            end if;
        end if;
    end process;

end architecture;
