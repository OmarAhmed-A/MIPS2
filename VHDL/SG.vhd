
--omarAnwar
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SG is
port(CLK: out std_ulogic);
end SG;

architecture SG1 of SG is

signal DCLK: std_ulogic := '0';

begin
	clkGEN:process
	begin
		DCLK <= '0';
		wait for 50 ns;
		DCLK <= '1';
		wait for 50 ns;
	end process;

	CLK <= DCLK;
	
end SG1;