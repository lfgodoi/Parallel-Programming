--
-- State Machine
--
-- Moore's state machine containing 4 states.
--
-- Created by leonardo Franco de Godói
--

    -- Importing libraries
    library IEEE;
	use IEEE.std_logic_1164.all;
	
	-- Setting entity
	entity state_machine is port
	(
        clk     : in bit;                         -- Rising edge clock
		rst     : in bit;                         -- Used to reset state machine
		state   : inout bit_vector(1 downto 0);   -- Vector of size 2
	);
	end state_machine;
	
	-- Setting architecture
	architecture behavior of state_machine is
	begin
	
	    -- Process describing state machine behavior
        my_process : process(clk,rst)
		begin 
		    if(rst = '1') then q <= "00";              -- If resetting, go to the first state
			elsif(clk'event and clk = '1') then        -- Otherwise, wait for clock rising edge event to change state
			    case q is
				    when "00" => q <= "01";
					when "01" => q <= "11";
					when "11" => q <= "10";
					when "10" => q <= "00";
				end case;
			end if;
		end process my_process;
		
	end hardware;