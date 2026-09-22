-- Elementos de Sistemas
-- FlipFlopT.vhd

library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopT is
	port(
		clock:  in std_logic;
		t:      in std_logic;
		q:      out std_logic:= '0';
		notq:   out std_logic:= '1'
	);
end entity;

architecture arch of FlipFlopT is
    signal q_internal : std_logic := '0';
begin

    q    <= q_internal;
    notq <= not q_internal;

    process(clock)
    begin
        if rising_edge(clock) then
            if t = '1' then
                q_internal <= not q_internal;
            end if;
        end if;
    end process;

end architecture;