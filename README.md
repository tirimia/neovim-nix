# Neovim Version Sampler

## Usage
For the latest available version
```shell
nix run github:tirimia/neovim-nix
```
For a specific version (in this example `0_9_2`), check the inputs declared then run like:
```shell
nix run github:tirimia/neovim-nix#0_9_2
```

## TODO
Add a check that would verify if we have all versions of nvim and use it in a cron based pipeline

## Inspiration
A [packaging request](https://github.com/NixOS/nixpkgs/issues/271480) for Nixpkgs lead me to find out that the nix flake in the neovim repo is not actively maintained.

As I was considering whether to fulfill the packaging request I had this idea for just providing the flake myself using nixpkgs hashes taken from [Nixhub](https://www.nixhub.io/packages/neovim).
