library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ht2_meshed_cut01 is

end tb_ht2_meshed_cut01;

architecture rtl of tb_ht2_meshed_cut01 is

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
    signal tb_output_vector_auth, tb_output_vector_ht : std_logic_vector(1 downto 0);
    signal mesh_auth, mesh_ht : std_logic_vector(1 downto 0);
begin

    UUT1 : entity work.ht2_meshed_cut01
    port map (
        input_vector => tb_input_vector,
        output_vector => tb_output_vector_ht,
        mesh => mesh_ht
    );

    UUT2 : entity work.meshed_cut01
    port map (
        input_vector => tb_input_vector,
        output_vector => tb_output_vector_auth,
        mesh => mesh_auth
    );

    process 
        variable detection_number : natural := 0;
        variable output_diff : natural := 0;
        variable silent_detection : natural := 0;
    begin

        report "Starting test simulation ...";

        -- Boucle de "00000000" à "11111111" (ou en hexa "00" à "FF") comme input de chaque UUT, pour chaque itération :
            -- Vérification de similarité des sorties (output_vector et mesh). 
            -- Si le mesh diffère mais que l'output_vector est identique : report la détection
            -- Incrémenter le nombre de détection par le mesh de 1
        for i in 0 to 255 loop
            wait1;
            tb_input_vector <= std_logic_vector(to_unsigned(i, 8));

            if tb_output_vector_auth /= tb_output_vector_ht then
                output_diff := output_diff + 1;  
            end if;

            if mesh_auth /= mesh_ht then
                detection_number := detection_number + 1;
            end if;

            if (tb_output_vector_auth = tb_output_vector_ht) and (mesh_auth /= mesh_ht) then
                silent_detection := silent_detection + 1;
            end if;
        end loop;

        report "Simulation terminated";
            report "Output differences : " & natural'image(output_diff); 
            report "Mesh detections : " & natural'image(detection_number);
            report "Silent detections : " & natural'image(silent_detection);
        wait;
    end process;

end architecture;