LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CacheL1 IS
    PORT (
        I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
        O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
        O3, O4 : OUT STD_ULOGIC;
        C1, C2 : IN STD_ULOGIC
    );
END CacheL1;

ARCHITECTURE CACHEL11 OF CacheL1 IS
    TYPE MEMORY IS ARRAY(0 TO 31) OF STD_ULOGIC_VECTOR(59 DOWNTO 0); -- Memory array type for cache
    SIGNAL M1 : MEMORY := (OTHERS => (OTHERS => '0')); -- Signal for cache memory
    SIGNAL D1, D2, R2, R3 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0'); -- Signals for internal data
    SIGNAL D3, D4, HIT, READY : STD_ULOGIC := '0'; -- Signals for control flags

BEGIN
    D1 <= TRANSPORT I1 AFTER 13 ns; -- Transport input address after 13 ns
    D2 <= TRANSPORT I2 AFTER 13 ns; -- Transport input write data after 13 ns
    D3 <= TRANSPORT C1 AFTER 13 ns; -- Transport control signal MemWrite after 13 ns
    D4 <= TRANSPORT C2 AFTER 13 ns; -- Transport control signal MemRead after 13 ns

    -- D1(4 downto 0): 5 bits of pointer (32 possible addresses in the cache) !! offset not present
    -- D1(31 downto 5): 27 bits of tag (instruction)
    -- R1(58 downto 32): 27 bits of tag
    -- R1(59): valid

    Control : PROCESS (D1, D2, D3, D4)
        VARIABLE MEMDATA : STD_ULOGIC_VECTOR(59 DOWNTO 0) := (OTHERS => '0');
        VARIABLE VALIDFLAG, TAGFLAG, HITFLAG, READYFLAG : STD_ULOGIC := '0';
    BEGIN
        IF to_integer(unsigned(D1(4 DOWNTO 0))) < 32 THEN
            MEMDATA := M1(to_integer(unsigned(D1(4 DOWNTO 0)))); -- Read the data from cache memory
            VALIDFLAG := MEMDATA(59); -- Get the valid flag from the cache entry
        END IF;

        IF D1(31 DOWNTO 5) = MEMDATA(58 DOWNTO 32) THEN
            TAGFLAG := '1'; -- Compare the tag with the cache entry's tag
        ELSE
            TAGFLAG := '0';
        END IF;

        IF D3 = '0' AND D4 = '0' AND MEMDATA = "000000000000000000000000000000000000000000000000000000000000" THEN
            HITFLAG := '1'; -- Check if it's a hit based on control signals and data
        ELSE
            HITFLAG := VALIDFLAG AND TAGFLAG;
        END IF;

        READYFLAG := '0';

        IF D3 = '0' AND D4 = '1' THEN -- Read
            IF HITFLAG = '1' THEN -- Take the data from the cache
                R2 <= MEMDATA(31 DOWNTO 0); -- Set the output read data
                READYFLAG := '1';
            ELSE -- Output the address of the data to be fetched from memory
                R2 <= D1; -- Set the output address to be read from memory
                READYFLAG := '1';
            END IF;
        ELSIF D3 = '1' AND D4 = '0' THEN -- Write
            IF VALIDFLAG = '0' THEN -- Write the data to the cache (no hit = '0' as the previous data is invalid)
                M1(to_integer(unsigned(D1(4 DOWNTO 0)))) <= '1' & D1(31 DOWNTO 5) & D2; -- Update cache with new data
                HITFLAG := '1';
                READYFLAG := '1';
            ELSIF VALIDFLAG = '1' THEN
                IF HITFLAG = '1' THEN -- Update the data
                    M1(to_integer(unsigned(D1(4 DOWNTO 0)))) <= '1' & D1(31 DOWNTO 5) & D2; -- Update cache with new data
                    READYFLAG := '1';
                ELSE -- Tags don't match -> write back
                    R3 <= MEMDATA(31 DOWNTO 0); -- Set the data to be written back to memory
                    R2 <= MEMDATA(58 DOWNTO 32) & D1(4 DOWNTO 0); -- Set the address to write the write back data
                    M1(to_integer(unsigned(D1(4 DOWNTO 0)))) <= '1' & D1(31 DOWNTO 5) & D2; -- Update cache with new data
                    READYFLAG := '1';
                END IF;
            END IF;
        END IF;

        HIT <= HITFLAG; -- Set the output hit flag
        READY <= READYFLAG; -- Set the output ready flag
    END PROCESS;

    O1 <= R2; -- Output read data or address to be read from memory or address to write the write back
    O2 <= R3; -- Output data to be written to memory (write back)
    O3 <= HIT; -- Output hit flag
    O4 <= READY; -- Output ready flag

END CACHEL11;