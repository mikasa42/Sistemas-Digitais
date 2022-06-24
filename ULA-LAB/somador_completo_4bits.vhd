library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

ENTITY somador_completo_4bits IS 
    PORT ( 
        A: in std_logic_vector(3 downto 0); 
        B: in std_logic_vector(3 downto 0);
        Cin: in std_logic; 
        Cout, Overflow: out std_logic;
        Z: out std_logic_vector(3 downto 0)
    ); 
END somador_completo_4bits; 

ARCHITECTURE logica OF somador_completo_4bits IS 
    COMPONENT somador_completo_1bit
        PORT (
            A, B, Cin: in std_logic;
            Cout, Z: out std_logic
        );
    END COMPONENT;
    
    SIGNAL C : std_logic_vector(3 downto 0);
    
    BEGIN
    S0: somador_completo_1bit PORT MAP(A => A(0), B => B(0), Cin => Cin, Cout => C(0), Z => Z(0));
    S1: somador_completo_1bit PORT MAP(A => A(1), B => B(1), Cin => C(0), Cout => C(1), Z => Z(1));
    S2: somador_completo_1bit PORT MAP(A => A(2), B => B(2), Cin => C(1), Cout => C(2), Z => Z(2));
    S3: somador_completo_1bit PORT MAP(A => A(3), B => B(3), Cin => C(2), Cout => C(3), Z => Z(3));
    
    Cout <= C(3);
    Overflow <= (C(3) XOR C(2));
END logica;
