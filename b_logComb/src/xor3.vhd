library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor3 is
    port(
        a : in STD_LOGIC;
        b : in STD_LOGIC;
        c : in STD_LOGIC;
        q : out STD_LOGIC
    );
end entity;

architecture arch of xor3 is

    component mux8way
        port(
            a : in STD_LOGIC;
            b : in STD_LOGIC;
            c : in STD_LOGIC;
            d : in STD_LOGIC;
            e : in STD_LOGIC;
            f : in STD_LOGIC;
            g : in STD_LOGIC;
            h : in STD_LOGIC;
            sel : in STD_LOGIC_VECTOR(2 downto 0);
            q : out STD_LOGIC
        );
    end component;

begin

    mux: mux8way
        port map(
            a => '0', -- 000
            b => '1', -- 001
            c => '1', -- 010
            d => '0', -- 011
            e => '1', -- 100
            f => '0', -- 101
            g => '0', -- 110
            h => '1', -- 111
            sel => a & b & c,
            q => q
        );

end architecture;