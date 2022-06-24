library ieee; 
use IEEE.STD_LOGIC_1164.ALL; 

ENTITY ula IS 
    PORT ( 
        A, B: in std_logic_vector(3 downto 0); 
        Cin: in std_logic;
        Operacao: in std_logic_vector(2 downto 0);
        Resultado: out std_logic_vector(3 downto 0);
        Cout: out std_logic;
        Zero: out std_logic;
        Overflow: out std_logic;
        Negativo: out std_logic
    ); 
END ula; 

ARCHITECTURE logica OF ula IS 
    COMPONENT somador_completo_4bits
        PORT (
            A, B: in std_logic_vector(3 downto 0);
            Cin: in std_logic;
            Cout, Overflow: out std_logic;
            Z: out std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
    COMPONENT troca_de_sinal IS 
        PORT ( 
            A: in std_logic_vector(3 downto 0); 
            Z: out std_logic_vector(3 downto 0)
        ); 
    END COMPONENT;
    
    COMPONENT deslocar_esquerda IS 
        PORT ( 
            A: in std_logic_vector(3 downto 0); 
            Z: out std_logic_vector(3 downto 0)
        ); 
    END COMPONENT;
    
    COMPONENT deslocar_direita IS 
        PORT ( 
            A: in std_logic_vector(3 downto 0); 
            Z: out std_logic_vector(3 downto 0)
        ); 
    END COMPONENT;
    
    COMPONENT xor_4bits IS 
        PORT ( 
            A, B: in std_logic_vector(3 downto 0); 
            Z: out std_logic_vector(3 downto 0)
        ); 
    END COMPONENT;
    
    COMPONENT and_4bits IS 
        PORT ( 
            A, B: in std_logic_vector(3 downto 0); 
            Z: out std_logic_vector(3 downto 0)
        ); 
    END COMPONENT;

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

    --Sinal da entrada B invertida
    SIGNAL BInvertido: std_logic_vector(3 downto 0);

    --Resultado Das 8 Operações
    SIGNAL RSoma, Rsub, RIncremento, RTrocaDeSinal, R: std_logic_vector(3 downto 0);
    SIGNAL RDeslocarEsquerda, RDeslocarDireita, RXor4B, RAnd4B: std_logic_vector(3 downto 0);

    --Resultado De Cout Dos Somadores
    SIGNAL SomaCout, SubCout, IncrementoCout, SomaOverflow, SubOverflow: std_logic;

    BEGIN
    --Fazendo inverso da entrada B
    BInverso: troca_de_sinal PORT MAP(A => B, Z => BInvertido);
    
    --Fazendo as 8 operações simultaneamente
    Soma: somador_completo_4bits PORT MAP(
                                            A => A, B => B, Cin => Cin, 
                                            Cout => SomaCout, Overflow => SomaOverflow, Z => RSoma
                                        );
    Sub: somador_completo_4bits PORT MAP(   
                                            A => A, B => BInvertido, Cin => Cin, 
                                            Cout => SubCout,  Overflow => SubOverflow, Z => RSub
                                        );
    Incremento: somador_completo_4bits PORT MAP(
                                            A => A, B => "0000", Cin => '1', 
                                            Cout => IncrementoCout, Z => RIncremento
                                        );
    TrocaDeSinal: troca_de_sinal PORT MAP(A => A, Z => RTrocaDeSinal);
    DeslocarEsquerda: deslocar_esquerda PORT MAP(A => A, Z => RDeslocarEsquerda);
    DeslocarDireita: deslocar_direita PORT MAP(A => A, Z => RDeslocarDireita);
    Xor4B: xor_4bits PORT MAP(A => A, B => B, Z => RXor4B);
    And4B: and_4bits PORT MAP(A => A, B => B, Z => RAnd4B);
   
    --Selecionando a saída principal final da ULA
    RFinal: mux8_1_4bits PORT MAP(
                        A0 => RSoma, 
                        A1 => RSub, 
                        A2 => RIncremento, 
                        A3 => RTrocaDeSinal, 
                        A4 => RDeslocarEsquerda,
                        A5 => RDeslocarDireita,
                        A6 => RXor4B,
                        A7 => RAnd4B,
                        C => Operacao,
                        Z => R
                    );

    --Selecionando a saída Cout da ULA
    RCout: mux8_1_1bit PORT MAP(
                             A0 => SomaCout, 
                             A1 => SubCout, 
                             A2 => IncrementoCout,
                             A3 => '0',
                             A4 => '0',
                             A5 => '0',
                             A6 => '0',
                             A7 => '0',
                             C => Operacao, 
                             Z => Cout
                        );
                           
    --Selecionando a saída Overflow da ULA
    ROverflow: mux8_1_1bit PORT MAP(
                             A0 => SomaOverflow, 
                             A1 => SubOverflow, 
                             A2 => '0',
                             A3 => '0',
                             A4 => '0',
                             A5 => '0',
                             A6 => '0',
                             A7 => '0',
                             C => Operacao, 
                             Z => Overflow
                        );
                           
    Zero <= (NOT R(0)) AND (NOT R(1)) AND (NOT R(2)) AND (NOT R(3));
    Negativo <= (NOT Operacao(2)) AND (NOT Operacao(1)) AND Operacao(0) AND R(3);
    Resultado <= R;
END logica;
