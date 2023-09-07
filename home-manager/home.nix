{ config, pkgs, inputs, lib, system ? builtins.currentSystem, ... }:
let
in
{
    home.username = "uxdiin";
    home.homeDirectory = "/home/uxdiin";
    home.stateVersion = "23.05";
    nixpkgs.config = {
	  	allowUnfree = true;
	  	allowUnfreePredicate = (_: true);
        permittedInsecurePackages = [
            "electron-14.2.9"
        ];
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
        haskellPackages.greenclip
        virt-manager
        # qemu_full
        # qemu-utils
        qemu
        qemu_kvm
        # python310Packages.pillow
        python311Packages.libvirt
        # python3Full
        (python3.withPackages(ps: with ps; [ selenium pillow pandas openpyxl requests]))
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
        ark
        python3Packages.selenium
        stable.discord
        emscripten
        gcc
        geogebra6
        chromium
        atlauncher
	  ];
    
   xdg.enable = true;

    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/flakies/dots/nvim";
    xdg.configFile."bspwm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/flakies/dots/bspwm";
    xdg.configFile."sxhkd".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/flakies/dots/sxhkd";

    home.file.".config/kitty".source = ../dots/kitty;
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
    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "application/json" = ["nvim"];
      };
      defaultApplications = {
        "application/json" = ["nvim"];
      };
    };

}
