library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

ENTITY troca_de_sinal IS 
    PORT ( 
        A: in std_logic_vector(3 downto 0); 
        Z: out std_logic_vector(3 downto 0)
    ); 
END troca_de_sinal; 

ARCHITECTURE logica OF troca_de_sinal IS
    COMPONENT somador_completo_4bits
        PORT (
            A, B: in std_logic_vector(3 downto 0);
            Cin: in std_logic;
            Cout: out std_logic;
            Z: out std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
    SIGNAL S: std_logic_vector(3 downto 0);
    SIGNAL Um : std_logic := '1';
    BEGIN 
        S(0) <= NOT A(0);
        S(1) <= NOT A(1);
        S(2) <= NOT A(2);
        S(3) <= NOT A(3);
        
        R: somador_completo_4bits PORT MAP(A => S, B => "0000", Cin => '1', Z => Z);
END logica;
