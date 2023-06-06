--**********************
--*                    *
--*                    *
--*       ---         *
--*    --|(0)|---     *
--*      |---|        *
--*    --|(1)|---     *
--*      |---|        *
--*    --|(2)|-->     *
--*      |---|        *
--*        .          *
--*        .          *
--*                   *
--**********************
--OmarAhmed

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CacheL2 IS
    GENERIC (N : INTEGER); -- Generic parameter for the size of the cache memory
    PORT (
        I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0); -- Input signals for address and write data
        O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0); -- Output signal for read data
        O2 : OUT STD_ULOGIC; -- Output signal for control flag
        C1, C2 : IN STD_ULOGIC -- Control signals for memory write and read
    );
END CacheL2;

ARCHITECTURE CACHEL21 OF CacheL2 IS
    TYPE MEMORY IS ARRAY(0 TO (N - 1)) OF STD_ULOGIC_VECTOR(31 DOWNTO 0); -- Memory array type for cache
    SIGNAL M1 : MEMORY := (-- Signal for cache memory
    "00000000000000000000000000000000", -- Initial data in the memory
    "00000000000000000000000000000100", -- Example data in the memory
    OTHERS => (OTHERS => '0') -- Remaining elements initialized to '0'
    );
    SIGNAL D1, D2, R1 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0'); -- Signals for internal data
    SIGNAL D3, D4, R2 : STD_ULOGIC := '0'; -- Signals for control flags

BEGIN
    D1 <= TRANSPORT I1 AFTER 201 ns; -- Transport input address after 201 ns
    D2 <= TRANSPORT I2 AFTER 201 ns; -- Transport input write data after 201 ns
    D3 <= TRANSPORT C1 AFTER 201 ns; -- Transport control signal MemWrite after 201 ns
    D4 <= TRANSPORT C2 AFTER 201 ns; -- Transport control signal MemRead after 201 ns

    -- Read operation: Output data is read from cache memory based on address
    -- and control conditions.
    R1 <= M1(to_integer(unsigned(D1))) WHEN (D3 = '0' AND D4 = '1' AND to_integer(unsigned(D1)) < (N - 1));

    -- Write operation: Input data is written to cache memory based on address
    -- and control conditions.
    M1(to_integer(unsigned(D1))) <= D2 WHEN (D3 = '1' AND D4 = '0' AND to_integer(unsigned(D1)) < (N - 1));

    -- Control flag generation: Flag is set to '1' when either a read or write
    -- operation is performed within the address range.
    readypulse : PROCESS (D1, D2, D3, D4)
        VARIABLE FLAG : STD_ULOGIC := '0';
    BEGIN
        FLAG := '0';

        IF (D3 = '0' AND D4 = '1' AND to_integer(unsigned(D1)) < (N - 1)) OR
            (D3 = '1' AND D4 = '0' AND to_integer(unsigned(D1)) < (N - 1)) THEN
            FLAG := '1';
        END IF;

        R2 <= FLAG;
    END PROCESS;

    O1 <= R1; -- Output read data
    O2 <= R2; -- Output control flag

END CACHEL21;