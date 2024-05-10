library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Module is
	port (
		clk : in std_logic;
		rst : in std_logic;

		wrAddress : out std_logic_vector(16 - 1 downto 0) := x"0000";
		wrData    : out std_logic_vector(32 - 1 downto 0) := x"00000000";
		wrEn      : out std_logic                         := '0';
		rdAddress : out std_logic_vector(16 - 1 downto 0) := x"0000";
		rdData    : in std_logic_vector(32 - 1 downto 0);
		rdRdy     : in std_logic;
		rdEn      : out std_logic := '0';

		do : in std_logic
	);
end entity;

architecture behavioral of Module is

	component Adder is
		port (
			clk : in std_logic;
			rst : in std_logic;

			Input1  : in std_logic_vector(32 - 1 downto 0);
			Input2  : in std_logic_vector(32 - 1 downto 0);
			Output1 : out std_logic_vector(32 - 1 downto 0)
		);
	end component;

	signal Input1  : std_logic_vector(32 - 1 downto 0) := x"00000000";
	signal Input2  : std_logic_vector(32 - 1 downto 0) := x"00000000";
	signal Output1 : std_logic_vector(32 - 1 downto 0) := x"00000000";
	signal flag    : std_logic                         := '0';

	type Module_state is (rdIn1, rdIn2, wrOut, wrOut1);
	signal Module_st : Module_state := rdIn1;

begin
	AdderInst : Adder port map
		(clk, rst, Input1, Input2, Output1);

	ModuleInst : process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				wrAddress <= x"0000";
				wrData    <= x"00000000";
				wrEn      <= '0';
				rdAddress <= x"0000";
				rdEn      <= '0';
			elsif flag = '1' then
				case Module_st is
					when rdIn1 =>
						if rdRdy = '1' then
							Input1 <= rdData;
							-- rdEn      <= '0';
							rdAddress <= rdAddress + 1;
							Module_st <= rdIn2;
						end if;
					when rdIn2 =>
						if rdRdy = '1' then
							Input2 <= rdData;
							rdEn   <= '0';
							if rdAddress > 2 ** 5 then
								rdAddress <= (others => '0');
							end if;
						end if;
						Module_st <= wrOut;
					when wrOut =>
						-- rdEn      <= '0';
						Module_st <= wrOut1;
					when wrOut1 =>
						wrData <= Output1;
						wrEn   <= '1';
						if wrAddress > 2 ** 4 then
							wrAddress <= (others => '0');
						else
							wrAddress <= wrAddress + 1;
						end if;
						Module_st <= rdIn1;
						flag      <= '0';
				end case;
			elsif do = '1' then
				flag <= '1';
				rdEn <= '1';
				case Module_st is
					when rdIn1 =>
						if rdRdy = '1' then
							Input1 <= rdData;
							-- rdEn      <= '0';
							rdAddress <= rdAddress + 1;
							Module_st <= rdIn2;
						end if;
					when rdIn2 =>
						if rdRdy = '1' then
							Input2 <= rdData;
							rdEn   <= '0';
							if rdAddress > 2 ** 5 then
								rdAddress <= (others => '0');
							end if;
						end if;
						Module_st <= wrOut;
					when wrOut =>
						-- rdEn      <= '0';
						Module_st <= wrOut1;
					when wrOut1 =>
						wrData <= Output1;
						wrEn   <= '1';
						if wrAddress > 2 ** 4 then
							wrAddress <= (others => '0');
						else
							wrAddress <= wrAddress + 1;
						end if;
						Module_st <= rdIn1;
						flag      <= '0';
				end case;
			end if;
		end if;
	end process; -- ModuleInst
end architecture;
