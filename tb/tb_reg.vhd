----------------------------------------------------------------------------------
-- Company:  FPGA'er
-- Engineer: Claudio Avi Chami - FPGA'er Website
--           http://fpgaer.tech
-- Create Date: 25.09.2022 
-- Module Name: tb_reg.vhd
-- Description: testbench for generic register with load
--              
-- Dependencies: generic_reg.vhd
-- 
-- Revision: 2
-- Revision  2 - Changes to support unconstrained data port on DUT
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
    signal data_in1  : std_logic_vector (3 downto 0);
    signal data_out1 : std_logic_vector (data_in1'range);
    signal data_in2  : std_logic_vector (7 downto 0);
    signal data_out2 : std_logic_vector (data_in2'range);
    signal data_in3  : std_logic_vector (31 downto 28);
    signal data_out3 : std_logic_vector(data_in3'length-1 downto 0);
    signal endSim	 : boolean   := false;

  component generic_reg  is
    port (
      clk: 		  in std_logic;
      rstn: 		in std_logic;
      
      -- inputs
      data_in:	in std_logic_vector;
      load: 		in std_logic;
      
      -- outputs
      data_out: 	out std_logic_vector
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

		data_in1 <= x"A";
		data_in2 <= x"7C";
		data_in3 <= x"3";
		load	<= '1';
		wait until (rising_edge(clk));
		load	<= '0';
		wait until (rising_edge(clk));

		data_in1 <= x"5";
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

  reg_inst1 : generic_reg
    port map (
        clk      => clk,
        rstn	   => rstn,		
        data_in  => data_in1,
        load     => load,	
        data_out => data_out1
    );
    
  reg_inst2 : generic_reg
    port map (
        clk      => clk,
        rstn	   => rstn,		
        data_in  => data_in2,
        load     => load,	
        data_out => data_out2
    );
    
  reg_inst3 : generic_reg
    port map (
        clk      => clk,
        rstn	   => rstn,		
        data_in  => data_in3,
        load     => load,	
        data_out => data_out3
    );

end architecture;