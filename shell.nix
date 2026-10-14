# Environment for running Brain Workshop on NixOS. Used by the ./brainworkshop launcher.
{ pkgs ? import <nixpkgs> { } }:

let
  libs = with pkgs; [
    libglvnd
    libGLU
    libx11
    libxext
    libxrender
    libxrandr
    libxinerama
    libxi
    libxxf86vm
    openal
    libpulseaudio
    fontconfig
    freetype
  ];
in
pkgs.mkShell {
  packages = [ (pkgs.python3.withPackages (ps: [ ps.pyglet ])) ] ++ libs;
  # pyglet loads these via ctypes, so they must be on the runtime library path.
  LD_LIBRARY_PATH = "/run/opengl-driver/lib:" + pkgs.lib.makeLibraryPath libs;
}
