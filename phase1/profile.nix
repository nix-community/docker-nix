let
  nixpkgs = import ./nixpkgs.nix;

  pkgs = import nixpkgs { config = {}; overlays = []; };

  mkUserEnvironment = pkgs.callPackage ./user-environment.nix {};
in
mkUserEnvironment {
  derivations = with pkgs; [
    # a basic system environment
    bashInteractive
    cacert
    coreutils
    iana-etc
    nix
    shadow
    # nix runtime dependencies for builtin functions
    gitMinimal
    gnutar
    gzip
    xz
    # CI dependencies
    openssh
  ];
}
