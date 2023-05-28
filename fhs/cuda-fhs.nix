# Run with `nix-shell cuda-fhs.nix`
{ pkgs ? import <nixpkgs> {} }:
let
    pkgs = import <nixpkgs> { 
        config.allowUnfree = true; 
    };
    # unstable = import <nixos> {
    #     config.allowUnfree = true; 
    # };
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
    linuxPackages.nvidia_x11
    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 
    ncurses5
    stdenv.cc
    binutils
    vscode
  ];
  multiPkgs = pkgs: with pkgs; [ zlib ];
  runScript = "bash";
  profile = ''
    export CUDA_PATH=${pkgs.cudatoolkit}
    export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib
    export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
    export EXTRA_CCFLAGS="-I/usr/include"
    export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CUDA_PATH
  '';
}).env
