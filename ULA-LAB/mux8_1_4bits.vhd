library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

ENTITY mux8_1_4bits IS 
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
END mux8_1_4bits; 

ARCHITECTURE logica OF mux8_1_4bits IS
  COMPONENT mux8_1_1bit IS 
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
    END COMPONENT; 

    BEGIN 
      M0: mux8_1_1bit PORT MAP( 
                                A0 => A0(0), A1 => A1(0), A2 => A2(0), 
                                A3 => A3(0), A4 => A4(0), A5 => A5(0),
                                A6 => A6(0), A7 => A7(0), C => C, Z => Z(0)
                              );
      M1: mux8_1_1bit PORT MAP( 
                                A0 => A0(1), A1 => A1(1), A2 => A2(1), 
                                A3 => A3(1), A4 => A4(1), A5 => A5(1),
                                A6 => A6(1), A7 => A7(1), C => C, Z => Z(1)
                              );
      M2: mux8_1_1bit PORT MAP( 
                                A0 => A0(2), A1 => A1(2), A2 => A2(2), 
                                A3 => A3(2), A4 => A4(2), A5 => A5(2),
                                A6 => A6(2), A7 => A7(2), C => C, Z => Z(2)
                              );
      M3: mux8_1_1bit PORT MAP( 
                                A0 => A0(3), A1 => A1(3), A2 => A2(3), 
                                A3 => A3(3), A4 => A4(3), A5 => A5(3),
                                A6 => A6(3), A7 => A7(3), C => C, Z => Z(3)
                              );
END logicA;
