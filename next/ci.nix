{ pkgs ? import <nixpkgs> {} }:
pkgs.buildEnv {
  name = "testing";
  paths = with pkgs; [ bash curl ];
}
