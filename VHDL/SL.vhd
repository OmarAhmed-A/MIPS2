--**************************************
--*   SHIFT LEFT FROM N bit TO N bit   *
--*                                    *
--*   Shift left of 2 O1 = I1 << 2     *
--**************************************
--omarAnwar
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SL is
generic(N, M: integer);
port(I1: in std_ulogic_vector((N-1) downto 0);
     O1: out std_ulogic_vector((M-1) downto 0));
end SL;

architecture SL1 of SL is
signal	D1: unsigned((N-1) downto 0) := (others => '0');
signal	R1: unsigned((M-1) downto 0) := (others => '0');
begin
	D1 <= unsigned(I1);
	
	R1 <= --D1((M-1) downto 0) when N > M else
	      D1 & to_unsigned(0, M-N) when N < M else
	      D1 when N = M;


	O1 <= std_ulogic_vector(R1);
end SL1;