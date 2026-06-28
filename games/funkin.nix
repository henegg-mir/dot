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
  unrar,
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
  shootin = fetchurl {
    url = "https://gamebanana.com/dl/1689702";
    hash = "sha256-LB7E4ZYiY0PxPLknikaQZECUeXryEy6VAw5T9KnRy3w=";
  };
  nene = fetchurl {
    url = "https://gamebanana.com/dl/1659725";
    hash = "sha256-tIU981sb1qrW/Mtrej5AUBFqA6gSmzOIptXJEYdhaqA=";
  };
  hazy = fetchurl {
    url = "https://gamebanana.com/dl/1699716";
    hash = "sha256-mdsO838Bc+I1Nc0YqHDMx1J40elQ9dtKz/ouzhVsq+0=";
  };
  tricky = fetchurl {
    url = "https://gamebanana.com/dl/1706935";
    hash = "sha256-94j8PSSDVHpSxQXEooQE2HOZ3YkI5vp3sbmAiRFAcn4=";
  };
  miku = fetchurl {
    url = "https://gamebanana.com/dl/1717118";
    hash = "sha256-HwzRvGiP+PXxyIdrt0nLDhMsBaILQ7nsKgIFfKZ3miw=";
  };
  philly = fetchurl {
    url = "https://gamebanana.com/dl/1714715";
    hash = "sha256-3OeFXj9Yf9aIlZUhN0kE7ZBqEfLA2lEGDNLtXDm38fc=";
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
    unrar
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
    mkdir -p $out/mods/nene
    unrar x -xshits/ -y ${nene} $out/mods/nene
    unzip -d $out/mods/ ${spooky}
    unzip -d $out/mods/qt-rewired ${qt-rewired}
    unzip -d $out/mods/hazy ${hazy}
    unzip -d $out/mods/ ${tricky}
    unzip -d $out/mods/miku ${miku}
    unzip -d $out/mods/ ${philly}
    unrar x ${shootin} $out/mods
  '';

  installPhase = ''
    mkdir -p $out/bin
    echo "#!/usr/bin/env bash
    cd $out && ./Funkin" > $out/bin/funkin
    chmod +x $out/bin/funkin
  '';
}
