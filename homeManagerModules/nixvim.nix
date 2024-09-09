{config, pkgs, ...}: {
	programs.nixvim = {
		enable = true;
		globals.mapleader = ",";
		colorschemes.gruvbox.enable = true;
		clipboard.providers.wl-copy = {
			enable = true;
		};
		plugins = {
			bufferline.enable = true;
			lualine.enable = true;
			lsp = {
				enable = true;
      				servers = {
       					tsserver.enable = true;
        				lua-ls = {
          					enable = true;
          					settings.telemetry.enable = false;
        				};
        				rust-analyzer = {
          					enable = true;
          					installCargo = true;
        				};
      				};
			};
			telescope.enable = true;
			oil.enable = true;
			treesitter.enable = true;
			luasnip.enable = true;
			nvim-autopairs.enable = true;
			nvim-tree.enable = true;
			which-key = {
				enable = true;
			};
		#	nvim-cmp = {
		#		enable = true;
		#		autoEnableSources = true;
		#		sources = [
		#			{name = "nvim_lsp";}
		#			{name = "path";}
		#			{name = "buffer";}
		#			{name = "luasnip";}
		#		];
		#		mapping = {
		#			"<CR>" = "cmp.mapping.confirm({select = true})";
		#			"<Tab>" = {
		#				action = ''
		#					function(fallback)
		#						if cmp.visible() then
		#							cmp.select_next_item()
		#						elseif luasnip.expandable() then
		#							luasnip.expand()
		#						elseif luasnip.expand_or_jumpable() then
		#							luasnip.expand_or_jump()
		#						elseif check_backspace() then
		#							fallback()
		#						else
		#							fallback()
		#						end
		#					end
		#				'';
		#				modes = ["i" "s"];
		#			};
		#		};
		#	};
		};
		extraPlugins = with pkgs.vimPlugins; [
			vimwiki
			calendar-vim
		];
		extraConfigVim = ''
			let g:vimwiki_list = [{"path": "~/rohandobsidian/", "syntax": "markdown", "ext": ".md"}]
		'';
	};
}
