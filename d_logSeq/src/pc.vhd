-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: PC.vhd
-- date: 4/4/2017

-- Contador de 16bits
-- if (reset[t] == 1) out[t+1] = 0
-- else if (load[t] == 1)  out[t+1] = in[t]
-- else if (inc[t] == 1) out[t+1] = out[t] + 1
-- else out[t+1] = out[t]

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    port(
        clock     : in  STD_LOGIC;
        increment : in  STD_LOGIC;
        load      : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        input     : in  STD_LOGIC_VECTOR(15 downto 0);
        output    : out STD_LOGIC_VECTOR(15 downto 0) 
    );
end entity;

architecture arch of PC is

    signal muxOut    : STD_LOGIC_VECTOR(15 downto 0);
    signal muxin0    : STD_LOGIC_VECTOR(15 downto 0);
    signal outputReg : STD_LOGIC_VECTOR(15 downto 0);
    signal load_reg  : STD_LOGIC;
    signal sel_mux   : STD_LOGIC;

    -- sinais intermediários
    signal muxIncOut  : STD_LOGIC_VECTOR(15 downto 0);
    signal muxLoadOut : STD_LOGIC_VECTOR(15 downto 0);

    component Inc16 is
        port(
            a : in  STD_LOGIC_VECTOR(15 downto 0);
            q : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component Register16 is
        port(
            clock  : in  STD_LOGIC;
            input  : in  STD_LOGIC_VECTOR(15 downto 0);
            load   : in  STD_LOGIC;
            output : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component Mux16 is
        port (
            a   : in  STD_LOGIC_VECTOR(15 downto 0);
            b   : in  STD_LOGIC_VECTOR(15 downto 0);
            sel : in  STD_LOGIC;
            q   : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;


begin

    --------------------------------------------------
    -- Incrementa o valor atual do PC
    --------------------------------------------------
    INC_PC : Inc16
        port map(
            a => outputReg,
            q => muxin0
        );


    --------------------------------------------------
    -- MUX 1: incremento
    --
    -- increment = 0 -> mantém o valor atual
    -- increment = 1 -> valor atual + 1
    --------------------------------------------------
    MUX_INC : Mux16
        port map(
            a   => outputReg,
            b   => muxin0,
            sel => increment,
            q   => muxIncOut
        );


    --------------------------------------------------
    -- MUX 2: load
    --
    -- load = 0 -> resultado anterior
    -- load = 1 -> input
    --
    -- load tem prioridade sobre increment
    --------------------------------------------------
    MUX_LOAD : Mux16
        port map(
            a   => muxIncOut,
            b   => input,
            sel => load,
            q   => muxLoadOut
        );


    --------------------------------------------------
    -- MUX 3: reset
    --
    -- reset = 0 -> resultado anterior
    -- reset = 1 -> zero
    --
    -- reset possui prioridade máxima
    --------------------------------------------------
    MUX_RESET : Mux16
        port map(
            a   => muxLoadOut,
            b   => "0000000000000000",
            sel => reset,
            q   => muxOut
        );


    --------------------------------------------------
    -- O registrador sempre recebe o valor decidido
    -- pela lógica dos MUXes.
    --------------------------------------------------
    load_reg <= '1';

    REG_PC : Register16
        port map(
            clock  => clock,
            input  => muxOut,
            load   => load_reg,
            output => outputReg
        );


    --------------------------------------------------
    -- Saída do Program Counter
    --------------------------------------------------
    output <= outputReg;


end architecture;