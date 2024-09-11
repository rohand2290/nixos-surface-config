{ config, pkgs, lib, ... }:

{
  imports = [
	./../../homeManagerModules/nixvim.nix
	./../../homeManagerModules/gui/alacritty.nix
	./../../homeManagerModules/gui/zathura.nix
	./../../homeManagerModules/gui/qutebrowser.nix
	./../../homeManagerModules/htop.nix
	./../../homeManagerModules/lf.nix
	./../../homeManagerModules/pandoc.nix
	./../../homeManagerModules/bat.nix
	./../../homeManagerModules/i3status.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rohand";
  home.homeDirectory = "/home/rohand";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
  	autotiling
	fastfetch
	nix-tree
	sway-contrib.grimshot
	runelite
#	(discord.override {
#		withOpenASAR = true;
#		withVencord = true;
#	})
	obsidian
	vesktop
	texlive.combined.scheme-basic
  ];


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.zsh = {
  	enable = true;
	enableSyntaxHighlighting = true;
	loginExtra = "sway --unsupported-gpu";
	shellAliases = {
		"update" = "sudo nixos-rebuild switch --flake /home/rohand/nixos-surface-config#xps";
	};
	oh-my-zsh = {
		enable = true;
		plugins = ["git" "vi-mode"];
		theme = "minimal";
	};
  };
  #programs.alacritty = {
  #	enable = true;
  #};
  programs.bemenu = {
  	enable = true;
  };
  programs.ranger = {
  	enable = true;
  };
  programs.helix.enable = true;
  wayland.windowManager.sway = {
  	enable = true;
	config = rec {
		modifier = "Mod4";
		menu = "bemenu-run";
		gaps = {
			inner = 10;
			outer = 4;
			smartGaps = false;
		};
		terminal = "alacritty";
		window.titlebar = false;
		startup = [
			{command = "autotiling";}
		];
		keybindings = 
			let
				modifier = config.wayland.windowManager.sway.config.modifier;
				searchConfig = pkgs.writeShellApplication {
					name = "searchConfig";
					text = ''
						find /home/rohand/nixos-surface-config \( ! -regex './\..*' \) -type f \
							| bemenu -p "Edit which config file?" \
							| xargs alacritty -e nvim \
					 '';
				};
			in lib.mkOptionDefault {
				"${modifier}+n" = "exec ${lib.getExe searchConfig}" ;
				"${modifier}+Shift+r" = "exec alacritty -e lf";
				"${modifier}+q" = "kill";
				"${modifier}+Shift+n" = "exec alacritty -e nvim -c VimwikiIndex";
				"Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save area";

			};
		bars = [
			({
				mode = "dock";
				hiddenState = "hide";
				position = "top";
				workspaceButtons = true;
				workspaceNumbers = false;
				statusCommand = "i3status";
				trayOutput = "primary";
			} // config.lib.stylix.sway.bar)
		];
	};
  };

  home.sessionVariables = {
  	OPENER = "rifle";
	EDITOR = "nvim";
	_JAVA_AWT_WM_NONREPARENTING = 1;
#	MANPAGER = "sh -c 'col -bx | bat -l man -p'";
	MANPAGER = "nvim +Man!";
	# MANROFFOPT = "-c";
  };
}

