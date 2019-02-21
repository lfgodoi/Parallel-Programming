--
-- AND port
--
-- Introductory example by an AND operation to demonstrate the basic structure of a VHDL program.
--
-- Created by leonardo Franco de Godói
--

    -- Importing libraries
    library IEE;                            
    use IEE.std_logic_1164.all;             
  
    -- Setting entity
    entity my_and is port                     -- Starting entity
    (
        A : in std_logic;                     -- First input
	B : in std_logic;                     -- Second input
        O : out std_logic                     -- Output
    );
    end my_and;                               -- Ending entity
  
    -- Setting architecture
    architecture hardware of my_and is        -- Starting architecture
    begin                                     
  
        O <= A and B;                         -- Computing output
  
    end hardware;                             -- ending architecture

