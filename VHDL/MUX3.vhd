--***********************************
--*   MULTIPLEXER                   *
--*                                 *
--*   When C1 = 00 I1 is selected   *
--*   When C1 = 01 I2 is selected   *
--*   When C1 = 10 I3 is selected   *
--***********************************
--omarAnwar
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX3 is
generic(N: integer);
port(I1: in std_ulogic_vector((N-1) downto 0);
     I2: in std_ulogic_vector((N-1) downto 0);
     I3: in std_ulogic_vector((N-1) downto 0);
     C1: in std_ulogic_vector(1 downto 0);  
     O1: out std_ulogic_vector((N-1) downto 0));
end MUX3;

architecture MUX1 of MUX3 is
signal	D1: std_ulogic_vector((N-1) downto 0) := (others => '0');
signal	D2: std_ulogic_vector((N-1) downto 0) := (others => '0');
signal	D3: std_ulogic_vector((N-1) downto 0) := (others => '0');
signal	D4: std_ulogic_vector(1 downto 0) := (others => '0');
signal	R1: std_ulogic_vector((N-1) downto 0) := (others => '0');
begin
	D1 <= I1;
	D2 <= I2;
	D3 <= I3;
	D4 <= C1;
	R1 <= D1 when D4 = "00" else
	      D2 when D4 = "01" else
	      D3 when D4 = "10";
	O1 <= R1;
end MUX1;
