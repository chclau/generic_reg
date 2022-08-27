----------------------------------------------------------------------------------
-- Company:  FPGA'er
-- Engineer: Claudio Avi Chami - FPGA'er Website
--           http://fpgaer.tech
-- Create Date: 27.08.2022 
-- Module Name: tb_reg.vhd
-- Description: testbench for generic register with load
--              
-- Dependencies: generic_reg.vhd
-- 
-- Revision: 1
-- Revision  1 - File Created
-- 
----------------------------------------------------------------------------------------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use std.textio.all;
    
entity tb_reg is
end entity;

architecture test of tb_reg is

    constant PERIOD  : time   := 20 ns;
    constant DATA_W  : natural := 4;
	
    signal clk       : std_logic := '0';
    signal rstn      : std_logic := '0';
    signal load      : std_logic := '0';
    signal data_in   : std_logic_vector (3 downto 0);
    signal endSim	 : boolean   := false;

  component generic_reg  is
    generic (
      DATA_W  : natural := 32
    );
    port (
      clk: 		  in std_logic;
      rstn: 		in std_logic;
      
      -- inputs
      data_in:	in std_logic_vector (DATA_W-1 downto 0);
      load: 		in std_logic;
      
      -- outputs
      data_out: 	out std_logic_vector (DATA_W-1 downto 0)
    );
  end component;
    

begin
    clk     <= not clk after PERIOD/2;
    rstn    <= '1' after  PERIOD*10;

	-- End the simulation
	process 
	begin
	
		wait until (rstn = '1');
		wait until (rising_edge(clk));

		data_in <= x"A";
		load	<= '1';
		wait until (rising_edge(clk));
		load	<= '0';
		wait until (rising_edge(clk));

		data_in <= x"5";
		load	<= '1';
		wait until (rising_edge(clk));
		load	<= '0';
		wait until (rising_edge(clk));
		wait until (rising_edge(clk));
		endSim  <= true;
	end	process;	
		
	-- End the simulation
	process 
	begin
		if (endSim) then
			assert false 
				report "End of simulation." 
				severity failure; 
		end if;
		wait until (rising_edge(clk));
	end process;	

  reg_inst : generic_reg
    generic map (	DATA_W	 => DATA_W )
    port map (
        clk      => clk,
        rstn	 => rstn,		
        data_in  => data_in,
        load     => load,	
        data_out => open
    );

end architecture;
