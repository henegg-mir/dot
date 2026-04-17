{
  config,
  pkgs,
  lib,
  ...
}:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (oldAttrs: rec {
    version = "4.11";
    src = pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      rev = "v${version}";
      sha256 = "0kw2bd3w5yn4kgmfkgyssg80dgl8xg55lid7xgk90plps8d6n2l1";
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
  ];
}
