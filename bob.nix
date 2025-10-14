{pkgs, ...}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "bob";
  version = "4.1.4";

  src = pkgs.fetchFromGitHub {
    owner = "MordechaiHadad";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-cQM/ZLh6hKjvfxUGLvlsysKKbhjjJ+1J1YvGUom9PEw=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  buildInputs =
    pkgs.lib.lists.optional pkgs.stdenv.isDarwin
    (with pkgs.darwin.apple_sdk.frameworks; [SystemConfiguration CoreServices]);
}
