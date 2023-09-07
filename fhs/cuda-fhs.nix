# Run with `nix-shell cuda-fhs.nix`
{ pkgs? import <nixpkgs> {}, ... }:
let
    pkgs = import <nixpkgs> { 
        config.allowUnfree = true; 
    };
    # unstable = import <nixos> {
    #     config.allowUnfree = true; 
    # };
    #
    # pkgs = import (builtins.fetchTarball {
    #     url = "https://nixos.org/channels/nixos-23.05";
    #     sha256 = "sha256:0znb7n2l7p1hd9mvwm4f5zmwzv1hq2q3cbsnsdscphivgdwh43ns";
    # }) {
    #         inherit system pkgs;
    #         config.allowUnfree = true;
    #     };
    #
    # system = "x86_64-linux"; 
in
(pkgs.buildFHSUserEnv {
  name = "cuda-env";
  targetPkgs = pkgs: with pkgs; [ 
    git
    gitRepo
    gnupg
    autoconf
    curl
    procps
    gnumake
    util-linux
    m4
    gperf
    unzip
    cudatoolkit
    cudaPackages.cudnn
    linuxPackages.nvidia_x11
    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 
    ncurses5
    stdenv.cc
    binutils
    vscode
    fuse
    openjdk8-bootstrap
    jdk11
  ];

  multiPkgs = pkgs: with pkgs; [ zlib ];
  runScript = "bash";
  profile = ''
    export CUDA_PATH=${pkgs.cudatoolkit}
    export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib:CUDA_PATH
    export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
    export EXTRA_CCFLAGS="-I/usr/include"
    export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CUDA_PATH
  '';
}).env
