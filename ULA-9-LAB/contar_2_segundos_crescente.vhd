library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

ENTITY contar_2_segundos_crescente is
    GENERIC(maximo : integer := 100000000); 
    PORT(
        clock: in std_logic;
        contagem: out std_logic_vector(3 downto 0) := "0000"
    );
END contar_2_segundos_crescente;

ARCHITECTURE logica of contar_2_segundos_crescente is
    SIGNAL temporario: unsigned(3 downto 0) := "0000";
BEGIN
        contar: PROCESS (clock)
        -- atribuindo um intervalo de [0,100000000) começando em 0 ex: " 0 := 0"
        VARIABLE clock_menor: integer range maximo downto 0 := 0;
        BEGIN
            IF (clock'event and clock='1') THEN
                IF (clock_menor <= maximo) THEN
                    clock_menor := clock_menor + 1;
                ELSE
                    temporario <= temporario + 1;
                    clock_menor := 0;
                END IF;
            END IF;
        END PROCESS;
        contagem <= std_logic_vector(temporario);
END logica;