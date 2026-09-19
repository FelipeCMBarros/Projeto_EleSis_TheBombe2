library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuito is
	port (
    A,B,C : in  STD_LOGIC;
    x     : out STD_LOGIC);
end entity;

architecture arch of circuito is
begin
    -- Forma simplificada do circuito: X = A . B . not(C)
    x <= A and B and (not C);
end architecture;
