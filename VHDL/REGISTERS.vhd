--*****************
--*   REGISTERS   *
--*****************
--omarAnwar
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REG is
port(I1, I2, I3: in std_ulogic_vector(4 downto 0);
     I4: in std_ulogic_vector(31 downto 0);
     C1: in std_ulogic;   
     O1, O2: out std_ulogic_vector(31 downto 0));
end REG;

architecture REG1 of REG is
type REGISTERFILE is array (0 to 31) of std_ulogic_vector(31 downto 0); --32 register of 32 bit
signal M1: REGISTERFILE := (others => (others => '0'));
signal	D1, D2, D3: std_ulogic_vector(4 downto 0) := (others => '0');
signal	D4: std_ulogic_vector(31 downto 0) := (others => '0');
signal	D5: std_ulogic := '0';
signal	R1, R2: std_ulogic_vector(31 downto 0) := (others => '0');
begin

	D1 <= I1; --Read register 1  
	D2 <= I2; --Read register 2
	D3 <= I3; --Write register
	D4 <= I4; --Write data
	D5 <= C1;
	
	R1 <= M1(to_integer(unsigned(D1)));
	R2 <= M1(to_integer(unsigned(D2)));
								    
	M1(to_integer(unsigned(D3))) <= D4 when (D5 = '1' and D4 /= std_ulogic_vector(to_signed(-1, 32)));

	O1 <= R1;
	O2 <= R2;
end REG1;
