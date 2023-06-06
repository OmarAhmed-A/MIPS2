--***************************************
--*   ALU                               *
--*                                     *
--*   ALU operations (2^3 = 8):         *
--*   . 000 => sum                      *
--*   . 001 => subtract                 *
--*   . 010 => and                      *
--*   . 011 => or                       *
--*   . 100 => nor                      *
--*   . 101 => logical left shift       *
--*   . 110 => logical right shift      *
--*   . 111 => *2^16                    *
--*                                     *
--*   Inputs note:                      *
--*   .I1 is the input from registers   *
--*   .I2 is the input from mux         *
--*                                     *
--*   FlagZ note:                       *
--*   .O2 = 1 if inputs are equal       *
--*   .O2 = 0 if inputs are not equal   *
--*                                     *
--*   Brnach instruction note:          *
--*   if R1 = D1-D2 > 0 => D1 > D2      *
--*   if R1 = D1-D2 < 0 => D1 < D2      *
--***************************************
--hassan
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
port(I1, I2: in std_ulogic_vector(31 downto 0);
     C1: in std_ulogic_vector(2 downto 0);
     O1: out std_ulogic_vector(31 downto 0);
     O2: out std_ulogic);
end ALU;

architecture ALU1 of ALU is
signal	D1, D2: signed(31 downto 0) := (others => '0');
signal	D3: std_ulogic_vector(2 downto 0) := (others => '0');
signal	R1: signed(31 downto 0) := (others => '0');
signal	FlagZ: std_ulogic:= '0';
begin
	D1 <= signed(I1);
	D2 <= signed(I2);
	D3 <= C1;

	with D3 select R1 <= D1 + D2 when "000",
			     D1 - D2 when "001",
			     D1 And D2 when "010",
			     D1 Or D2 when "011",
			     D1 Nor D2 when "100",
			     D1 sll to_integer(D2) when "101",
			     D1 srl to_integer(D2) when "110",
			     D2 sll 16 when "111",
			     to_signed(-1, 32) when others;

	FlagZ <= '1' when R1 = to_signed(0, 32) else
		 '0' when R1 /= to_signed(0, 32);
	
	O1 <= std_ulogic_vector(R1);
	O2 <= FlagZ;
end ALU1;
