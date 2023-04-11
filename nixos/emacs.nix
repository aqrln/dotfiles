{ pkgs, ... }:

let
  emacsPackage = with pkgs;
    emacsWithPackagesFromUsePackage {
      config = ../emacs/init.el;
      alwaysEnsure = true;

      package = emacsUnstable;
      # package = emacsPgtk.overrideAttrs (prev: {
      #   patches = (prev.patches or [ ]) ++ [
      #     (fetchpatch {
      #       url =
      #         "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-28/fix-window-role.patch";
      #       sha256 = "sha256-+z/KfsBm1lvZTZNiMbxzXQGRTjkCFO4QPlEK35upjsE=";
      #     })
      #   ];
      # });
    };

in {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];

  services.emacs.package = emacsPackage;

  environment.systemPackages = with pkgs; [ emacsPackage aspell ];
}
