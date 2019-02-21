--
-- MUX 4:1
--
-- Simple multiplexer containing 4 inputs, 1 output and 2 selectors.
--
-- S0   S1     O
-- ---------------
-- 0     0     I0
-- 0     1     I1
-- 1     0     I2
-- 1     1     I3
--
-- Created by leonardo Franco de Godói
--

    -- Importing libraries
    library IEEE;
    use IEE.std_logic_1164.all;
	
    -- Setting entity
    entity mux is port
    (
	S : in std_logic_vector(1 downto 0);                          -- Selector array (2 pins)
	I : in std_logic_vector(3 downto 0);                          -- Input array (4 pins)
	O : out std_logic                                             -- Output
    );
    end mux;
	
    -- Setting architecture
    architecture multiplexing of mux_4_to_1 is
    begin
	    
        -- Setting a value for output depending on selectors state
	with S select
	    O <= I(0) when "00",
                 I(1) when "01",
                 I(2) when "10",
                 I(3) when "11",
                 '0' when others;			 
	
    end multiplexing;
