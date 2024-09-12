{config, pkgs, ...}:  {
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
			theme = "afowler";
		};
  };

}
