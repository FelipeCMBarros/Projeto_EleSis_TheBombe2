library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
end entity TopLevel;


architecture rtl of TopLevel is

    ----------------------------------------------------------------
    -- Sinais
    ----------------------------------------------------------------
    signal s_zero     : std_logic;
    signal s_neg      : std_logic;
    signal ext        : std_logic_vector(15 downto 0);
    signal s_overflow : std_logic;


    ----------------------------------------------------------------
    -- Componente ALU
    ----------------------------------------------------------------
    component ALU is
        port(
            x      : in  std_logic_vector(15 downto 0);
            y      : in  std_logic_vector(15 downto 0);
            zx     : in  std_logic;
            nx     : in  std_logic;
            zy     : in  std_logic;
            ny     : in  std_logic;
            f      : in  std_logic;
            no     : in  std_logic;
            shift  : in  std_logic;
            direct : in  std_logic;
            zr     : out std_logic;
            ng     : out std_logic;
            saida  : out std_logic_vector(15 downto 0);
            err    : out std_logic
        );
    end component;


    ----------------------------------------------------------------
    -- Códigos dos displays de 7 segmentos
    -- Display da DE0-CV: ativo em nível baixo
    ----------------------------------------------------------------
    constant ZERO  : std_logic_vector(6 downto 0) := "1000000";
    constant ONE   : std_logic_vector(6 downto 0) := "1111001";
    constant TWO   : std_logic_vector(6 downto 0) := "0100100";
    constant THREE : std_logic_vector(6 downto 0) := "0110000";
    constant FOUR  : std_logic_vector(6 downto 0) := "0011001";
    constant FIVE  : std_logic_vector(6 downto 0) := "0010010";
    constant SIX   : std_logic_vector(6 downto 0) := "0000010";
    constant SEVEN : std_logic_vector(6 downto 0) := "1111000";
    constant EIGHT : std_logic_vector(6 downto 0) := "0000000";
    constant NINE  : std_logic_vector(6 downto 0) := "0010000";

    constant A : std_logic_vector(6 downto 0) := "0001000";
    constant B : std_logic_vector(6 downto 0) := "0000011";
    constant C : std_logic_vector(6 downto 0) := "1000110";
    constant D : std_logic_vector(6 downto 0) := "0100001";
    constant E : std_logic_vector(6 downto 0) := "0000110";
    constant F : std_logic_vector(6 downto 0) := "0001110";


begin

    ----------------------------------------------------------------
    -- Instância da ALU
    ----------------------------------------------------------------
    A0 : ALU
    port map(
        x      => "1000000000000000",
        y      => "1000000000000000",

        zx     => SW(0),
        nx     => SW(1),
        zy     => SW(2),
        ny     => SW(3),
        f      => SW(4),
        no     => SW(5),
        shift  => SW(6),
        direct => SW(7),

        zr     => s_zero,
        ng     => s_neg,
        saida  => ext,
        err    => s_overflow
    );


    ----------------------------------------------------------------
    -- LEDs
    ----------------------------------------------------------------
    LEDR(0) <= s_overflow;
    LEDR(1) <= s_zero;
    LEDR(2) <= s_neg;

    -- LEDs não utilizados
    LEDR(9 downto 3) <= (others => '0');


    ----------------------------------------------------------------
    -- Displays de 7 segmentos
    ----------------------------------------------------------------
    process(ext)
    begin

        ------------------------------------------------------------
        -- HEX0 = bits 3..0
        ------------------------------------------------------------
        case ext(3 downto 0) is

            when "0000" => HEX0 <= ZERO;
            when "0001" => HEX0 <= ONE;
            when "0010" => HEX0 <= TWO;
            when "0011" => HEX0 <= THREE;
            when "0100" => HEX0 <= FOUR;
            when "0101" => HEX0 <= FIVE;
            when "0110" => HEX0 <= SIX;
            when "0111" => HEX0 <= SEVEN;
            when "1000" => HEX0 <= EIGHT;
            when "1001" => HEX0 <= NINE;
            when "1010" => HEX0 <= A;
            when "1011" => HEX0 <= B;
            when "1100" => HEX0 <= C;
            when "1101" => HEX0 <= D;
            when "1110" => HEX0 <= E;
            when "1111" => HEX0 <= F;

            when others => HEX0 <= ZERO;

        end case;


        ------------------------------------------------------------
        -- HEX1 = bits 7..4
        ------------------------------------------------------------
        case ext(7 downto 4) is

            when "0000" => HEX1 <= ZERO;
            when "0001" => HEX1 <= ONE;
            when "0010" => HEX1 <= TWO;
            when "0011" => HEX1 <= THREE;
            when "0100" => HEX1 <= FOUR;
            when "0101" => HEX1 <= FIVE;
            when "0110" => HEX1 <= SIX;
            when "0111" => HEX1 <= SEVEN;
            when "1000" => HEX1 <= EIGHT;
            when "1001" => HEX1 <= NINE;
            when "1010" => HEX1 <= A;
            when "1011" => HEX1 <= B;
            when "1100" => HEX1 <= C;
            when "1101" => HEX1 <= D;
            when "1110" => HEX1 <= E;
            when "1111" => HEX1 <= F;

            when others => HEX1 <= ZERO;

        end case;


        ------------------------------------------------------------
        -- HEX2 = bits 11..8
        ------------------------------------------------------------
        case ext(11 downto 8) is

            when "0000" => HEX2 <= ZERO;
            when "0001" => HEX2 <= ONE;
            when "0010" => HEX2 <= TWO;
            when "0011" => HEX2 <= THREE;
            when "0100" => HEX2 <= FOUR;
            when "0101" => HEX2 <= FIVE;
            when "0110" => HEX2 <= SIX;
            when "0111" => HEX2 <= SEVEN;
            when "1000" => HEX2 <= EIGHT;
            when "1001" => HEX2 <= NINE;
            when "1010" => HEX2 <= A;
            when "1011" => HEX2 <= B;
            when "1100" => HEX2 <= C;
            when "1101" => HEX2 <= D;
            when "1110" => HEX2 <= E;
            when "1111" => HEX2 <= F;

            when others => HEX2 <= ZERO;

        end case;


        ------------------------------------------------------------
        -- HEX3 = bits 15..12
        ------------------------------------------------------------
        case ext(15 downto 12) is

            when "0000" => HEX3 <= ZERO;
            when "0001" => HEX3 <= ONE;
            when "0010" => HEX3 <= TWO;
            when "0011" => HEX3 <= THREE;
            when "0100" => HEX3 <= FOUR;
            when "0101" => HEX3 <= FIVE;
            when "0110" => HEX3 <= SIX;
            when "0111" => HEX3 <= SEVEN;
            when "1000" => HEX3 <= EIGHT;
            when "1001" => HEX3 <= NINE;
            when "1010" => HEX3 <= A;
            when "1011" => HEX3 <= B;
            when "1100" => HEX3 <= C;
            when "1101" => HEX3 <= D;
            when "1110" => HEX3 <= E;
            when "1111" => HEX3 <= F;

            when others => HEX3 <= ZERO;

        end case;

    end process;

end architecture rtl;

