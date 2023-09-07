{ pkgs, ... }:

let
    nix-alien-pkgs = import (
      builtins.fetchTarball {
          url = "https://github.com/thiagokokada/nix-alien/tarball/master";
          sha256 = "sha256:1q1l0jzrq6ssc21ra6gvj5k01qn49cmd3403g0j05jvqhfkvs4z0";
          }
    ) {inherit pkgs;};
in  
{
  environment.systemPackages = with nix-alien-pkgs; [
    nix-alien
  ];
}
