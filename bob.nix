{pkgs, ...}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "bob";
  version = "3.0.1";

  src = pkgs.fetchFromGitHub {
    owner = "MordechaiHadad";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Op/NXWssylgAOb1BccSOz7JqXFranzAsGICFMF3o/K8=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  buildInputs =
    pkgs.lib.lists.optional pkgs.stdenv.isDarwin
    (with pkgs.darwin.apple_sdk.frameworks; [SystemConfiguration CoreServices]);
}
