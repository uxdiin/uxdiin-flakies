{ fetchgit, lib, stdenv, pkgs,  ... }:

stdenv.mkDerivation {
  name = "picom-animation";
  src = fetchgit {
    url = "https://github.com/pijulius/picom.git";
    rev = "982bb43";
    sha256 = "sha256-YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";  # Add the SHA256 hash of the source tarball.
  };

  nativeBuildInputs = with pkgs;[
    asciidoc
    docbook_xml_dtd_45
    docbook_xsl
    makeWrapper
    meson
    ninja
    pkg-config
    uthash
  ];

  buildInputs = with pkgs; [ 
    dbus
    libconfig
    libdrm
    libev
    libGL
    xorg.libX11
    xorg.libxcb
    libxdg_basedir
    xorg.libXext
    xorg.libXinerama
    libxml2
    libxslt
    pcre
    pixman
    xorg.xcbutilimage
    xorg.xcbutilrenderutil
    xorg.xorgproto
  ];  # Add necessary build dependencies.
  phases = ["buildPhase" "installPhase" ];
  buildPhase = ''
     cd $src
     # ls
     # git submodule update --init --recursive
     mkdir -p $out/build
     meson --buildtype=release . $out/build
     ninja -C $out/build
  '';
  installPhase = ''
    meson configure -Dprefix=$out $out/build
    ninja -C $out/build install
  '';
}
