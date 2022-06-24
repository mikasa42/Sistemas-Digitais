library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

ENTITY and_4bits IS 
    PORT ( 
        A,B: in std_logic_vector(3 downto 0); 
        Z: out std_logic_vector(3 downto 0)
    ); 
END and_4bits; 

ARCHITECTURE logica OF and_4bits IS
    BEGIN 
        Z(0) <= A(0) AND B(0);
        Z(1) <= A(1) AND B(1);
        Z(2) <= A(2) AND B(2);
        Z(3) <= A(3) AND B(3);
END logica;