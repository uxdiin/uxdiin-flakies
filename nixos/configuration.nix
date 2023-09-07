# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: 

let
    extraHostsFile = ../dots/hosfile/hosts;
    extraHosts = builtins.readFile extraHostsFile;
    picom-animation = pkgs.callPackage ./git-packages/picom.nix { };
in {
    boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;

    services.xserver.videoDrivers = [ "nvidia" "intel" ];
    hardware.bluetooth.enable = true;
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
          vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
          vaapiVdpau
          libvdpau-va-gl
        ];
    };
    hardware.nvidia = {
    
        # Modesetting is needed most of the time
        modesetting.enable = true;
    
    	# Enable power management (do not disable this unless you have a reason to).
    	# Likely to cause problems on laptops and with screen tearing if disabled.
    	powerManagement.enable = true;
    
        # Use the open source version of the kernel module ("nouveau")
    	# Note that this offers much lower performance and does not
    	# support all the latest Nvidia GPU features.
    	# You most likely don't want this.
        # Only available on driver 515.43.04+
        open = false;
    
        # Enable the Nvidia settings menu,
    	# accessible via `nvidia-settings`.
        nvidiaSettings = true;
    
        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # hardware.nvidia.prime = {
	   #   offload = {
	   #   	enable = true;
	   #   	enableOffloadCmd = true;
	   #   };
        # reverseSync.enable = false;
        # sync.enable = true;

	     # Make sure to use the correct Bus ID values for your system!
	#      intelBusId = "PCI:0:2:0";
	#      nvidiaBusId = "PCI:1:0:0";
	# };

    nixpkgs.config.packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      };

    virtualisation = {
        podman = {
            enable = true;
    
            # Create a `docker` alias for podman, to use it as a drop-in replacement
            dockerCompat = true;
    
            # Required for containers under podman-compose to be able to talk to each other.
            # defaultNetwork.dnsname.enable = true;
            # For Nixos version > 22.11
            defaultNetwork.settings = {
              dns_enabled = true;
            };
        };
    };
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix 
            ./git-packages/nix-alien.nix
        ];
    
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    
    # boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    # boot.loader.grub.useOSProber = true;
    # boot.loader.grub.extraEntries = ''
    #   menuentry "windows 11" {
    #           insmod part_gpt
    #           insmod fat
    #           insmod chain
    #           search --no-floppy --fs-uuid --set=root CE28F1A828F18FA7
    #           chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    #       }
    # '';
    
    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    
    # Enable networking
    networking.networkmanager.enable = true;
    networking.extraHosts = ''
      ${extraHosts}
    '';
    
    # Set your time zone.
    time.timeZone = "Asia/Jakarta";
    
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "id_ID.UTF-8";
        LC_IDENTIFICATION = "id_ID.UTF-8";
        LC_MEASUREMENT = "id_ID.UTF-8";
        LC_MONETARY = "id_ID.UTF-8";
        LC_NAME = "id_ID.UTF-8";
        LC_NUMERIC = "id_ID.UTF-8";
        LC_PAPER = "id_ID.UTF-8";
        LC_TELEPHONE = "id_ID.UTF-8";
        LC_TIME = "id_ID.UTF-8";
    };
    
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.displayManager.startx.enable = true;
    
    # Enable the GNOME Desktop Environment.
    # services.xserver.desktopManager.gnome.enable = true;
    
    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "";
    };
    
    # Enable CUPS to print documents.
    services.printing.enable = true;
    
    # Enable sound with pipewire.
    sound.enable = true;
    # hardware.pulseaudio.enable = true;
    # hardware.pulseaudio.support32Bit = true;
    hardware.pulseaudio.extraConfig = "enable-lfe-remix = no flat-volumes = no";
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;
        
        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };
    
    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
    
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.uxdiin = {
        shell = pkgs.zsh;
        isNormalUser = true;
        description = "uxdiin";
        extraGroups = [ "networkmanager" "wheel" "libvirtd" "fuse" "trusted"  "audio"];
        packages = with pkgs; [
        ];
    };
    
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        picom-animation
      	wget
        wofi
        zsh
        git
        pulsemixer
        stable.podman
        stable.podman-compose
        stable.podman-tui
        cni-plugins
        brightnessctl
        postgresql
        ripgrep
        slurp
        grim
        wl-clipboard
        xclip
        postman
        lazygit
        dunst
        fzf
        pkgs.php82Packages.composer
        php
        openvpn
        openconnect
        home-manager
        xdg-desktop-portal 
        dbus-broker
        pulseaudio
        cargo
        busybox
        swww
        # build-essential
        pkgs.buildPackages.makeWrapper
        pkgs.buildPackages.stdenv
        pkgs.buildPackages.coreutils
        pkgs.buildPackages.findutils
        pkgs.buildPackages.gnumake
        pkgs.buildPackages.binutils
        libsForQt5.polkit-kde-agent
        parted
        ntfs3g
        os-prober
        grub2
        libvirt
        nix-index
        lshw
        intel-gpu-tools
        cudatoolkit
        cudaPackages.cudnn
        pkg-config
        openblas
        nixos-option
        outils
        libva-utils
        bspwm
        sxhkd
        arandr
        scrot
     #    xorg.xf86inputevdev
	    # xorg.xf86videointel
	    # xorg.xf86inputsynaptics
	    # xorg.xorgserver
        jdk8
        javaPackages.openjfx11
        jdk8
        jre8
        jre8
        jdk11
        xorg.xmodmap
    ];
      
    security.polkit.enable = true;
    virtualisation.libvirtd.enable = true;
    programs.nix-ld.enable = true;
    programs.ssh.startAgent = true;
      
    systemd = {
      user.services.polkit-kde-authentication-agent-1 = {
        description = "polkit-kde-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
      };
    };
    
      systemd.services.libvirtd-config.script = lib.mkAfter ''
          # mkdir -p /var/lib/libvirt/qemu/networks/autostart;
          # ln -s /var/lib/libvirt/qemu/networks/default.xml /var/lib/libvirt/qemu/networks/autostart
      '';
    
    programs.zsh.enable = true;
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    
    # List services that you want to enable:
    
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
    
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
    
    # Enable Flakes
    nix.package = pkgs.nixFlakes;
    nix.extraOptions = ''
      experimental-features = nix-command flakes
      '';
    
}
