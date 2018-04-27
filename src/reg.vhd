------------------------------------------------------------------
-- Name		     : reg.vhd
-- Description : Generic register with load
-- Designed by : Claudio Avi Chami - FPGA'er website
--               fpgaer.wordpress.com
-- Date        : 26/03/2016
-- Version     : 01
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity reg is
	generic (
		DATA_W		: natural := 32
	);
	port (
		clk: 		  in std_logic;
		rst: 		  in std_logic;
		
		-- inputs
		data_in:	in std_logic_vector (DATA_W-1 downto 0);
		load: 		in std_logic;
		
		-- outputs
		data_out: 	out std_logic_vector (DATA_W-1 downto 0)
	);
end reg;


architecture rtl of reg is

begin 

reg_pr: process (clk, rst) 
begin 
  if (rst = '1') then 
    data_out 	<= (others => '0');
  elsif (rising_edge(clk)) then	
    if (load = '1') then				
      data_out	<= data_in;
		end if;			
  end if;
end process;

end rtl;