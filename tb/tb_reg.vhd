------------------------------------------------------------------
-- Name		     : tb_reg.vhd
-- Description : Testbench for reg.vhd
-- Designed by : Claudio Avi Chami - FPGA'er  website
--               fpgaer.wordpress.com 
-- Date        : 26/03/2016
-- Version     : 01
------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use std.textio.all;
    
entity tb_reg is
end entity;

architecture test of tb_reg is

  constant PERIOD  : time   := 20 ns;
  constant DATA_W  : natural := 4;
	
  signal clk       : std_logic := '0';
  signal rst       : std_logic := '1';
  signal load      : std_logic := '0';
  signal data_in   : std_logic_vector (3 downto 0);
  signal endSim	 : boolean   := false;

  component reg  is
	generic (
		DATA_W		: natural := 32
	);
	port (
		clk: 		in std_logic;
		rst: 		in std_logic;
		
		-- inputs
		data_in:	in std_logic_vector (DATA_W-1 downto 0);
		load: 		in std_logic;
		
		-- outputs
		data_out: 	out std_logic_vector (DATA_W-1 downto 0)
	);
  end component;
    

begin
    clk     <= not clk after PERIOD/2;
    rst     <= '0' after  PERIOD*10;

	-- End the simulation
	process 
	begin
	
		wait until (rst = '0');
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

  reg_inst : reg
  generic map ( DATA_W	 => DATA_W	)
  port map (
    clk      => clk,
    rst	     => rst,
		
    data_in  => data_in,
    load     => load,
		
    data_out => open
  );

end architecture;
