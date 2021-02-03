	component ISSP_KEY is
		port (
			source : out std_logic_vector(2 downto 0);                    -- source
			probe  : in  std_logic_vector(2 downto 0) := (others => 'X')  -- probe
		);
	end component ISSP_KEY;

	u0 : component ISSP_KEY
		port map (
			source => CONNECTED_TO_source, -- sources.source
			probe  => CONNECTED_TO_probe   --  probes.probe
		);

