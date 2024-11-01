{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    iosevka-bin
    (nerdfonts.override { fonts = [ "Inconsolata" "Iosevka" "IosevkaTerm" "FiraMono" ]; })
  ];

  fonts.fontconfig = {
    antialias = true;
    hinting.enable = false;
    subpixel.rgba = "none";
    subpixel.lcdfilter = "none";
  };

  # home-manager.users.aqrln.fonts.fontconfig.enable = true;
}
