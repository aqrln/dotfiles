{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    iosevka-bin
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; })
  ];

  fonts.fontconfig = {
    antialias = true;
    hinting.enable = false;
    subpixel.rgba = "none";
    subpixel.lcdfilter = "none";
  };

  # home-manager.users.aqrln.fonts.fontconfig.enable = true;
}
