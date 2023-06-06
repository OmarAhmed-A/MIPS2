--****************************************************************
--*   PIPELINE REGISTERS: MEMORY - WRITE BACK                    *
--*   (X4 - X6 - X7 - X8 - X9 - X11 - X12 - X13 - X15 REMOVED)   *
--*					                         *
--*   - X10 -> MemtoReg		X	                         *
--*   - X14 -> RegWrite		X	                         *
--****************************************************************
--youssef
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEMWB is
port(I1, I2: in std_ulogic_vector(31 downto 0);
     I3: in std_ulogic_vector(4 downto 0);
     I10, I14: in std_ulogic;
     O1, O2: out std_ulogic_vector(31 downto 0);
     O3: out std_ulogic_vector(4 downto 0);
     O10, O14: out std_ulogic;
     C1, clk: in std_ulogic);
end MEMWB;

architecture MEMWB1 of MEMWB is
signal	D1, D2: std_ulogic_vector(31 downto 0) := (others => '0');
signal  D3: std_ulogic_vector(4 downto 0) := (others => '0');
signal	D10, D14, D17: std_ulogic := '0';
begin
	D17 <= C1;

	pc:process(clk)
	begin
		if(clk = '1' and clk'event and D17 = '1') then
			D1 <= I1;
			D2 <= I2;
			D3 <= I3;
			D10 <= I10;
			D14 <= I14;
		end if;
	end process;
	
	O1 <= D1;
	O2 <= D2;
	O3 <= D3;
	O10 <= D10;
	O14 <= D14;

end MEMWB1;
