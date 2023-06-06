--*******************
--*   SIGN EXTEND   *
--*******************
--omarAnwar
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE is
port(I1: in std_ulogic_vector(15 downto 0);   
     O1: out std_ulogic_vector(31 downto 0));
end SE;

architecture SE1 of SE is
signal	D1: signed(31 downto 0) := (others => '0');
begin  
	D1 <= resize(signed(I1), 32);
	O1 <= std_ulogic_vector(D1);
end SE1;
