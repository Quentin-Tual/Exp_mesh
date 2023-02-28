library ieee;
use ieee.std_logic_1164.all;
-- USE IEEE.std_logic_arith.all;

entity meshed_cut01 is
    port(
        -- Initial ports
        input_vector    : in std_logic_vector(7 downto 0);
        output_vector   : out std_logic_vector(1 downto 0);
        -- Added mesh
        mesh            : out std_logic_vector(1 downto 0)
    );
end meshed_cut01;

architecture rtl of meshed_cut01 is
-- initial signals
    signal s0 : std_logic_vector(7 downto 0);
    signal s1 : std_logic_vector(2 downto 0);
    signal s2 : std_logic_vector(1 downto 0);

    signal mA : std_logic_vector(2 downto 0);
    signal mB : std_logic_vector(2 downto 0);
begin

-- initial wiring

    s0(0) <= input_vector(0);
    s0(1) <= input_vector(1);
    s0(2) <= input_vector(2);
    s0(3) <= input_vector(3);
    s0(4) <= input_vector(4);
    s0(5) <= input_vector(5);
    s0(6) <= input_vector(6);
    s0(7) <= input_vector(7);

    s1(0) <= s0(0) or s0(1);
    s1(1) <= s0(3) or s0(4);
    s1(2) <= s0(5) xor s0(6);
    
    s2(0) <= s1(1) and s0(2);
    s2(1) <= s1(2) or s0(7); 

    output_vector(0) <= s2(0) and s1(0);
    output_vector(1) <= s2(0) xor s2(1);

-- Added wiring for mesh

    mesh(0) <= s0(5) xor s1(1) xor s2(0);
    mesh(1) <= s0(1) xor s1(2) xor s2(1);

end architecture;