{ pkgs, ... }:

let
    nix-alien-pkgs = import (
      builtins.fetchTarball {
          url = "https://github.com/thiagokokada/nix-alien/tarball/master";
          sha256 = "sha256:0x8r0f04kc80y99gq0014b06mcmjcrfad4snmnbambbpmrgva6ap";
          }
    ) {inherit pkgs;};
in  
{
  environment.systemPackages = with nix-alien-pkgs; [
    nix-alien
  ];
}
