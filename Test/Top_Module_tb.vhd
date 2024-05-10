library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top_Module_tb is
end Top_Module_tb;

architecture behavioral of Top_Module_tb is
    component Top_Module is
        port (
            clk : in std_logic;
            rst : in std_logic;
        );
    end component;

    constant periodCLK : time := 20ns;

begin

    Top_ModuleInst : Top_Module port map
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

        for i in 1 to 10 loop
            clk <= '1';
            wait for periodCLK/2;
            clk <= '0';
            wait for periodCLK/2;
        end loop;

        wait;
    end process;

end architecture;
