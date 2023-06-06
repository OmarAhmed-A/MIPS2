--*******************************************
--*   ALU CONTROL                           *
--*                                         *
--* --ALU operations-(2^3 = 8)------------- *
--*                                         *
--*   . 000 => sum                          *
--*   . 001 => subtract                     *
--*   . 010 => and                          *
--*   . 011 => or                           *
--*   . 100 => nor                          *
--*   . 101 => logical left shift           *
--*   . 110 => logical right shift          *
--*   . 111 => *2^16                        *
--*                                         *
--* --Instruction code (OP)---------------- *
--*                                         *
--*   . 100000 => R                         *
--*   . 000001 => arithmetic I (sum)        *
--*   . 000010 => data transfer I load      *
--*   . 000011 => data transfer I store     *
--*   . 000100 => logical I (and)           *
--*   . 000101 => logical I (or)            *
--*   . 000110 => logical I (shift left)    *
--*   . 000111 => logical I (shift right)   *
--*   . 001000 => conditional branch J      *
--*   . 010000 => unconditional jump J      *
--*   . others => none                      *
--*                                         *
--* --Instruction code-(ALUOP)------------- *
--*                                         *
--*   . 000 => R                            *
--*   . 001 => I sum (arith-data transfer)  *
--*   . 010 => logical I (and)              *
--*   . 011 => logical I (or)               *
--*   . 100 => logical I (sl)               *
--*   . 101 => logical I (sr)               *
--*   . 110 => conditional branch           *
--*   . 111 => unconditional jump           *
--*   . others => none                      *
--*                                         *
--* --Instruction code-(R type -> funct)--- *
--*                                         *
--*   .Arithmetic                           *
--*   . 000000 => add                       *
--*   . 000001 => subtract                  *
--*                                         *
--*   .Logical                              *
--*   . 000010 => and                       *
--*   . 000011 => or                        *
--*   . 000100 => nor                       *
--*                                         *
--*******************************************
--hassan
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUC is
port(I1: in std_ulogic_vector(2 downto 0);
     I2: in std_ulogic_vector(5 downto 0);
     O1: out std_ulogic_vector(2 downto 0));
end ALUC;

architecture ALUC1 of ALUC is
signal	D1: std_ulogic_vector(2 downto 0) := (others => '0');
signal	D2: std_ulogic_vector(5 downto 0) := (others => '0');
signal	D3: std_ulogic_vector(8 downto 0) := (others => '0');
signal	R1: std_ulogic_vector(2 downto 0) := (others => '0');
begin
	D1 <= I1; --ALUOp
	D2 <= I2; --funct
	
	R1 <= "000" when D1="000" and D2="000000" else	--arithmetic sum R
 	      "001" when D1="000" and D2="000001" else	--arithmetic subtract R
 	      "000" when D1="001" else			--memory sum I
 	      "010" when D1="000" and D2="000010" else	--logical and R      
 	      "011" when D1="000" and D2="000011" else	--logical or R
 	      "100" when D1="000" and D2="000100" else	--logical nor R
	      "010" when D1="010" else 	--logical and I
 	      "011" when D1="011" else 	--logical or I
 	      "101" when D1="100" else 	--logical left shift I
 	      "110" when D1="101" else 	--logical right shift I
	      "001" when D1="110";    	--conditional branch subtract (it is implemented only the branch on equal)

	O1 <= R1;
end ALUC1;
