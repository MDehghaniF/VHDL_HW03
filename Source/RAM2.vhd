library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use IEEE.numeric_std.all;

entity RAM is
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
		rdEn      : in std_logic;
		do        : out std_logic := '0'
	);
end entity;

architecture behavioral of RAM is

	type ram_array is array (0 to 2 ** LENGTH) of std_logic_vector(WIDTH - 1 downto 0);
	signal ram_data : ram_array := (others => (others => '0'));
	signal temp     : integer   := 0;

begin
	RAMInst : process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				ram_data <= (others => (others => '0'));
				rdRdy    <= '0';
			else
				if wrEn = '1' then
					ram_data(to_integer(unsigned(wrAddress))) <= wrData;
					if temp = 2 then
						do   <= '1';
						temp <= 0;
					else
						temp <= temp + 1;
					end if;
				end if;
				if rdEn = '1' then
					rdRdy <= '1';
				else
					rdRdy <= '0';
				end if;
			end if;
		end if;
	end process; -- RAMInst
	rdData <= ram_data(to_integer(unsigned(rdAddress)));
end architecture;
