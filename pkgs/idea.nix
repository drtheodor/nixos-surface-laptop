{ pkgs, ... }:

let
    mc-dependencies = with pkgs; [
        libpulseaudio
        libGL
        glfw3-minecraft
        openal
        flite
        (lib.getLib stdenv.cc.cc)
    ];
in
pkgs.symlinkJoin {
    name = "IntelliJ Minecraft Support";
    paths = [ pkgs.jetbrains.idea ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
        wrapProgram $out/bin/idea \
        --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath mc-dependencies}
    '';
}
