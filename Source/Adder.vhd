library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Adder is
	generic (
		bits : integer := 32
	);
	port (
		clk : in std_logic;
		rst : in std_logic;

		Input1  : in std_logic_vector(bits - 1 downto 0) := (others => '0');
		Input2  : in std_logic_vector(bits - 1 downto 0) := (others => '0');
		Output1 : out std_logic_vector(bits - 1 downto 0)
	);
end entity;

architecture behavioral of Adder is

	signal sum : std_logic_vector(bits downto 0);

begin
	AdderInst : process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				Output1 <= (others => '0');
			else
				Output1 <= sum(bits - 1 downto 0);
			end if;
		end if;
	end process; -- AdderInst
	sum <= ('0' & Input1) + ('0' & Input2);
end architecture;
