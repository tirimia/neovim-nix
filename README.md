# Neovim Version Sampler

## Usage

### Prerequisites
First and foremost ensure you have nix installed and flakes enabled.

The easiest way to achieve that is through the Determinate Systems [installer](https://github.com/DeterminateSystems/nix-installer).

### Versions
Latest is the default
```shell
nix run github:tirimia/neovim-nix
```
Nightly
```shell
nix run github:tirimia/neovim-nix#nightly
```
For a specific version (in this example `0_9_2`), check the inputs declared in the [flake](./flake.nix) then run like:
```shell
nix run github:tirimia/neovim-nix#0_9_2
```

## Alternative
For those that want to use [bob](https://github.com/MordechaiHadad/bob), that is packaged too, simply run:
```shell
nix run github:tirimia/neovim-nix#bob
```

## TODO
Add a check that would verify if we have all versions of nvim and use it in a cron based pipeline
Add bob auto-updater or at least notifier

## Inspiration
A [packaging request](https://github.com/NixOS/nixpkgs/issues/271480) for Nixpkgs lead me to find out that the nix flake in the neovim repo is not actively maintained.

As I was considering whether to fulfill the packaging request I had this idea for just providing the flake myself using nixpkgs hashes taken from [Nixhub](https://www.nixhub.io/packages/neovim).

## P.S.
Should have called this flake Bobert in honor of the [project](https://github.com/MordechaiHadad/bob) that ultimately inspired this flake.
