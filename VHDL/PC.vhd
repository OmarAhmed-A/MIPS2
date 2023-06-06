--***********************
--*   PROGRAM COUNTER   *
--***********************
--omarAnwar
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
port(I1: in std_ulogic_vector(31 downto 0);
     O1: out std_ulogic_vector(31 downto 0);
     C1, clk: in std_ulogic);
end PC;

architecture PC1 of PC is
signal	D1: std_ulogic_vector(31 downto 0) := (others => '0');
signal D3: std_ulogic := '0';
begin
	D3 <= C1; --PCEnable
	
	pc:process(clk)
	begin
		if(clk = '1' and clk'event and D3 = '1') then
			D1 <= I1;
		end if;
	end process;

	O1 <= D1;
end PC1;