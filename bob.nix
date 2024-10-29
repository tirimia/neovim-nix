{pkgs, ...}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "bob";
  version = "4.0.2";

  src = pkgs.fetchFromGitHub {
    owner = "MordechaiHadad";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-IyMd8D/FwsIA4H9nWsq7vVp/9lmEn+m+aVEtajLwy/8=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  buildInputs =
    pkgs.lib.lists.optional pkgs.stdenv.isDarwin
    (with pkgs.darwin.apple_sdk.frameworks; [SystemConfiguration CoreServices]);
}
