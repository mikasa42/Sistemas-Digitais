library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

ENTITY mux8_1_1bit IS 
    PORT ( 
        A0: in std_logic; 
        A1: in std_logic; 
        A2: in std_logic; 
        A3: in std_logic; 
        A4: in std_logic; 
        A5: in std_logic; 
        A6: in std_logic; 
        A7: in std_logic; 
        C: in std_logic_vector(2 downto 0);
        Z: out std_logic
    ); 
END mux8_1_1bit; 

ARCHITECTURE logica OF mux8_1_1bit IS
    BEGIN 
    Z <= (A0 AND (NOT C(2)) AND (NOT C(1)) AND (NOT C(0))) OR
         (A1 AND (NOT C(2)) AND (NOT C(1)) AND C(0)) OR
         (A2 AND (NOT C(2)) AND C(1) AND (NOT C(0))) OR
         (A3 AND (NOT C(2)) AND C(1) AND C(0)) OR
         (A4 AND C(2) AND (NOT C(1)) AND (NOT C(0))) OR
         (A5 AND C(2) AND (NOT C(1)) AND C(0)) OR
         (A6 AND C(2) AND C(1) AND (NOT C(0))) OR
         (A7 AND C(2) AND C(1) AND C(0));
END logicA;

