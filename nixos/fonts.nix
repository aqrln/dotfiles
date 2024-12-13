{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
    nerd-fonts.inconsolata
  ];

  fonts.fontconfig = {
    antialias = true;
    hinting.enable = false;
    subpixel.rgba = "none";
    subpixel.lcdfilter = "none";
  };

  # home-manager.users.aqrln.fonts.fontconfig.enable = true;
}
