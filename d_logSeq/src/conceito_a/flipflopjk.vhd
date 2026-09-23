-- Elementos de Sistemas
-- FlipFlopJK.vhd

library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopJK is
    port(
        clock: in  std_logic;
        J:     in  std_logic;
        K:     in  std_logic;
        q:     out std_logic := '0';
        notq:  out std_logic := '1'
    );
end entity;

architecture arch of FlipFlopJK is

    signal q_state : std_logic := '0';

begin

    process(clock)

    begin
        if rising_edge(clock) then
            if (J = '0' and K = '1') then
                q_state <= '0';  

            elsif (J = '1' and K = '0') then
                q_state <= '1';

            elsif (J = '1' and K = '1') then
                q_state <= not q_state;      

            end if;
        end if;
    end process;

    q    <= q_state;
    notq <= not q_state;

end architecture;