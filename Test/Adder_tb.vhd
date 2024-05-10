library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder_tb is
end Adder_tb;

architecture behavioral of Adder_tb is
    component Adder is
        port (
            clk : in std_logic;
            rst : in std_logic;

            Input1  : in std_logic_vector(32 - 1 downto 0);
            Input2  : in std_logic_vector(32 - 1 downto 0);
            Output1 : out std_logic_vector(32 - 1 downto 0)
        );
    end component;

    constant periodCLK : time := 20ns;

    signal clk : std_logic;
    signal rst : std_logic;

    signal Input1  : std_logic_vector(32 - 1 downto 0) := x"00000011";
    signal Input2  : std_logic_vector(32 - 1 downto 0) := x"00000000";
    signal Output1 : std_logic_vector(32 - 1 downto 0) := x"000000FF";

begin

    AdderInst : Adder port map
        (clk, rst, Input1, Input2, Output1);

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

        rst    <= '0' after periodCLK/8;
        Input1 <= x"01010101" after periodCLK/8;
        Input2 <= x"10101010" after periodCLK/8;

        for i in 1 to 10 loop
            clk <= '1';
            wait for periodCLK/2;
            clk <= '0';
            wait for periodCLK/2;
        end loop;

        wait;
    end process;

end architecture;
