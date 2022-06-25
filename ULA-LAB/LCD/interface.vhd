library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

--Interface é uma entidade reponsável por controlar as entradas e saídas da ULA
--a partir do labsland

ENTITY interface IS 
    PORT ( 
        SW: in std_logic_vector(11 downto 0);
        CLOCK_50: in std_logic;
        LEDR: out std_logic_vector(3 downto 0);
        LEDG: out std_logic_vector(3 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX6: out std_logic_vector(6 downto 0)
    ); 
END interface; 

ARCHITECTURE logica OF interface IS 
    COMPONENT ula
        PORT (            
            A, B : in std_logic_vector(3 downto 0);
            Cin: in std_logic;
            Operacao: in std_logic_vector(2 downto 0);
            Resultado: out std_logic_vector(3 downto 0);
            Cout: out std_logic;
            Zero: out std_logic;
            Overflow: out std_logic;
            Negativo: out std_logic
        );
    END COMPONENT;
    
    COMPONENT decodificador_display_7_segmentos IS 
        PORT ( 
            A: in std_logic_vector(3 downto 0); 
            Z: out std_logic_vector(6 downto 0)
        ); 
    END COMPONENT; 
        
    COMPONENT troca_de_sinal IS 
        PORT ( 
            A: in std_logic_vector(3 downto 0); 
            Z: out std_logic_vector(3 downto 0)
        ); 
    END COMPONENT;
    
    COMPONENT mux8_1_4bits IS 
        PORT ( 
            A0: in std_logic_vector(3 downto 0); 
            A1: in std_logic_vector(3 downto 0); 
            A2: in std_logic_vector(3 downto 0); 
            A3: in std_logic_vector(3 downto 0); 
            A4: in std_logic_vector(3 downto 0); 
            A5: in std_logic_vector(3 downto 0); 
            A6: in std_logic_vector(3 downto 0); 
            A7: in std_logic_vector(3 downto 0); 
            C: in std_logic_vector(2 downto 0);
            Z: out std_logic_vector(3 downto 0)
        ); 
    END COMPONENT;
    
    SIGNAL R_LED, R_TROCADO, R_DISPLAY, Cout, Um: std_logic_vector(3 downto 0);
    SIGNAL HEX_COUT: std_logic_vector(6 downto 0);
    SIGNAL SUB_NEGATIVO: std_logic_vector(2 downto 0);
    
    BEGIN
    --Realizando o calculo na ALU
    Calcular: ula PORT MAP(
                    A => SW(3 downto 0),
                    B => SW(7 downto 4),
                    Cin => SW(8),
                    Operacao => SW(11 downto 9), 
                    Resultado => R_LED,
                    Cout => Cout(0),
                    Zero => LEDG(1),
                    Overflow => LEDG(2),
                    Negativo => LEDG(3)
                );
                
    --Mostrando os resultados nos displays de 7 segmentos e nos leds
    LEDR <= R_LED;
    LEDG(0) <= Cout(0);
    
    SUB_NEGATIVO(0) <= R_LED(3) AND (NOT SW(11)) AND (NOT SW(10)) AND SW(9);
    R_TROCA: troca_de_sinal PORT MAP(A => R_LED, Z => R_TROCADO);
    R_Final: mux8_1_4bits PORT MAP(
        A0 => R_LED, 
        A1 => R_TROCADO,
        A2 => "0000",
        A3 => "0000",
        A4 => "0000",
        A5 => "0000",
        A6 => "0000",
        A7 => "0000",
        C => SUB_NEGATIVO,
        Z => R_DISPLAY
    );
    DR: decodificador_display_7_segmentos PORT MAP(A => R_DISPLAY, Z => HEX0);
    
    DC: decodificador_display_7_segmentos PORT MAP(A => Cout, Z => HEX_COUT);
    HEX1 <= "0111111" when (SW(11 downto 9) = "001") and (R_LED(3) = '1') else 
            "1000000" when SW(11 downto 9) = "001" else HEX_COUT;
    
    HEX2 <= "0110111";
        
    DB: decodificador_display_7_segmentos PORT MAP(A => SW(7 downto 4), Z => HEX3);
    DA: decodificador_display_7_segmentos PORT MAP(A => SW(3 downto 0), Z => HEX6);
END logica;
