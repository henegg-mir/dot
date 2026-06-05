{
  appimageTools,
  fetchurl,
}:

let
  version = "1.3.1";
  pname = "dusk";

  src = fetchurl {
    url = "https://github.com/BeZide93/dusk/releases/download/v${version}-1/Dawnlight-v${version}-1-linux-x86_64.AppImage";
    hash = "sha256-psz3KT7PzBbjovGxJa6GUFqSXdQp11D8WyezqfuwzU4=";
  };

in
appimageTools.wrapType2 { inherit pname version src; }
