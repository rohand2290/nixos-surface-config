{config, pkgs, ...}:  {
	programs.i3status = {
		enable = true;
		general = {
			colors = true;
			color_good = "#98971a";
			color_degraded = "#d79921";
			color_bad = "#cc241d";
		};
	};
}
