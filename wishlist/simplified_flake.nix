# Will work/be forever impossible once https://github.com/NixOS/nix/issues/3966 is decided on
let
  versionToHash = {
    "0_4_3" = "e5b91d92a01178f9eecc0c7dd09a89e29fe9cc6f";
    "0_4_4" = "db6e089456cdddcd7e2c1d8dac37a505c797e8fa";
    "0_5_0" = "b5182c214fac1e6db9f28ed8a7cfc2d0c255c763";
    "0_9_4" = "fd04bea4cbf76f86f244b9e2549fca066db8ddff";
  };
in {
  description = "Neovim version samples";

  inputs =
    {
      flake-utils.url = "github:numtide/flake-utils";
    }
    // builtins.mapAttrs (version: nixpkgsCommit: {url = "github:NixOS/nixpkgs/${nixpkgsCommit}";}) versionToHash;

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        # We take all inputs beginning with a digit so we can guarantee it's a neovim version
        versions = with builtins; filter (input: (match "[[:digit:]].*" input) != null) (attrNames versionToHash);
        latest = with builtins; elemAt (sort lessThan versions) (length versions - 1);
        mkNeovim = version:
          flake-utils.lib.mkApp {
            drv = self.inputs.${version}.legacyPackages.${system}.neovim;
            name = "nvim";
          };
      in {
        apps =
          builtins.listToAttrs (map (version: {
              name = version;
              value = mkNeovim version;
            })
            versions)
          // {
            latest = mkNeovim latest;
            default = self.apps.${system}.latest;
          };
      }
    );
}
