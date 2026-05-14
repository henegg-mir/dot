{
  config,
  pkgs,
  lib,
  ...
}:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (oldAttrs: rec {
    version = "4.12";
    src = pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      rev = "v${version}";
      sha256 = "sha256-ELGjAp4YGgPLN62g7Fgkb83CMotAGeRnRgIGU8rd73E";
    };
  });
in
{
  environment.systemPackages = with pkgs; [
    git
    fzf
    mpv
    curl
    aria2
    yt-dlp
    ffmpeg
    ani-skip
    patch
    ani-cli
    openssl
  ];
}
