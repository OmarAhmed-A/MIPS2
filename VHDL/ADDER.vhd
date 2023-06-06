--***************************************************
--* 64-bit ADDER (Adder) 							*
--* *
--* Used Convention: 								*
--* In = nth input port 							*
--* Cn = nth control input port 					*
--* On = nth output port 							*
--* Dn = nth data (operand) 						*
--* Rn = nth result 								*
--***************************************************
--hassan
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ADDER IS
	PORT (
		I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
		O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0));
END ADDER;

ARCHITECTURE ADD1 OF ADDER IS
	SIGNAL D1, D2, R1 : signed(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
	D1 <= signed(I1);
	D2 <= signed(I2);
	R1 <= D1 + D2;
	O1 <= STD_ULOGIC_VECTOR(R1);
END ADD1;