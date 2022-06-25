library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity decodificador_hex_display_lcd is
    port (
        hex: in unsigned(3 downto 0);
        display: out std_logic_vector(9 downto 0)
    );
end decodificador_hex_display_lcd;

architecture logica of decodificador_hex_display_lcd is

begin
    display <= 
    "1000110000" when hex = "0000" else  -- 0
    "1000110001" when hex = "0001" else  -- 1
    "1000110010" when hex = "0010" else  -- 2
    "1000110011" when hex = "0011" else  -- 3
    "1000110100" when hex = "0100" else  -- 4
    "1000110101" when hex = "0101" else  -- 5
    "1000110110" when hex = "0110" else  -- 6
    "1000110111" when hex = "0111" else  -- 7
    "1000111000" when hex = "1000" else  -- 8
    "1000111001" when hex = "1001" else  -- 9
    "1001000001" when hex = "1010" else  -- A
    "1001000010" when hex = "1011" else  -- B
    "1001000011" when hex = "1100" else  -- C
    "1001000100" when hex = "1101" else  -- D
    "1001000101" when hex = "1110" else  -- E
    "1001000110" when hex = "1111" else  -- F
    "1000000111";  -- null
end decodificador_hex_display_lcd;
