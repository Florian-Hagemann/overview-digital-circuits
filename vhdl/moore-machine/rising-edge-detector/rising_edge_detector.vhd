library IEEE;
use IEEE.std_logic_1164.all;

------------------------------------
-- Rising Edge Detector           --
------------------------------------
-- Detect a rising edge on X and  --
-- outputs a 1 on Y, else Y = 0   --
------------------------------------

entity rising_edge_detector is
    port (  X : in std_logic;
            Y : out std_logic;
            CLK : in std_logic);
end rising_edge_detector;

architecture arch_rising_edge_detector of rising_edge_detector is
    type state_type is (ST0, ST1, ST2);
    signal PS,NS : state_type;
begin

    -- On Clock rising edge, transition to next state
    sync_proc: process(CLK, NS)
    begin
        if (rising_edge(CLK)) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process(PS, X)
    begin
        Y <= '0'; -- pre-assign output
        case PS is
            when ST0 => -- State 0
                Y <= '0'; -- Moore Output
                -- Assign next state --
                if (X = '1') then NS <= ST1;
                else NS <= ST0;
                end if;
            when ST1 => -- State 1
                Y <= '1'; -- Moore Output
                -- Assign next state --
                if (X = '1') then NS <= ST2;
                else NS <= ST0;
                end if;
            when ST2 => -- State 0
                Y <= '0'; -- Moore Output
                -- Assign next state --
                if (X = '0') then NS <= ST0;
                else NS <= ST2;
                end if;
            when others => -- catch-all condition
                -- It should never reach this anyways
                Y <= '0';
                NS <= ST0;
        end case;
    end process comb_proc;
end arch_rising_edge_detector;

