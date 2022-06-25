library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity decodificador_simbolos_display_lcd is
    port (
        hex: in unsigned(3 downto 0);
        display: out std_logic_vector(9 downto 0)
    );
end decodificador_simbolos_display_lcd;

architecture logica of decodificador_simbolos_display_lcd is

begin
    display <= 
    "1000101011" when hex = "000" else  -- Positivo
    "1000101101" when hex = "001" else  -- Negativo
    "1001111111" when hex = "010" else  -- Deslocamento esquerda
    "1001111110" when hex = "011" else  -- Deslocamento direita
    "1000100110" when hex = "100" else  -- XOR
    "1000101010" when hex = "101" else  -- AND
    "1000101101" when hex = "110" else  -- Igual
    "1000100111";  -- null
end decodificador_hex_display_lcd;

