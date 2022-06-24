library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

ENTITY deslocar_direita IS 
    PORT ( 
        A: in std_logic_vector(3 downto 0); 
        Z: out std_logic_vector(3 downto 0)
    ); 
END deslocar_direita; 

ARCHITECTURE logica OF deslocar_direita IS
    BEGIN 
        Z(3) <= A(0);
        Z(0) <= A(1);
        Z(1) <= A(2);
        Z(2) <= A(3);
END logica;