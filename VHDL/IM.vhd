--**********************
--*                    *
--*                    *
--*	   ---             *
--*	--|(0)|---         *
--*	  |---|            *
--*	--|(1)|---         *
--*   |---|            *
--*	--|(2)|-->         *
--*	  |---|            *
--*         .          *
--          .          *
--*	                   *
--**********************
--Ahmed Osama
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;

ENTITY IM IS
	GENERIC (N : INTEGER);
	PORT (
		I1 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
		O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0));
END IM;

ARCHITECTURE IM1 OF IM IS
	TYPE MEMORY IS ARRAY (0 TO (N - 1)) OF STD_ULOGIC_VECTOR(31 DOWNTO 0); --N*4 byte memory
	SIGNAL M1 : MEMORY := (OTHERS => (OTHERS => '0'));
	SIGNAL D1 : STD_ULOGIC_VECTOR(29 DOWNTO 0) := (OTHERS => '0');
	SIGNAL R1 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
	D1 <= I1(31 DOWNTO 2); --PC/4	

	initmem : PROCESS
		FILE fp : text;
		VARIABLE ln : line;
		VARIABLE instruction : STRING(1 TO 32);
		VARIABLE i, j : INTEGER := 0;
		VARIABLE ch : CHARACTER := '0';
	BEGIN
		file_open(fp, "instruction.txt", READ_MODE);
		WHILE NOT endfile(fp) LOOP
			readline(fp, ln);
			read(ln, instruction);
			FOR j IN 1 TO 32 LOOP
				ch := instruction(j);
				IF (ch = '0') THEN
					M1(i)(32 - j) <= '0';
				ELSE
					M1(i)(32 - j) <= '1';
				END IF;
			END LOOP;
			i := i + 1;
		END LOOP;
		file_close(fp);
		WAIT;
	END PROCESS;

	R1 <= M1(to_integer(unsigned(D1))) WHEN to_integer(unsigned(D1)) < (N - 1) ELSE
		STD_ULOGIC_VECTOR(to_signed(-1, 32)) WHEN to_integer(unsigned(D1)) > (N - 1);

	O1 <= R1;
END IM1;