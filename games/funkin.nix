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
let
  spooky = fetchurl {
    url = "https://gamebanana.com/dl/1673052";
    hash = "sha256-aoK7forucSwsbu6DwQfy1Zu00w6CUm2G2I2RdFA4zH4=";
  };
  qt-rewired = fetchurl {
    url = "https://gamebanana.com/dl/1665441";
    hash = "sha256-AiDgGXgWgPF5wuKj1VY+0+79ng3UPWvlZpr8tP4Owp0=";
  };
in
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
    mkdir -p $out/mods
    unzip -d $out/mods/ ${spooky}
    unzip -d $out/mods/qt-rewired ${qt-rewired}
  '';

  installPhase = ''
    mkdir -p $out/bin
    echo "#!/usr/bin/env bash
    cd $out && ./Funkin" > $out/bin/funkin
    chmod +x $out/bin/funkin
  '';
}
