--

-- TITLE: 
   -- AND Port

-- DESCRIPTION:
   -- Introductory example by an AND operation to demonstrate 
   -- the basic structure of a VHDL program.
   
-- VERSION: 
   -- Author: Leonardo Godói (eng.leonardogodoi@gmail.com)
   -- Creation date: 13-February-2019

-- REVISION HISTORY:
   -- V1.0 | 13-February-2019 | Leonardo Godói | Creation

--

-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------

-- Importing libraries
library IEEE;                            
use IEEE.std_logic_1164.all;             

-- Setting entity
entity and_port is port                   -- Starting entity
(
	A : in std_logic;                     -- First input
	B : in std_logic;                     -- Second input
	O : out std_logic                     -- Output
);
end and_port;                             -- Ending entity

-- Setting architecture
architecture hardware of and_port is          -- Starting architecture
begin                                     

	O <= A and B;              -- Computing output as result of an AND operation

end hardware;                  -- ending architecture

-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
