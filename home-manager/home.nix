{ config, pkgs, inputs, lib, ... }:

{
    home.username = "uxdiin";
    home.homeDirectory = "/home/uxdiin";
    home.stateVersion = "22.11";
    nixpkgs = {
	  	config = {
	  		allowUnfree = true;
	  		allowUnfreePredicate = (_: true);
	  	};
	  };

    nixpkgs.overlays = [
        (self: super: {
            waybar = super.waybar.overrideAttrs (oldAttrs: {
                mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            });
        })
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
        bat
        fzf
        ripgrep
        jq
        tree
        exa
        firefox
        eww-wayland
        htop
        brave
        tdesktop
        neovide
        rocketchat-desktop
        yarn
        postgresql_15
        pywal
        neofetch
        pfetch
        ranger
        waybar
        gparted
        globalprotect-openconnect
        libnotify
	  ];

    xdg.configFile."kitty".source = ../dots/kitty;
    xdg.configFile."nvim".source = ../dots/nvim;
    xdg.configFile."waybar".source = ../dots/waybar;

    programs.neovim = {
  	    enable = true;
  	    viAlias = true;
        vimAlias = true;
  	};

    home.sessionVariables = {
		EDITOR="nvim";
	};

	programs.zsh = {
		enable = true;
        initExtra = ''
            # Additional configuration for .zshrc
            source "$HOME/flakies/dots/zsh/.zshrc"
          '';
	};

	programs.zsh.oh-my-zsh= {
	  enable = true;
	  plugins = ["git" "python" "docker" "fzf"];
	};    


}
