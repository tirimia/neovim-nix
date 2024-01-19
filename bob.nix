{pkgs, ...}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "bob";
  version = "2.8.0";

  src = pkgs.fetchFromGitHub {
    owner = "MordechaiHadad";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-LQEoiXsrDTXOPRX8Tcqg0p58mgxJfKcjs1XFD1vNtOs=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  buildInputs =
    pkgs.lib.lists.optional pkgs.stdenv.isDarwin
    (with pkgs.darwin.apple_sdk.frameworks; [SystemConfiguration CoreServices]);
}
