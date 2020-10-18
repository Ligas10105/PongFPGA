-- PongFPGA.vhd

-- Generated using ACDS version 18.1 625

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PongFPGA is
	port (
		clk_clk          : in  std_logic                    := '0'; --   clk.clk
		hdmi_output_clk  : out std_logic;                           --  hdmi.output_clk
		hdmi_output_data : out std_logic_vector(2 downto 0);        --      .output_data
		reset_reset_n    : in  std_logic                    := '0'  -- reset.reset_n
	);
end entity PongFPGA;

architecture rtl of PongFPGA is
	component HDMIDriver is
		generic (
			DISPLAY_RES_WIDTH  : integer := 640;
			DISPLAY_RES_HEIGHT : integer := 480;
			PX_FRONT_PORCH     : integer := 16;
			PX_SYNC_PULSE      : integer := 96;
			PX_BACK_PORCH      : integer := 48;
			ROW_FRONT_PORCH    : integer := 10;
			ROW_SYNC_PULSE     : integer := 2;
			ROW_BACK_PORCH     : integer := 33
		);
		port (
			clk         : in  std_logic                     := 'X'; -- clk
			HDMI_clk    : in  std_logic                     := 'X'; -- clk
			px_x        : out std_logic_vector(12 downto 0);        -- px_x
			px_y        : out std_logic_vector(12 downto 0);        -- px_y
			output_clk  : out std_logic;                            -- output_clk
			output_data : out std_logic_vector(2 downto 0);         -- output_data
			px_color    : in  std_logic                     := 'X'  -- px_color
		);
	end component HDMIDriver;

	component HDMIImageGenerator is
		generic (
			X_RES   : integer := 1080;
			Y_RES   : integer := 1920;
			REG_LEN : integer := 200;
			VEL     : integer := 10
		);
		port (
			clk      : in  std_logic                     := 'X';             -- clk
			px_x     : in  std_logic_vector(12 downto 0) := (others => 'X'); -- px_x
			px_y     : in  std_logic_vector(12 downto 0) := (others => 'X'); -- px_y
			px_color : out std_logic                                         -- px_color
		);
	end component HDMIImageGenerator;

	signal hdmidriver_mono_1b_0_px_address_px_x       : std_logic_vector(12 downto 0); -- HDMIDriver_mono_1b_0:px_x -> HDMI_IMAGE_GEN_MONO_1b_0:px_x
	signal hdmidriver_mono_1b_0_px_address_px_y       : std_logic_vector(12 downto 0); -- HDMIDriver_mono_1b_0:px_y -> HDMI_IMAGE_GEN_MONO_1b_0:px_y
	signal hdmi_image_gen_mono_1b_0_px_color_px_color : std_logic;                     -- HDMI_IMAGE_GEN_MONO_1b_0:px_color -> HDMIDriver_mono_1b_0:px_color

begin

	hdmidriver_mono_1b_0 : component HDMIDriver
		generic map (
			DISPLAY_RES_WIDTH  => 640,
			DISPLAY_RES_HEIGHT => 480,
			PX_FRONT_PORCH     => 16,
			PX_SYNC_PULSE      => 96,
			PX_BACK_PORCH      => 48,
			ROW_FRONT_PORCH    => 10,
			ROW_SYNC_PULSE     => 2,
			ROW_BACK_PORCH     => 33
		)
		port map (
			clk         => clk_clk,                                    --      clock.clk
			HDMI_clk    => clk_clk,                                    -- clock_hdmi.clk
			px_x        => hdmidriver_mono_1b_0_px_address_px_x,       -- px_address.px_x
			px_y        => hdmidriver_mono_1b_0_px_address_px_y,       --           .px_y
			output_clk  => hdmi_output_clk,                            --       hdmi.output_clk
			output_data => hdmi_output_data,                           --           .output_data
			px_color    => hdmi_image_gen_mono_1b_0_px_color_px_color  --   px_color.px_color
		);

	hdmi_image_gen_mono_1b_0 : component HDMIImageGenerator
		generic map (
			X_RES   => 640,
			Y_RES   => 480,
			REG_LEN => 200,
			VEL     => 10
		)
		port map (
			clk      => clk_clk,                                    --      clock.clk
			px_x     => hdmidriver_mono_1b_0_px_address_px_x,       -- px_address.px_x
			px_y     => hdmidriver_mono_1b_0_px_address_px_y,       --           .px_y
			px_color => hdmi_image_gen_mono_1b_0_px_color_px_color  --   px_color.px_color
		);

end architecture rtl; -- of PongFPGA
