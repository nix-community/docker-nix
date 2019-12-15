let
  nixpkgs = import ./nixpkgs.nix;

  pkgs = import nixpkgs { config = {}; overlays = []; };

  mkUserEnvironment = pkgs.callPackage ./user-environment.nix {};

  gitReallyMinimal = (pkgs.git.override {
    perlSupport = false;
    pythonSupport = false;
    withManual = false;
    withpcre2 = false;
  }).overrideAttrs (_: {
    # installCheck is broken when perl is disabled
    doInstallCheck = false;
  });
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
    gitReallyMinimal
    gnutar
    gzip
    xz
    # CI dependencies
    openssh
  ];
}
