	component ISSP_SW is
		port (
			source : out std_logic_vector(9 downto 0);                    -- source
			probe  : in  std_logic_vector(9 downto 0) := (others => 'X')  -- probe
		);
	end component ISSP_SW;

	u0 : component ISSP_SW
		port map (
			source => CONNECTED_TO_source, -- sources.source
			probe  => CONNECTED_TO_probe   --  probes.probe
		);
