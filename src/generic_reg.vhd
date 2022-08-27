----------------------------------------------------------------------------------
-- Company:  FPGA'er
-- Engineer: Claudio Avi Chami - FPGA'er Website
--           http://fpgaer.tech
-- Create Date: 21.08.2022 
-- Module Name: generic_reg.vhd
-- Description: Generic parallel register with load
--              
-- Dependencies: None
-- 
-- Revision: 1
-- Revision  1 - File Created
-- 
----------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

entity generic_reg is
  generic ( DATA_W  : natural := 32);
  port (
    rstn      : in  std_logic;
    clk       : in  std_logic; 

    -- inputs
    data_in   : in  std_logic_vector(DATA_W-1 downto 0);
    load      : in  std_logic; 
    
    -- outputs
    data_out  : out std_logic_vector(DATA_W-1 downto 0)
    
  );
end entity;

architecture rtl of generic_reg is

begin

  reg_pr : process (clk) 
	begin
    if (rising_edge(clk)) then
      if (rstn = '0') then
        data_out <= (others=>'0');
      elsif (load = '1') then
        data_out <= data_in;
      end if;
    end if;
  end process reg_pr;
  
end architecture;
