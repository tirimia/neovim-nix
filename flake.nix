{
  description = "Neovim version samples";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # No guarantee most of these versions will actually build on all systems outside of x86 Linux
    # Hashes taken from nixhub.io
    # WARN: the inputs have to stay sorted
    "0_4_3".url = "github:NixOS/nixpkgs/e5b91d92a01178f9eecc0c7dd09a89e29fe9cc6f";
    "0_4_4".url = "github:NixOS/nixpkgs/db6e089456cdddcd7e2c1d8dac37a505c797e8fa";
    "0_5_0".url = "github:NixOS/nixpkgs/b5182c214fac1e6db9f28ed8a7cfc2d0c255c763";
    "0_5_1".url = "github:NixOS/nixpkgs/f366af7a1b3891d9370091ab03150d3a6ee138fa";
    "0_6_0".url = "github:NixOS/nixpkgs/3175a66dad6f504b3f1a1cae4b2a8520c2424d6b";
    "0_6_1".url = "github:NixOS/nixpkgs/c984213d12225fa5feb640136872da56d2e8f702";
    "0_7_0".url = "github:NixOS/nixpkgs/0c4852c7bc40747e734a84a0d234105a4d5c146f";
    "0_7_2".url = "github:NixOS/nixpkgs/26c27a7a0b6ab7e74a6235a9047d121cb3a18c88";
    "0_8_0".url = "github:NixOS/nixpkgs/97b8d9459f7922ce0e666113a1e8e6071424ae16";
    "0_8_1".url = "github:NixOS/nixpkgs/726088a96454587d4a640d28ec442126518e449b";
    "0_8_2".url = "github:NixOS/nixpkgs/79feedf38536de2a27d13fe2eaf200a9c05193ba";
    "0_8_3".url = "github:NixOS/nixpkgs/83ca2cd74539fb8e79d46e233f6bb1d978c36f32";
    "0_9_0".url = "github:NixOS/nixpkgs/4a22f6f0a4b4354778f786425babce9a56f6b5d8";
    "0_9_1".url = "github:NixOS/nixpkgs/efd23a1c9ae8c574e2ca923c2b2dc336797f4cc4";
    "0_9_2".url = "github:NixOS/nixpkgs/d1c9180c6d1f8fce9469436f48c1cb8180d7087d";
    "0_9_4".url = "github:NixOS/nixpkgs/fd04bea4cbf76f86f244b9e2549fca066db8ddff";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    neovim-nightly,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        nonVersionImports = ["nixpkgs" "flake-utils" "neovim-nightly"];
        versions = with builtins; filter (input: ! elem input nonVersionImports) (attrNames self.inputs);
        latest = nixpkgs.lib.lists.last versions;
        neovimApp = drv:
          flake-utils.lib.mkApp {
            inherit drv;
            name = "nvim";
          };
        mkNeovim = version:
          neovimApp self.inputs.${version}.legacyPackages.${system}.neovim;
        nightly =
          (import nixpkgs {
            inherit system;
            overlays = [neovim-nightly.overlay];
          })
          .neovim-nightly;
      in {
        apps =
          builtins.listToAttrs (map (version: {
              name = version;
              value = mkNeovim version;
            })
            versions)
          // {
            nightly = neovimApp nightly;
            latest = mkNeovim latest;
            default = self.apps.${system}.latest;
          };
      }
    );
}
