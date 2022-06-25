library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

--Interface é uma entidade reponsável por controlar as entradas e saídas da ULA
--a partir do labsland

ENTITY interface_contador IS 
    PORT ( 
        SW: in std_logic_vector(3 downto 0);
        CLOCK_50: in std_logic;
        LEDR: out std_logic_vector(3 downto 0);
        LEDG: out std_logic_vector(3 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX6: out std_logic_vector(6 downto 0)
    ); 
END interface_contador; 

ARCHITECTURE logica OF interface_contador IS 
    COMPONENT interface_ula
        PORT ( 
            Clock: in std_logic; 
            Cin: in std_logic;
            A, B : out std_logic_vector(3 downto 0);
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
    SIGNAL A, B: std_logic_vector(3 downto 0);
    SIGNAL Operacao: std_logic_vector(2 downto 0);
    SIGNAL Cin, Zero, Overflow, Negativo: std_logic;
    
    BEGIN
    Operacao <= SW(2 downto 0);
    Cin <= SW(3);
    --Realizando o calculo na ALU
    Calcular: interface_ula PORT MAP(
                    Clock => CLOCK_50,
                    A => A,
                    B => B,
                    Cin => Cin,
                    Operacao => Operacao, 
                    Resultado => R_LED,
                    Cout => Cout(0),
                    Zero => Zero,
                    Overflow => Overflow,
                    Negativo => Negativo
                );
                
    --Mostrando os resultados nos displays de 7 segmentos e nos leds
    LEDR <= R_LED;
    LEDG(0) <= Cout(0);
    LEDG(1) <= Zero;
    LEDG(2) <= Overflow;
    LEDG(3) <= Negativo;
    
    SUB_NEGATIVO(0) <= R_LED(3) AND (NOT Operacao(2)) AND (NOT Operacao(1)) AND Operacao(0);
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
    HEX1 <= "0111111" when (Operacao = "001") and (R_LED(3) = '1') else 
            "1000000" when Operacao = "001" else HEX_COUT;
    
    HEX2 <= "0110111";
        
    DB: decodificador_display_7_segmentos PORT MAP(A => B, Z => HEX3);
    DA: decodificador_display_7_segmentos PORT MAP(A => A, Z => HEX6);
END logica;
