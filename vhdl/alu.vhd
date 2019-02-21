--
-- ALU (Arithmetic and Logic Unit)
--
-- Quick example of an ALU with 7 operations, 1 impedance state and 3 selectors.
--
-- Created by leonardo Franco de Godói
--

    -- Importing libraries
    library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.std_logic_unsigned.all;
	
    -- Setting entity
    entity alu is port
    (
        A, B      : in std_logic_vector(3 downto 0);                   -- Input array (4 pins)
	O         : out std_logic_vector(3 downto 0);                  -- Output array (4 pins)
	selection : in std_logic_vector(2 downto 0)                    -- Selector array (3 pins)
    );
    end alu;
	
    -- Setting architecture
    architecture operations of alu is
    begin
	
    process(A, B, selection)                                           -- Sequential part
    begin
	
	-- Computing output according to selectors state
	case selection is
	    when "000" => 0 <= A + B;
	    when "001" => 0 <= A - B;
	    when "010" => 0 <= A AND B;
	    when "011" => 0 <= A OR B;
	    when "100" => 0 <= A XOR B;
	    when "101" => 0 <= not A;
	    when "110" => 0 <= not B;
	    when "111" => 0 <= "ZZZZ";
		end case;
	end process;
	
	end operations;
	
