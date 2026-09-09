--
-- Elementos de Sistemas - Aula 5 - Logica Combinacional
-- Rafael . Corsi @ insper . edu . br
--
-- Arquivo exemplo para acionar os LEDs e ler os bottoes
-- da placa DE0-CV utilizada no curso de elementos de
-- sistemas do 3s da eng. da computacao

----------------------------
-- Bibliotecas ieee       --
----------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

----------------------------
-- Entrada e saidas do bloco
----------------------------
entity TopLevel is
	port(
		CLOCK_50 : in  std_logic;
		SW       : in  std_logic_vector(9 downto 0);
		KEY      : in  std_logic_vector(1 downto 0);
		LEDR     : out std_logic_vector(9 downto 0);
		HEX0     : out std_logic_vector(6 downto 0);
		HEX1     : out std_logic_vector(6 downto 0);
		HEX2     : out std_logic_vector(6 downto 0);
		HEX3     : out std_logic_vector(6 downto 0)
	);
end entity;

----------------------------
-- Implementacao do bloco --
----------------------------
architecture rtl of TopLevel is

component conceitoa is
	port(
		CLOCK_50 : in  std_logic;
		SW       : in  std_logic_vector(9 downto 0);
        HEX0     : out std_logic_vector(6 downto 0); -- 7seg0
        HEX1     : out std_logic_vector(6 downto 0); -- 7seg0
        HEX2     : out std_logic_vector(6 downto 0); -- 7seg0
		  HEX3     : out std_logic_vector(6 downto 0); -- 7seg0
		LEDR     : out std_logic_vector(9 downto 0)
	);
end component;
--------------
-- signals
--------------
constant ZERO : std_logic_vector(6 downto 0) := "1000000";
constant ONE : std_logic_vector(6 downto 0) := "1111001";
constant TWO : std_logic_vector(6 downto 0) := "0100100";
constant THREE : std_logic_vector(6 downto 0) :="0110000";
constant FOUR : std_logic_vector(6 downto 0) := "0011001";
constant FIVE : std_logic_vector(6 downto 0) := "0010010";
constant SIX : std_logic_vector(6 downto 0) := "0000010";
constant SEVEN : std_logic_vector(6 downto 0) := "1111000";
constant EIGHT : std_logic_vector(6 downto 0) := "0000000";
constant NINE : std_logic_vector(6 downto 0) := "0010000";
constant A : std_logic_vector(6 downto 0) := "0001000";
constant B : std_logic_vector(6 downto 0) := "0000011";
constant C : std_logic_vector(6 downto 0) := "1000110";
constant D : std_logic_vector(6 downto 0) := "0100001";
constant E : std_logic_vector(6 downto 0) := "0000110";
constant F : std_logic_vector(6 downto 0) := "0001110";
signal valor : integer range 0 to 1023;
---------------
-- implementacao
---------------
begin
valor <= to_integer(unsigned(SW(9 downto 0)));
process(valor)
    begin

        -- Por padrão, deixa todos desligados
        HEX0 <= ZERO;
        HEX1 <= ZERO;
        HEX2 <= ZERO;
        HEX3 <= ZERO;

		  if KEY(0) = '0' then
		  --UNIDADE BASE 16
				case valor mod 16 is
					when 1 => HEX0 <= ONE;
					when 2 => HEX0 <= TWO;
					when 3 => HEX0 <= THREE;
					when 4 => HEX0 <= FOUR;
					when 5 => HEX0 <= FIVE;
					when 6 => HEX0 <= SIX;
					when 7 => HEX0 <= SEVEN;
					when 8 => HEX0 <= EIGHT;
					when 9 => HEX0 <= NINE;
					when 10 => HEX0 <= A;
					when 11 => HEX0 <= B;
					when 12 => HEX0 <= C;
					when 13 => HEX0 <= D;
					when 14 => HEX0 <= E;
					when 15 => HEX0 <= F;
					when others => HEX0 <= ZERO;
				end case;
		  
		  --DEZENA BASE 16
		  
				case (valor / 16) mod 16 is
					when 0 => HEX1 <= ZERO;
					when 1 => HEX1 <= ONE;
					when 2 => HEX1 <= TWO;
					when 3 => HEX1 <= THREE;
					when 4 => HEX1 <= FOUR;
					when 5 => HEX1 <= FIVE;
					when 6 => HEX1 <= SIX;
					when 7 => HEX1 <= SEVEN;
					when 8 => HEX1 <= EIGHT;
					when 9 => HEX1 <= NINE;
					when 10 => HEX1 <= A;
					when 11 => HEX1 <= B;
					when 12 => HEX1 <= C;
					when 13 => HEX1 <= D;
					when 14 => HEX1 <= E;
					when 15 => HEX1 <= F;
					when others => HEX1 <= ZERO;
				end case;
		  
		  --CENTENA BASE 16
		  
				case (valor / 256) mod 16 is
					when 1 => HEX2 <= ONE;
					when 2 => HEX2 <= TWO;
					when 3 => HEX2 <= THREE;
					when 4 => HEX2 <= FOUR;
					when 5 => HEX2 <= FIVE;
					when 6 => HEX2 <= SIX;
					when 7 => HEX2 <= SEVEN;
					when 8 => HEX2 <= EIGHT;
					when 9 => HEX2 <= NINE;
					when 10 => HEX2 <= A;
					when 11 => HEX2 <= B;
					when 12 => HEX2 <= C;
					when 13 => HEX2 <= D;
					when 14 => HEX2 <= E;
					when 15 => HEX2 <= F;
					when others => HEX2 <= ZERO;
				end case;
		  else
				case valor mod 10 is
					when 1 => HEX0 <= ONE;
					when 2 => HEX0 <= TWO;
					when 3 => HEX0 <= THREE;
					when 4 => HEX0 <= FOUR;
					when 5 => HEX0 <= FIVE;
					when 6 => HEX0 <= SIX;
					when 7 => HEX0 <= SEVEN;
					when 8 => HEX0 <= EIGHT;
					when 9 => HEX0 <= NINE;
					when others => HEX0 <= ZERO;
				end case;

        -- DEZENA
				case (valor / 10) mod 10 is
					when 0 => HEX1 <= ZERO;
					when 1 => HEX1 <= ONE;
					when 2 => HEX1 <= TWO;
					when 3 => HEX1 <= THREE;
					when 4 => HEX1 <= FOUR;
					when 5 => HEX1 <= FIVE;
					when 6 => HEX1 <= SIX;
					when 7 => HEX1 <= SEVEN;
					when 8 => HEX1 <= EIGHT;
					when 9 => HEX1 <= NINE;
					when others => HEX1 <= ZERO;
				end case;

        -- CENTENA
				case (valor / 100) mod 10 is
					when 1 => HEX2 <= ONE;
					when 2 => HEX2 <= TWO;
					when 3 => HEX2 <= THREE;
					when 4 => HEX2 <= FOUR;
					when 5 => HEX2 <= FIVE;
					when 6 => HEX2 <= SIX;
					when 7 => HEX2 <= SEVEN;
					when 8 => HEX2 <= EIGHT;
					when 9 => HEX2 <= NINE;
					when others => HEX2 <= ZERO;
				end case;
		  
		  --MILHAR
				case valor / 1000 is
					when 1 => HEX3 <= ONE;
					when others => HEX3 <= ZERO;
				end case;
			end if;
    end process;
end rtl;
