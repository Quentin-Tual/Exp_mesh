library ieee;
use ieee.std_logic_1164.all;

entity tb_ht_meshed_cut01 is

end tb_ht_meshed_cut01;

architecture rtl of tb_ht_meshed_cut01 is

    constant T : time := 20 us;

    procedure wait_cycles(n : natural) is
    begin
        for i in 0 to n-1 loop
            wait for T;
        end loop; 
    end procedure;

    procedure wait1 is
    begin
        wait for T;
    end procedure;

    signal tb_input_vector : std_logic_vector(7 downto 0) := "00000000";
    signal tb_output_vector : std_logic_vector(1 downto 0);
begin

    UUT : entity work.ht_meshed_cut01
    port map (
        input_vector => tb_input_vector,
        output_vector => tb_output_vector
    );

    process 
    begin

        report "Starting test simulation ...";
        report "Incremental by one";
        wait1;
        tb_input_vector <= "00000001";

        wait1;
        tb_input_vector <= "00000010";

        wait1;
        tb_input_vector <= "00000011";

        wait1;
        tb_input_vector <= "00000100";

        report "Multiplied by two";
        wait1;
        tb_input_vector <= "00001000";

        wait1;
        tb_input_vector <= "00010000";

        wait1;
        tb_input_vector <= "00100000";

        wait1;
        tb_input_vector <= "01000000";

        report "Checkerboard";
        wait1;
        tb_input_vector <= "01010101";

        wait1;
        tb_input_vector <= "10101010";

        wait1;
        tb_input_vector <= "01010101";

        wait1;
        tb_input_vector <= "10101010";

        report "Simulation terminated";

        wait;
    end process;

end architecture;