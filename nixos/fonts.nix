{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    iosevka-bin
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  fonts.fontconfig = {
    antialias = true;
    subpixel.rgba = "none";
  };

  # home-manager.users.aqrln.fonts.fontconfig.enable = true;
}
