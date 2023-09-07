# Run with `nix-shell cuda-fhs.nix`
{ ... }:
let
    unstable = import <nixos> {
        config.allowUnfree = true; 
    };

    pkgs = import (builtins.fetchTarball {
        url = "https://nixos.org/channels/nixos-23.05";
        sha256 = "sha256:0znb7n2l7p1hd9mvwm4f5zmwzv1hq2q3cbsnsdscphivgdwh43ns";
    }) {
            inherit system pkgs;
            config.allowUnfree = true;
        };

    system = "x86_64-linux"; 
in
(pkgs.buildFHSUserEnv {
  name = "cuda-env";
  targetPkgs = pkgs: with pkgs; [ 
    fuse
  ];
  multiPkgs = pkgs: with pkgs; [ 
    zlib  
    xorg.libXext
  ];
  runScript = "bash";
}).env
