library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sevenseg is
	port (
			bcd : in  STD_LOGIC_VECTOR(3 downto 0);
			leds: out STD_LOGIC_VECTOR(6 downto 0));
end entity;

architecture arch of sevenseg is
begin

	process(bcd)
	begin

		case bcd is

			when "0000" =>
				leds <= "1000000";

			when "0001" =>
				leds <= "1111001";

			when "0010" =>
				leds <= "0100100";

			when "0011" =>
				leds <= "0110000";

			when "0100" =>
				leds <= "0011001";

			when "0101" =>
				leds <= "0010010";

			when "0110" =>
				leds <= "0000010";

			when "0111" =>
				leds <= "1111000";

			when "1000" =>
				leds <= "0000000";

			when "1001" =>
				leds <= "0010000";

			when "1010" =>
				leds <= "0001000";

			when "1011" =>
				leds <= "0000011";

			when "1100" =>
				leds <= "1000110";

			when "1101" =>
				leds <= "0100001";

			when "1110" =>
				leds <= "0000110";

			when "1111" =>
				leds <= "0001110";

			when others =>
				leds <= "1111111";

		end case;

	end process;

end architecture;