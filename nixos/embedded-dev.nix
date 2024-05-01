{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    probe-rs
    stlink
    stlink-gui
    usbutils
  ];

  # Read/write access to ST-Link V2 without root.
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", TAG+="uaccess"
  '';
  # services.udev.extraRules = ''
  #   SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666"
  # '';
}
