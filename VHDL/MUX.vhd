--**********************************
--*   MULTIPLEXER                  *
--*                                *
--*   When C1 = 0 I1 is selected   *
--*   When C1 = 1 I2 is selected   *
--**********************************
--omarAnwar
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX is
generic(N: integer);
port(I1: in std_ulogic_vector((N-1) downto 0);
     I2: in std_ulogic_vector((N-1) downto 0);
     C1: in std_ulogic;  
     O1: out std_ulogic_vector((N-1) downto 0));
end MUX;

architecture MUX1 of MUX is
signal	D1: std_ulogic_vector((N-1) downto 0) := (others => '0');
signal	D2: std_ulogic_vector((N-1) downto 0) := (others => '0');
signal	D3: std_ulogic := '0';
signal	R1: std_ulogic_vector((N-1) downto 0) := (others => '0');
begin
	D1 <= I1;
	D2 <= I2;
	D3 <= C1;
	R1 <= D1 when D3 = '0' else
	      D2 when D3 /= '0';
	O1 <= R1;
end MUX1;
