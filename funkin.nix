{
  fetchurl,
  stdenv,
  libglvnd,
  libX11,
  libXext,
  libXinerama,
  libXi,
  libXrandr,
  libvlc,
  sdl3,
  pulseaudio,
  alsa-lib,
  unzip,
  autoPatchelfHook,
}:

stdenv.mkDerivation {
  name = "Funkin";
  version = "0.8.4";

  src = fetchurl {
    url = "https://github.com/FunkinCrew/Funkin/releases/download/v0.8.4/funkin-linux-64bit.zip";
    hash = "sha256-UOswyJ3gOm7zRDG7dZMCGbiXrrtZ5FahaSR9iwpBQyE=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    unzip
  ];
  buildInputs = [
    libglvnd
    libX11
    libXext
    libXinerama
    libXi
    libXrandr
    pulseaudio
    alsa-lib
    libvlc
    sdl3
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libGLES_CM.so"
    "libsteam_api.so"
  ];
  unpackPhase = ''
    unzip -d $out $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/mods
    echo "#!/usr/bin/env bash
    cd $out && ./Funkin" > $out/bin/funkin
    chmod +x $out/bin/funkin
  '';
}
