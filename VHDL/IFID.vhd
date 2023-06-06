--******************************************************************
--*   PIPELINE REGISTERS: INSTRUCTION FETCH - INSTRUCTION DECODE   *
--******************************************************************
--youssef
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IFID is
port(I1, I2: in std_ulogic_vector(31 downto 0);   
     O1, O2: out std_ulogic_vector(31 downto 0);
     C1, clk: in std_ulogic);
end IFID;

architecture IFID1 of IFID is
signal	D1, D2: std_ulogic_vector(31 downto 0) := (others => '0');
signal D3: std_ulogic := '0';
begin
	D3 <= C1; --IFIDEnable
	
	pc:process(clk, D3)
	begin
		if(clk = '1' and clk'event and D3 = '1') then
			D1 <= I1;
			D2 <= I2;
		end if;
	end process;
	
	O1 <= D1;
	O2 <= D2;
end IFID1;
