library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM_tb is
end RAM_tb;

architecture behavioral of RAM_tb is
    component RAM is
        generic (
            WIDTH  : integer := 32;
            LENGTH : integer := 16
        );
        port (
            clk : in std_logic;
            rst : in std_logic;

            wrAddress : in std_logic_vector(LENGTH - 1 downto 0);
            wrData    : in std_logic_vector(WIDTH - 1 downto 0);
            wrEn      : in std_logic;
            rdAddress : in std_logic_vector(LENGTH - 1 downto 0);
            rdData    : out std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
            rdRdy     : out std_logic                            := '0';
            rdEn      : in std_logic
        );
    end component;

    constant periodCLK : time := 20ns;

    signal clk       : std_logic;
    signal rst       : std_logic                         := '1';
    signal wrAddress : std_logic_vector(16 - 1 downto 0) := x"0000";
    signal wrData    : std_logic_vector(32 - 1 downto 0) := x"00000000";
    signal wrEn      : std_logic                         := '0';
    signal rdAddress : std_logic_vector(16 - 1 downto 0) := x"0000";
    signal rdData    : std_logic_vector(32 - 1 downto 0) := x"00000000";
    signal rdRdy     : std_logic                         := '0';
    signal rdEn      : std_logic                         := '0';

begin

    RAMInst : RAM port map
        (clk, rst, wrAddress, wrData, wrEn, rdAddress, rdData, rdRdy, rdEn);

    process
    begin
        clk <= '1';
        wait for periodCLK/2;
        clk <= '0';
        wait for periodCLK/2;

        rst <= '1' after periodCLK/8;

        clk <= '1';
        wait for periodCLK/2;
        clk <= '0';
        wait for periodCLK/2;

        rst       <= '0' after periodCLK/8;
        wrEn      <= '1' after periodCLK/8;
        wrAddress <= x"0001" after periodCLK/8;
        wrData    <= x"01010101" after periodCLK/8;

        clk <= '1';
        wait for periodCLK/2;
        clk <= '0';
        wait for periodCLK/2;

        wrEn      <= '0' after periodCLK/8;
        rdEn      <= '1' after periodCLK/8;
        rdAddress <= x"0001"after periodCLK/8;

        clk <= '1';
        wait for periodCLK/2;
        clk <= '0';
        wait for periodCLK/2;

        for i in 1 to 10 loop
            clk <= '1';
            wait for periodCLK/2;
            clk <= '0';
            wait for periodCLK/2;
        end loop;

        wait;
    end process;

end architecture;
