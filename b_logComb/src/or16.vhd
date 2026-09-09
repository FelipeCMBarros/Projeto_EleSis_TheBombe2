library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or16 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture arch of or16 is
begin

    gen_or : for i in 0 to 15 generate
        q(i) <= a(i) or b(i);
    end generate gen_or;

end architecture;
