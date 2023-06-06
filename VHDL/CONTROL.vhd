--*******************************************
--*   CONTROL UNIT                          *
--*                                         *
--*   ALU operations (2^3 = 8):             *
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
--*   . 000 => R                   *
--*   . 001 => I sum (arith-data transfer)  *
--*   . 010 => logical I (and)              *
--*   . 011 => logical I (or)               *
--*   . 100 => logical I (sl)               *
--*   . 101 => logical I (sr)               *
--*   . 110 => conditional branch           *
--*   . 111 => unconditional jump           *
--*   . others => none                      *
--*******************************************
--hassan
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CONTROL is
port(I1: in std_ulogic_vector(5 downto 0);
     O1, O2, O3, O4, O5, O7, O8, O9: out std_ulogic;   
     O6: out std_ulogic_vector(2 downto 0));
end CONTROL;

architecture CTRL1 of CONTROL is
signal	R1: std_ulogic_vector(10 downto 0) := (others => '0');
signal	R6: std_ulogic_vector(2 downto 0) := (others => '0');
signal	D1: std_ulogic_vector(5 downto 0) := (others => '0');
signal  D4, D7, D9: std_ulogic;
begin
	D1 <= I1;
	
--	R1 <= (RegDst)&(Jump)&(Branch)&(MemRead)&(MemtoReg)&(ALUOp)&(MemWrite)&(ALUSrc)&(RegWrite)
	with D1 select R1 <=
	"10000000001" when "100000", --R
	"00000001011" when "000001", --I sum arith
	"00011001011" when "000010", --I sum load
	"00001001110" when "000011", --I sum store
	"00000010011" when "000100", --I and
	"00000011011" when "000101", --I or
	"00000100011" when "000110", --I sl
	"00000101011" when "000111", --I sr
	"00100110010" when "001000", --branch
	"01000111010" when "010000", --jump
	"00000000000" when others;   --(also 000000 -> NOP)
	
	O1 <= R1(10); --RegDst
	O2 <= R1(9); --Jump
	O3 <= R1(8); --Branch
	O5 <= R1(6); --MemtoReg
	O8 <= R1(1); --ALUSrc
	O6 <= R1(5 downto 3); --ALUOp


	O4 <= R1(7); --MemRead
	O7 <= R1(2); --MemWrite
	O9 <= R1(0); --RegWrite

end CTRL1;