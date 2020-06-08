library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 
use IEEE.STD_LOGIC_1164.ALL;

entity bit_alu is
    port (A, B, ENA, ENB, INVA, cin : in std_logic;
	      F : in unsigned (1 downto 0);
		  output, cout : out std_logic);
end bit_alu;

architecture Behavioral of bit_alu is

signal d : std_logic_vector (3 downto 0);
signal l0, l1, l2, s2 : std_logic; 
begin

decoder: process
begin
	wait on F;
	if (F(1) = '0') and (F(0) = '0') then
		d <= (0 => '1', others => '0');
	elsif (F(1) = '0') then 
		d <= (1 => '1', others => '0');
	elsif (F(0) = '0') then 
		d <= (2 => '1', others => '0');
	else  
		d <= (3 => '1', others => '0');
	end if;	
end process;

logical: process
variable BON, AINV : std_logic;  -- inside the logical unit
begin    
	wait on A, B, INVA, ENA, ENB, d(0), d(1), d(2);
	
	if INVA = '1'    and ENA = '1' then
	   AINV := not A;
	elsif INVA = '1' and ENA = '0' then
	   AINV := '1';
	elsif INVA = '0' and ENA = '1' then
	   AINV := A;
	elsif INVA = '0' and ENA = '0' then
	   AINV := '0';	
	end if;
	
	if ENB = '0' then
	   BON := '0';
	else
	   BON := B;
    end if;
        
    l0 <= (AINV and BON) and d(0);
    l1 <= (AINV or BON)  and d(1);
    l2 <= (not BON)      and d(2) ;

end process;

fa: process (A, B, INVA, ENA, ENB, d(3))
variable sum, s1, temp1, temp2 : std_logic;
begin
    temp1 := INVA XOR (A AND ENA);
    temp2 :=  B AND ENB;
	s1  := (temp1) xor (temp2);
	sum := (s1 xor cin) and d(3);
	cout <= (temp1 and temp2 and d(3)) or (cin and s1 and d(3));
	s2   <= sum;
end process;

output <= (l0 or l1) or (l2 or s2);
end Behavioral;
