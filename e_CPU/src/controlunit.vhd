-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: ControlUnit.vhd
-- date: 4/4/2017
--
-- Unidade que controla os componentes da CPU

library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
    port(
        instruction                 : in  STD_LOGIC_VECTOR(17 downto 0);
        zr, ng                      : in  STD_LOGIC;
        muxALUI_A                   : out STD_LOGIC;
        muxAM                       : out STD_LOGIC;
        muxDSrc                     : out STD_LOGIC;   -- 0=ALU, 1=imediato da instrução
        zx, nx, zy, ny, f, no       : out STD_LOGIC;
        loadA, loadD, loadM, loadPC : out STD_LOGIC := '0'
    );
end entity;

architecture arch of ControlUnit is
    signal j          : std_logic_vector(2 downto 0);
    signal is_type_c  : std_logic;
    signal is_type_d  : std_logic;   -- Type D-imm: bit17=0 e bit16=1

begin

    is_type_c <= instruction(17);
    is_type_d <= (not instruction(17)) and instruction(16);
    j         <= instruction(2 downto 0);

    -- DESTINO (LOAD)
    -- loadD: tipo C com bit 4 ativo, OU instrução Type D-imm
    loadD <= (is_type_c and instruction(4)) or is_type_d;

    -- loadM: só tipo C com bit 5 ativo
    loadM <= is_type_c and instruction(5);

    -- loadA: só tipo A puro (bit17=0 e bit16=0), ou tipo C com bit 3 ativo
    loadA <= ((not is_type_c) and (not is_type_d)) or (is_type_c and instruction(3));

    -- MUXES
    -- muxALUI_A: seleciona instrução para A apenas em Type A puro
    muxALUI_A <= (not is_type_c) and (not is_type_d);

    -- muxAM: seleciona M (RAM) como entrada da ALU se Type C e bit 13 ativo
    muxAM <= is_type_c and instruction(13);

    -- muxDSrc: seleciona imediato como fonte do registrador D
    muxDSrc <= is_type_d;

    -- ALU (bits 12 a 7) — ativos apenas em instrução Type C
    zx <= is_type_c and instruction(12);
    nx <= is_type_c and instruction(11);
    zy <= is_type_c and instruction(10);
    ny <= is_type_c and instruction(9);
    f  <= is_type_c and instruction(8);
    no <= is_type_c and instruction(7);

    -- SALTO (PROGRAM COUNTER)
    -- Apenas em Type C; verifica condição dos bits j com as flags zr/ng
    loadPC <= '1' when (is_type_c = '1' and (
            (j = "001" and zr = '0' and ng = '0')
         or (j = "010" and zr = '1')
         or (j = "011" and (zr = '1' or (zr = '0' and ng = '0')))
         or (j = "100" and ng = '1')
         or (j = "101" and zr = '0')
         or (j = "110" and (ng = '1' or zr = '1'))
         or (j = "111")
    )) else '0';

end architecture;
