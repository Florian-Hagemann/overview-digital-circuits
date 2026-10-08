library IEEE;
use IEEE.std_logic_1164.all;

-----------------------------------
-- Rising Edge Detector          -- 
-----------------------------------
-- Detect a rising edge on X and -- 
-----------------------------------

entity rising_edge_detector is
    port (  X : in std_logic;
            Y : out std_logic;
            CLK : in std_logic);
end rising_edge_detector;

architecture arc_rising_edge_detector of rising_edge_detector is
    type state_type is (ST0, ST1);
    signal PS, NS : state_type;
begin
    sync_proc : process(CLK, NS)
    begin
        if(rising_edge(CLK)) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process(PS, X)
    begin
        Y <= '0'; -- Output preassign
        case PS is
            when ST0 => -- State 0
                if (X = '1') then 
                    Y <= '1'; -- Change Output based on Input
                    NS <= ST1;
                else 
                    Y <= '0'; -- Here other Output if X = '0'
                    NS <= ST0;
                end if;
            when ST1 => -- State 1
                if (X = '0') then
                    Y <= '0'; 
                    NS <= ST0;
                else 
                    Y <= '0';
                    NS <= ST1;
                end if;
            when others => -- Catch-All
                Y <= '0';
                NS <= ST0;
        end case;
    end process comb_proc;
end architecture;