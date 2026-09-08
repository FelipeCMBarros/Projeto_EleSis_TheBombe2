library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuito is
	port (
        A,B,C : in  STD_LOGIC;
        x     : out STD_LOGIC);
end entity;

architecture arch of circuito is
    signal outAnd: STD_LOGIC;
    signal outNor: STD_LOGIC;
begin

    -- Primeira porta AND
    outAnd <= B and C;

    -- Porta NOR recebe NOT A e a saída da AND
    outNor <= not ((not A) or outAnd);

    -- Porta AND final
    x <= outNor and A and B;

end architecture;