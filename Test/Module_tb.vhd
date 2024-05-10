library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Module_tb is
end Module_tb;

architecture behavioral of Module_tb is
    component Module is
        port (
            clk : in std_logic;
            rst : in std_logic;

            wrAddress : out std_logic_vector(16 - 1 downto 0) := x"0001";
            wrData    : out std_logic_vector(32 - 1 downto 0) := x"00000000";
            wrEn      : out std_logic                         := '0';
            rdAddress : out std_logic_vector(16 - 1 downto 0) := x"0001";
            rdData    : in std_logic_vector(32 - 1 downto 0);
            rdRdy     : in std_logic;
            rdEn      : out std_logic := '0';

            do : in std_logic
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
    signal do        : std_logic                         := '0';

begin

    ModuleInst : Module port map
        (clk, rst, wrAddress, wrData, wrEn, rdAddress, rdData, rdRdy, rdEn, do);

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

        rst <= '0' after periodCLK/8;

        clk <= '1';
        wait for periodCLK/2;
        clk <= '0';
        wait for periodCLK/2;

        do     <= '1' after periodCLK/8;
        rdData <= x"12341234" after periodCLK/8;
        rdRdy  <= '1' after periodCLK/8;

        clk <= '1';
        wait for periodCLK/2;
        clk <= '0';
        wait for periodCLK/2;

        rdData <= x"43214321" after periodCLK/8;
        rdRdy  <= '1' after periodCLK/8;

        for i in 1 to 10 loop
            clk <= '1';
            wait for periodCLK/2;
            clk <= '0';
            wait for periodCLK/2;
        end loop;

        wait;
    end process;

end architecture;
