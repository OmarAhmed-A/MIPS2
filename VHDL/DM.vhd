library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Ahmed Osama

entity DM is
port(
    I1, I2: in std_ulogic_vector(31 downto 0);   -- Input signals
    O1: out std_ulogic_vector(31 downto 0);       -- Output signal
    O2: out std_ulogic;                           -- Output signal
    C1, C2: in std_ulogic                         -- Control signals
);
end DM;

architecture DM1 of DM is

component CACHEL1 is
port(
    I1, I2: in std_ulogic_vector(31 downto 0);   -- Input signals
    O1, O2: out std_ulogic_vector(31 downto 0);   -- Output signals
    O3, O4: out std_ulogic;                       -- Output signals
    C1, C2: in std_ulogic                         -- Control signals
);
end component;

component CACHEL2 is
generic(N: integer);
port(
    I1, I2: in std_ulogic_vector(31 downto 0);   -- Input signals
    O1: out std_ulogic_vector(31 downto 0);       -- Output signal
    O2: out std_ulogic;                           -- Output signal
    C1, C2: in std_ulogic                         -- Control signals
);
end component;

component CacheControl is
port(
    I1, I2: in std_ulogic_vector(31 downto 0);   -- Input signals
    O1, O2: out std_ulogic_vector(31 downto 0);   -- Output signals
    O3, O4, O5, O6, O7: out std_ulogic;           -- Output signals
    I3, I4, C1, C2: in std_ulogic                 -- Input signals
);
end component;

component CacheFC is
port(
    I1, I2, I3: in std_ulogic_vector(31 downto 0);   -- Input signals
    C1, C2, C3, C4: in std_ulogic;                   -- Control signals
    O1, O2: out std_ulogic_vector(31 downto 0);       -- Output signals
    O3, O4: out std_ulogic                            -- Output signals
);
end component;

signal ADDRESS, WRITE_DATA, ADDRESS1, WRITE_DATA1, D3, D4, D5, D6, D7, R1: std_ulogic_vector(31 downto 0) := (others => '0');
signal MEMWRITE, MEMREAD, MEMWRITE1, MEMREAD1, HIT, L1READY, HIT_D, MEMWRITE_D, MEMREAD_D, L2READY, MUXCTRL, READREADY, WRITEREADY: std_ulogic := '0';
begin
    ADDRESS <= I1;                              -- Address
    WRITE_DATA <= I2;                           -- Write Data
    MEMWRITE <= C1;                             -- MemWrite
    MEMREAD <= C2;                              -- MemRead

    -- Delays introduced by the memories:
    -- CACHEL1 --> 25ns
    -- CACHEL2 --> 250ns

    CFC1: CacheFC port map(ADDRESS, WRITE_DATA, D7, MEMWRITE, MEMREAD, L2READY, HIT, ADDRESS1, WRITE_DATA1, MEMWRITE1, MEMREAD1);
    CACHEL11: CACHEL1 port map(ADDRESS1, WRITE_DATA1, D3, D4, HIT, L1READY, MEMWRITE1, MEMREAD1);
    CC1: CacheControl port map(D3, D4, D5, D6, HIT_D, MEMWRITE_D, MEMREAD_D, MUXCTRL, WRITEREADY, L1READY, HIT, MEMWRITE, MEMREAD);

    -- D5 = D3 = data read or address to read from memory
    -- D6 = D4 = data to write to memory (write back)

    CACHEL21: CACHEL2 generic map(N => 128)
              port map(D5, D6, D7, L2READY, MEMWRITE_D, MEMREAD_D);
    
    finalcontrol: process(L1READY, L2READY, D3, D7, MUXCTRL, MEMREAD, MEMREAD_D)
    begin
        if(MEMREAD = '1') then
            if(L1READY = '1' and MUXCTRL = '1') then
                R1 <= D3;
                READREADY <= '1';
            elsif(MEMREAD_D = '1' and L2READY = '1' and MUXCTRL = '0') then
                R1 <= D7;
                READREADY <= '1';
            else
                READREADY <= '0';
            end if;
        end if;	
    end process;

    O1 <= R1;
    O2 <= '1' when (MEMREAD = '0' and MEMWRITE = '0') else
          READREADY or WRITEREADY; -- PC&REGENABLE
end DM1;
