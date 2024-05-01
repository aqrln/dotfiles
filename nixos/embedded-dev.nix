{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    stlink
    stlink-gui
    usbutils
  ];
}
