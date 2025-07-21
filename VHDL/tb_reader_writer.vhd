library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_reader_writer is
end entity;

architecture test of tb_reader_writer is

    constant CLK_PERIOD : time := 10 ns;
    constant DATA_WIDTH : integer := 16;

    signal clk     : std_logic := '0';
    signal rst     : std_logic := '1';

    -- Signals to connect reader and writer
    signal tdata   : std_logic_vector(2*DATA_WIDTH-1 downto 0);
    signal tvalid  : std_logic;

begin

    -- Clock generation
    clk_process : process
    begin
        while now < 2 ms loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Reset generation
    rst_process : process
    begin
        rst <= '1';
        wait for 30 ns;
        rst <= '0';
        wait;
    end process;

    -- Instantiate the file_reader
    reader_inst : entity work.file_reader
        generic map (
            FILENAME    => "D:/Git5/input_data.txt",
            DATA_WIDTH  => DATA_WIDTH,
            INTERVAL    => 10
        )
        port map (
            clk     => clk,
            rst     => rst,
            tdata   => tdata,
            tvalid  => tvalid
        );

    -- Instantiate the file_writer
    writer_inst : entity work.file_writer
        generic map (
            FILENAME    => "D:/Git5/output_data.txt",
            DATA_WIDTH  => DATA_WIDTH
        )
        port map (
            clk     => clk,
            rst     => rst,
            tdata   => tdata,
            tvalid  => tvalid
        );

end architecture;
