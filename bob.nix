{pkgs, ...}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "bob";
  version = "2.7.0";

  src = pkgs.fetchFromGitHub {
    owner = "MordechaiHadad";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-bLhFk6St2C1YeMN+ZlDXZ2ASrweHQaDfFZKWyzgS+JM=";
  };

  cargoHash = "sha256-oLUgFv+nRhQOERD3S+GF3qdXHdpEVxynNLr6ff9EmVI=";

  buildInputs =
    pkgs.lib.lists.optional pkgs.stdenv.isDarwin
    (with pkgs.darwin.apple_sdk.frameworks; [SystemConfiguration CoreServices]);
}
