library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Add16 is
    port(
        a : in  STD_LOGIC_VECTOR(15 downto 0);
        b : in  STD_LOGIC_VECTOR(15 downto 0);
        q : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity;

architecture rtl of Add16 is

    component FullAdder is
        port(
            a, b, c : in  STD_LOGIC;
            soma    : out STD_LOGIC;
            vaium   : out STD_LOGIC
        );
    end component;

    -- Carry entre os FullAdders
    signal carry : STD_LOGIC_VECTOR(16 downto 0);

begin

    -- Não existe carry entrando no primeiro FullAdder
    carry(0) <= '0';

    gen_adders : for i in 0 to 15 generate

        FA : FullAdder
            port map(
                a     => a(i),
                b     => b(i),
                c     => carry(i),
                soma  => q(i),
                vaium => carry(i + 1)
            );

    end generate;

    -- carry(16) eh propositalmente ignorado

end architecture;