----------------------------------------------------------------------------------
-- Company:  FPGA'er
-- Engineer: Claudio Avi Chami - FPGA'er Website
--           http://fpgaer.tech
-- Create Date: 25.09.2022 
-- Module Name: generic_reg.vhd
-- Description: generic register with load
--              
-- Dependencies: generic_reg.vhd
-- 
-- Revision: 3
-- Revision  3 - Using unconstrained signals in place of generics, added unconstrained signal normalization
-- 
----------------------------------------------------------------------------------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;

entity generic_reg is
  port (
    rstn      : in  std_logic;
    clk       : in  std_logic; 

    -- inputs
    data_in   : in  std_logic_vector;
    load      : in  std_logic; 
    
    -- outputs
    data_out  : out std_logic_vector
    
  );
end entity;

architecture rtl of generic_reg is
  -- normalize the unconstrained input
  alias data_in_norm : std_logic_vector(data_in'length - 1 downto 0) is data_in; -- normalized unconstrained input
begin
  
  reg_pr : process (clk) 
	begin
    if (rising_edge(clk)) then
      if (rstn = '0') then
        data_out <= (others=>'0');
      elsif (load = '1') then
        data_out <= data_in_norm;
      end if;
    end if;
  end process reg_pr;
  
end architecture;
