library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

ENTITY decodificador_display_7_segmentos IS 
    PORT ( 
        A: in std_logic_vector(3 downto 0); 
        Z: out std_logic_vector(6 downto 0)
    ); 
END decodificador_display_7_segmentos; 

ARCHITECTURE logica OF decodificador_display_7_segmentos IS
    SIGNAL A0, A1, A2, A3, NA0, NA1, NA2, NA3: std_logic;
    BEGIN 
      A0 <= A(0);
      A1 <= A(1);
      A2 <= A(2);
      A3 <= A(3);
      NA0 <= NOT A(0);
      NA1 <= NOT A(1);
      NA2 <= NOT A(2);
      NA3 <= NOT A(3);

      --0001+0100+1011+1101
      Z(0) <= (NA3 AND NA2 AND NA1 AND A0)  OR (NA3 AND A2 AND NA1 AND NA0) OR
              (A3 AND NA2 AND A1 AND A0)    OR (A3 AND A2 AND NA1 AND A0);
      
      --0101+0110+1011+1100+1110+1111
      Z(1) <= (NA3 AND A2 AND NA1 AND A0)   OR (NA3 AND A2 AND A1 AND NA0) OR
              (A3 AND NA2 AND A1 AND A0)    OR (A3 AND A2 AND NA1 AND NA0) OR
              (A3 AND A2 AND A1 AND NA0)    OR (A3 AND A2 AND A1 AND A0);

      --0010+1100+1110+1111
      Z(2) <= (NA3 AND NA2 AND A1 AND NA0)  OR (A3 AND A2 AND NA1 AND NA0) OR
              (A3 AND A2 AND A1 AND NA0)    OR (A3 AND A2 AND A1 AND A0);

      --0001+0100+0111+1010+1111
      Z(3) <= (NA3 AND NA2 AND NA1 AND A0)  OR (NA3 AND A2 AND NA1 AND NA0) OR
              (NA3 AND A2 AND A1 AND A0)    OR (A3 AND NA2 AND A1 AND NA0) OR
              (A3 AND A2 AND A1 AND A0);

      --0001+0011+0100+0101+0111+1001
      Z(4) <= (NA3 AND NA2 AND NA1 AND A0)  OR (NA3 AND NA2 AND A1 AND A0) OR
              (NA3 AND A2 AND NA1 AND NA0)  OR (NA3 AND A2 AND NA1 AND A0) OR
              (NA3 AND A2 AND A1 AND A0)    OR (A3 AND NA2 AND NA1 AND A0);

      --0001+0010+0011+0111+1101
      Z(5) <= (NA3 AND NA2 AND NA1 AND A0)  OR (NA3 AND NA2 AND A1 AND NA0) OR
              (NA3 AND NA2 AND A1 AND A0) OR (NA3 AND A2 AND A1 AND A0) OR
              (A3 AND A2 AND NA1 AND A0);

      --0000+0001+0111+1100
      Z(6) <= (NA3 AND NA2 AND NA1 AND NA0) OR (NA3 AND NA2 AND NA1 AND A0) OR
              (NA3 AND A2 AND A1 AND A0) OR (A3 AND A2 AND NA1 AND NA0);
END logica;

