library IEEE;
use IEEE.std_logic_1164.all;

entity tb_rising_edge_detector is
end entity tb_rising_edge_detector;

architecture sim of tb_rising_edge_detector is
    constant CLK_PERIOD : time := 10 ns;

    signal clk : std_logic := '0';
    signal x   : std_logic := '0';
    signal y   : std_logic;
begin

    -- Clock generation (100 MHz)
    clk <= not clk after CLK_PERIOD / 2;

    -- Device Under Test (DUT)
    dut: entity work.rising_edge_detector
        port map (
            CLK => clk,
            X   => x,
            Y   => y
        );

    -- Stimulus process
    stim_proc: process
    begin
        wait for 15 ns;

        -- First rising edge on X
        x <= '1';
        wait for 40 ns; -- X stays High across multiple clock cycles

        -- Falling edge on X
        x <= '0';
        wait for 20 ns;

        -- Second rising edge on X
        x <= '1';
        wait for 30 ns;

        x <= '0';
        wait;
    end process;

end architecture sim;