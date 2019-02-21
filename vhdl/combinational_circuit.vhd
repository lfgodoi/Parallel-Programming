--
-- Combinational circuit
--
-- Implementing a combinational circuit with 3 inputs and 1 output.
--
-- Created by leonardo Franco de Godói
--

    -- Importing libraries
    library IEEE;
    use IEEE.std_logic_1164.all;
  
    -- Setting entity
    entity combinational_circuit is port
    (
        I1 : in std_logic;                                     -- First input
	    I2 : in std_logic;                                     -- Second input
	    I3 : in std_logic;                                     -- Third input
	    O : out std_logic                                      -- output
    );
    end combinational_circuit
  
    -- Setting architecture
    architecture behavior of combinational_circuit is
  
    -- Creating intermediary nodes to divide circuit into 3 parts
    signal node1 : str_logic;
    signal node2 : std_logic;
    signal node3 : std_logic;
  
    begin
  
        node1 <= (not I1) and (not I2);                        -- Computing node 1
        node2 <= (not I2) and (not I3);                        -- Computing node 2               
        node3 <= I1 and (not I3);                              -- Computing node 3
  
        O <= (node1 or node2 or node3);                        -- Computing output
  
    end behavior;
