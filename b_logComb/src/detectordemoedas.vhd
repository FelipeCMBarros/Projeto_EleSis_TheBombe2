library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detectordemoedas is
    Port (
        q : in STD_LOGIC;
        d : in STD_LOGIC;
        n : in STD_LOGIC;
        
        cents : out STD_LOGIC_VECTOR(4 downto 0)
    );
end detectordemoedas;

architecture Behavioral of detectordemoedas is

    signal moedas : STD_LOGIC_VECTOR(2 downto 0);

begin

    moedas <= q & d & n;

    process(moedas)
    begin
        case moedas is
            when "000"  => cents <= "00000";
            when "001"  => cents <= "00101";
            when "010"  => cents <= "01010";
            when "100"  => cents <= "11001";
            when others => cents <= "00000";
        end case;
    end process;

end Behavioral;