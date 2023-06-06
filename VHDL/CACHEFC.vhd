LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--OmarAhmed
ENTITY CacheFC IS
    PORT (
        I1, I2, I3 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
        C1, C2, C3, C4 : IN STD_ULOGIC;
        O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
        O3, O4 : OUT STD_ULOGIC
    );
END CacheFC;

ARCHITECTURE CFC1 OF CacheFC IS
    SIGNAL D1, D2, D3, D8, D9 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL D4, D5, D6, D7, D10, D11 : STD_ULOGIC := '0';

BEGIN
    D1 <= I1; -- Transport input address
    D2 <= I2; -- Transport input write data
    D3 <= I3; -- Transport input data (read from memory to write in cache in case of miss)
    D4 <= C1; -- Transport control signal MemWrite
    D5 <= C2; -- Transport control signal MemRead
    D6 <= C3; -- Transport control signal L2 ready
    D7 <= C4; -- Transport control signal Hit

    feedbackcontrol : PROCESS (D1, D2, D3, D4, D5, D6, D7)
    BEGIN
        D8 <= D1; -- Output address is the same as the input address

        IF (D4 = '0' AND D5 = '1' AND D6 = '1' AND D7 = '0') THEN
            D9 <= D3; -- In case of a cache miss, write the data from memory into the cache
            D10 <= '1'; -- Set MemWrite control signal to 1
            D11 <= '0'; -- Set MemRead control signal to 0
        ELSE
            D9 <= D2; -- Otherwise, write the input write data into the cache
            D10 <= D4; -- Set MemWrite control signal to the input value
            D11 <= D5; -- Set MemRead control signal to the input value
        END IF;
    END PROCESS;

    O1 <= D8; -- Output address
    O2 <= D9; -- Output write data
    O3 <= D10; -- Output MemWrite control signal
    O4 <= D11; -- Output MemRead control signal

END CFC1;