--
-- Decoder 2:4
--
-- Quick example of a decoder 2:4 including an enabling port.
--
-- Created by leonardo Franco de Godói
--

-- Importing libraries
library IEEE;
use IEEE.std_logic_1164.all;
	
-- Setting entity
entity decoder is port
(
	EN : in std_logic                                         -- Enabling input
	I : in std_logic_vector(1 downto 0);                      -- Input array (2 pins)
	O : out std_logic_vector(3 downto 0)                      -- Output array (4 pins)
);
end decoder;
	
-- Setting architecture
architecture decoding of simple_decoder is
begin
	
	process(I, EN)                                            -- Sequential part
	begin
		
		O <= "ZZZZ";                                      -- Initializes outputs with high impedance

		-- Once enabled, check and set outputs values 
		if(EN = '1') then
			case I is
				when "00" => O <= "0001";
				when "01" => O <= "0010";
				when "10" => O <= "0100";
				when "11" => O <= "1000";
				when others => O <= "0000";
			end case;
		end if;
			
	end process;
	
end decoding;
		
	
	
