{ config, pkgs, inputs, lib, system ? builtins.currentSystem, ... }:
let
    stable = import (builtins.fetchTarball {
        url = "https://nixos.org/channels/nixos-23.05";
        sha256 = "sha256:0znb7n2l7p1hd9mvwm4f5zmwzv1hq2q3cbsnsdscphivgdwh43ns";
    }) {
            inherit system pkgs;
        };
    system = "x86_64-linux"; 
in
{
    home.username = "uxdiin";
    home.homeDirectory = "/home/uxdiin";
    home.stateVersion = "23.05";
    nixpkgs.config = {
        # packageOverrides = pkgs: {
        #     inherit (import <nixpkgs> {
        #         config = { 
        #             allowUnfree = true; 
	  	    # 	    allowUnfreePredicate = (_: true);
        #         };
        #     });
        # unstable = import <nixpkgs> { config.allowUnfree = true; };
	  	# config = {
	  		allowUnfree = true;
	  		allowUnfreePredicate = (_: true);
	  	# };
	  # };
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
        stable.brave
        tdesktop
        neovide
        rocketchat-desktop
        yarn
        nodejs
        vite
        postgresql_15
        pywal
        neofetch
        pfetch
        ranger
        waybar
        gparted
        globalprotect-openconnect
        libnotify
        feh
        rofi
        cliphist
        virt-manager
        # qemu_full
        # qemu-utils
        qemu
        qemu_kvm
        python311Packages.libvirt
        python3Full
        steam-run
        mpvpaper
        mpv
        cava
        spotify
        minikube
        kubectl
        vscode
        gnupg
        dragon
        libreoffice-qt
        kitty
        outils
        zip
        unzip
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
