library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 
use IEEE.STD_LOGIC_1164.ALL;

entity tb_bit_alu is
--  Port ( );
end tb_bit_alu;

architecture Behavioral of tb_bit_alu is
COMPONENT bit_alu
     Port (A, B, ENA, ENB, INVA, cin : in std_logic;
            F : in unsigned (1 downto 0);
		   output, cout : out std_logic);
END COMPONENT;
signal  A, B, ENA, ENB, INVA, cin : STD_LOGIC;
signal F :  unsigned (1 downto 0);
signal  output, cout : STD_LOGIC;

begin

U1: bit_alu
   port map (A=>A,B=>B,ENA=>ENA,ENB=>ENB,INVA=>INVA,F=>F,cin=>cin,
                output=>output,cout=>cout);
process
variable c : std_logic;
begin
    A    <= '1';
    B    <= '1';
    ENA  <= '1';
    ENB  <= '1';
    INVA <= '0';
    F   <= "00";
    cin  <= '0';
    wait for 50ns;
    
    for i in 0 to 3 loop 
        F <= F + 1 ;
        A <= not A;
        if i = 2 then 
            cin <= '1';
        end if;
--        wait for 10ns;
        for j in 0 to 3 loop 
            B <= not B;
            if j >= 2 then
                ENB <= '1';
            else
                ENB <= '0';
            end if;
            wait for 35ns;
        end loop;
    end loop;
    
    F <= "00";
    cin <= '0';
    wait for 100ns;
    
    for i in 0 to 3 loop 
        F <= F + 1 ;
        B <= not B;
        if i = 2 then 
            cin <= '1';
        end if;
--        wait for 10ns;
        for j in 0 to 7 loop 
            A <= not A;
            if j = 2 or j = 3 then
                ENA <= '1';
            elsif j = 6 or j = 7 then
                ENA <= '1';
            else
                ENA <= '0';
            end if;
            if j >= 4 then
                INVA <= '1';
            else
                INVA <= '0';
            end if; 
            wait for 35ns;
        end loop;

    end loop;
    
A    <= '0';
B    <= '0';
ENA  <= '0';
ENB  <= '0';
INVA <= '0';
F   <= "00";
cin  <= '0';
wait;

end process;

end Behavioral;
