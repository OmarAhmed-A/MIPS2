LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--ahmed Osama

ENTITY HDU IS
	PORT (
		I1 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0); -- Input data (instruction)
		I2 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0); -- Input data (register address)
		I3 : IN STD_ULOGIC; -- Input control signal (MemRead)
		O1, O2, O3 : OUT STD_ULOGIC -- Output control signals (MUXctrl, PCEnable, IFIDEnable)
	);
END HDU;

ARCHITECTURE HDU1 OF HDU IS
	SIGNAL D1, D2, D3 : STD_ULOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0'); -- Intermediate signals for data extraction
	SIGNAL D4, R1, R2 : STD_ULOGIC; -- Intermediate signals for control logic

BEGIN
	D1 <= I1(25 DOWNTO 21); -- Extract bits 25 to 21 from I1 as rs (register containing the memory address + constant value)
	D2 <= I1(20 DOWNTO 16); -- Extract bits 20 to 16 from I1 as rt (register containing the address to load data from memory)
	D3 <= I2; -- Assign I2 to D3 as rt (register containing the data from the previous instruction)
	D4 <= I3; -- Assign I3 to D4 as MemRead signal

	-- Control Logic for MUXctrl
	R1 <= '0' WHEN ((D1 /= D3) AND (D2 /= D3)) OR (D4 = '0') ELSE
		'1' WHEN ((D1 = D3) OR (D2 = D3)) AND (D4 = '1');
	-- If rs and rt are not equal to the value in register rt or MemRead is '0', set R1 to '0'. Otherwise, if either rs or rt is equal to the value in register rt and MemRead is '1', set R1 to '1'.

	-- Control Logic for PCEnable
	R2 <= '0' WHEN ((D1 = D3) OR (D2 = D3)) AND (D4 = '1') ELSE
		'1' WHEN ((D1 /= D3) AND (D2 /= D3)) OR (D4 = '0');
	-- If either rs or rt is equal to the value in register rt and MemRead is '1', set R2 to '0'. Otherwise, if rs and rt are not equal to the value in register rt or MemRead is '0', set R2 to '1'.

	O1 <= R1; -- MUXctrl control signal output
	O2 <= R2; -- PCEnable control signal output
	O3 <= R2; -- IFIDEnable control signal output
END HDU1;