--**********************************************************
--*   PIPELINE REGISTERS: INSTRUCTION DECODE - EXECUTION   *
--*							   *
--*   - X7 -> RegDst		X			   *
--*   - X8 -> Jump		XX	                   *
--*   - X9 -> Branch		XX	                   *
--*   - X10 -> MemtoReg		XXX	                   *
--*   - X11 -> ALUSrc		X			   *
--*   - X12 -> MemRead		XX			   *
--*   - X13 -> MemWrite		XX			   *
--*   - X14 -> RegWrite		XXX			   *
--*   - X15 -> ALUOp		X			   *
--**********************************************************
--youssef
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IDEX is
port(I1, I2, I3, I4: in std_ulogic_vector(31 downto 0);
     I5, I6, IA1: in std_ulogic_vector(4 downto 0);
     I7, I8, I9, I10, I11, I12, I13, I14: in std_ulogic;
     I15: in std_ulogic_vector(2 downto 0);
     O1, O2, O3, O4: out std_ulogic_vector(31 downto 0);
     O5, O6, OA1: out std_ulogic_vector(4 downto 0);
     O7, O8, O9, O10, O11, O12, O13, O14: out std_ulogic;
     O15: out std_ulogic_vector(2 downto 0);
     C1, clk: in std_ulogic);
end IDEX;

architecture IDEX1 of IDEX is
signal	D1, D2, D3, D4: std_ulogic_vector(31 downto 0) := (others => '0');
signal	D5, D6, D16: std_ulogic_vector(4 downto 0) := (others => '0');
signal	D7, D8, D9, D10, D11, D12, D13, D14, D17: std_ulogic := '0';
signal	D15: std_ulogic_vector(2 downto 0) := (others => '0');
begin
	D17 <= C1;

	pc:process(clk)
	begin
		if(clk = '1' and clk'event and D17 = '1') then
			D1 <= I1;
			D2 <= I2;
			D3 <= I3;
			D4 <= I4;
			D5 <= I5;
			D6 <= I6;
			D7 <= I7;
			D8 <= I8;
			D9 <= I9;
			D10 <= I10;
			D11 <= I11;
			D12 <= I12;
			D13 <= I13;
			D14 <= I14;
			D15 <= I15;
			D16 <= IA1;
		end if;
	end process;
	
	O1 <= D1;
	O2 <= D2;
	O3 <= D3;
	O4 <= D4;
	O5 <= D5;
	O6 <= D6;
	O7 <= D7;
	O8 <= D8;
	O9 <= D9;
	O10 <= D10;
	O11 <= D11;
	O12 <= D12;
	O13 <= D13;
	O14 <= D14;
	O15 <= D15;
	OA1 <= D16;
end IDEX1;
