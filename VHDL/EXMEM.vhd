--**********************************************
--*   PIPELINE REGISTERS: EXECUTION - MEMORY   *
--*   (X4 - X6 - X7 - X11 - X15 REMOVED)       *
--*					       *
--*   - X8 -> Jump		X	       *
--*   - X9 -> Branch		X	       *
--*   - X10 -> MemtoReg		XX	       *
--*   - X12 -> MemRead		X	       *
--*   - X13 -> MemWrite		X	       *
--*   - X14 -> RegWrite		XX	       *
--**********************************************
--hassan
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EXMEM is
port(I1, I2, I3: in std_ulogic_vector(31 downto 0);
     I5: in std_ulogic_vector(4 downto 0);
     I8, I9, I10, I12, I13, I14, I15: in std_ulogic;
     O1, O2, O3: out std_ulogic_vector(31 downto 0);
     O5: out std_ulogic_vector(4 downto 0);
     O8, O9, O10, O12, O13, O14, O15: out std_ulogic;
     C1, clk: in std_ulogic);
end EXMEM;

architecture EXMEM1 of EXMEM is
signal	D1, D2, D3: std_ulogic_vector(31 downto 0) := (others => '0');
signal	D5: std_ulogic_vector(4 downto 0) := (others => '0');
signal	D8, D9, D10, D12, D13, D14, D15, D17: std_ulogic := '0';
begin
	D17 <= C1;

	pc:process(clk)
	begin
		if(clk = '1' and clk'event and D17 = '1') then
			D1 <= I1;
			D2 <= I2;
			D3 <= I3;
			D5 <= I5;
			D8 <= I8;
			D9 <= I9;
			D10 <= I10;
			D12 <= I12;
			D13 <= I13;
			D14 <= I14;
			D15 <= I15;
		end if;
	end process;
	
	O1 <= D1;
	O2 <= D2;
	O3 <= D3;
	O5 <= D5;
	O8 <= D8;
	O9 <= D9;
	O10 <= D10;
	O12 <= D12;
	O13 <= D13;
	O14 <= D14;
	O15 <= D15;

end EXMEM1;
