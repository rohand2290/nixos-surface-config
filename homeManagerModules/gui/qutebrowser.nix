{config, pkgs, ...}: {
	programs.qutebrowser = {
		enable = true;
		quickmarks = {
			nixpkgs = "https://search.nixos.org/packages";
			home-manager = "https://nix-community.github.io/home-manager/options.xhtml";
		};
		settings = {
			colors = {
				webpage.preferred_color_scheme = "dark";
			};
			content.blocking.method = "adblock";
		};
	};
}
