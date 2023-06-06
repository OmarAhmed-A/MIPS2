LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--OmarAhmed
ENTITY CacheControl IS
    PORT (
        I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
        O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
        O3, O4, O5, O6, O7 : OUT STD_ULOGIC;
        I3, I4, C1, C2 : IN STD_ULOGIC
    );
END CacheControl;

ARCHITECTURE CC1 OF CacheControl IS
    SIGNAL D1, D2, D7, D8 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL D3, D4, D5, D6, D9, D10, D11, D12, D13 : STD_ULOGIC := '0';

BEGIN

    D1 <= I1; -- Transport input data read or address to be read from memory
    D2 <= I2; -- Transport input data to be written to memory (write back)
    D3 <= I3; -- Transport input control signal L1 ready
    D4 <= I4; -- Transport input control signal Hit
    D5 <= C1; -- Transport input control signal MemWrite
    D6 <= C2; -- Transport input control signal MemRead

    control : PROCESS (D1, D2, D3, D4, D5, D6)
        VARIABLE WRITEFLAG : STD_ULOGIC := '0';
    BEGIN
        D7 <= D1; -- Output memory address is the same as the input address
        D8 <= D2; -- Output write data is the same as the input write data
        WRITEFLAG := '0'; -- Initialize WRITEFLAG variable

        IF (D3 = '1' AND D4 = '1' AND D5 = '0' AND D6 = '1') THEN -- Read cache successful
            D10 <= '0'; -- Delayed MemWrite set to 0
            D11 <= '0'; -- Delayed MemRead set to 0
            D12 <= '1'; -- Mux control set to 1
        ELSIF (D3 = '1' AND D4 = '0' AND D5 = '0' AND D6 = '1') THEN -- Read cache unsuccessful, read from memory
            D10 <= '0'; -- Delayed MemWrite set to 0
            D11 <= '1'; -- Delayed MemRead set to 1
            D12 <= '0'; -- Mux control set to 0
        ELSIF (D3 = '1' AND D4 = '1' AND D5 = '1' AND D6 = '0') THEN -- Write successful
            WRITEFLAG := '1'; -- Set WRITEFLAG to 1
        ELSIF (D3 = '1' AND D4 = '0' AND D5 = '1' AND D6 = '0') THEN -- Write unsuccessful (write back)
            D10 <= '1'; -- Delayed MemWrite set to 1
            D11 <= '0'; -- Delayed MemRead set to 0
            WRITEFLAG := '1'; -- Set WRITEFLAG to 1
        END IF;

        D13 <= WRITEFLAG; -- Output write ready signal

    END PROCESS;

    O1 <= D7; -- Output memory address
    O2 <= D8; -- Output write data
    O3 <= D9; -- Delayed hit (UNUSED in the provided code)
    O4 <= D10; -- Delayed MemWrite (ACTIVE ONLY IF USED!!)
    O5 <= D11; -- Delayed MemRead
    O6 <= D12; -- Mux control
    O7 <= D13; -- Write ready

END CC1;