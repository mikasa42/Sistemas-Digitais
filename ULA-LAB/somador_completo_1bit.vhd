library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

ENTITY somador_completo_1bit IS 
    PORT ( 
        A: in std_logic; 
        B: in std_logic;
        Cin: in std_logic; 
        Cout: out std_logic;
        Z: out std_logic
    ); 
END somador_completo_1bit; 

ARCHITECTURE logica OF somador_completo_1bit IS 
BEGIN 
    Z <= A XOR B XOR Cin; 
    Cout <= (A AND B) OR (Cin AND (A XOR B));
END logica;