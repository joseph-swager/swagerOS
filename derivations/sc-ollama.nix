{lib, pkgs ? import <nixpkgs> {} }:

let
  scOllama = import ./sc-ollama-0.1.21.nix;

in scOllama

