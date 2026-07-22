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
    url = "https://gamebanana.com/dl/1757417";
    hash = "sha256-lwiWZqjU0mZ9ZPMCCr0Ofx15PGH7DcwAj13t8c1Ild8=";
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
  sarvente = fetchurl {
    url = "https://github.com/OttomanGuy/Mid-Fight-Masses-Sarvente-FNF-MOD-V-SLICE-PORTED/releases/download/Release/Vs.sarvente.zip";
    hash = "sha256-Jm1VtQGSpLiAoOMvB7aoNXNUvIhLRZtlwlZJDYMVH2I=";
  };
  gf = fetchurl {
    url = "https://gamebanana.com/dl/1665743";
    hash = "sha256-eUMbC+x+12ArgIu3mSJ+sixCbNKWBSArqc2GQKafUE0=";
  };
  fnf-extreme = fetchurl {
    url = "https://gamebanana.com/dl/1759231";
    hash = "sha256-s+drggU6Dk0dRxv9VdVNltHIeO2SAYfP8QAphBWyUp0=";
  };
  random_1 = fetchurl {
    url = "https://gamebanana.com/dl/1681329";
    hash = "sha256-tBA+g5omHTulc8Pt6H345stZr6+krFHG0xKX0B+qud4=";
  };
  random_2 = fetchurl {
    url = "https://gamebanana.com/dl/1681366";
    hash = "sha256-iJCSvcbUoaQ9SvaEAQnnDimWjwNFV/+MmZ/qAKXhDgQ=";
  };
  sky-redux = fetchurl {
    url = "https://gamebanana.com/dl/1703688";
    hash = "sha256-dYIS5RqMo2vBH4vXNmzNe05rw152uB5GdufqAUdKzUc=";
  };
  nocturnal = fetchurl {
    url = "https://gamebanana.com/dl/1705996";
    hash = "sha256-MJ4Cde8EYKmqPd47x7nz2COGVQgWNLGSVG4mKadBeHs=";
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
    unzip -d $out/mods/ ${sarvente} -x "__MACOSX/*"
    unzip -d $out/mods/ ${gf}
    unzip ${fnf-extreme}
    mv "FNF Extreme Mode [V6]/Extreme Mode/" $out/mods/
    unzip -d $out/mods/ ${random_1}
    unzip -d $out/mods/ ${random_2}
    unzip -d $out/mods/ ${sky-redux}
    unzip -d $out/mods/ ${nocturnal}
    unrar x ${shootin} $out/mods
  '';

  installPhase = ''
    mkdir -p $out/bin
    echo "#!/usr/bin/env bash
    cd $out && ./Funkin" > $out/bin/funkin
    chmod +x $out/bin/funkin
  '';
}
