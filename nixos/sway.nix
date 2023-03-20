{ pkgs, ... }:

{
  services.dbus.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  security.pam.services.swaylock = {
    text = "auth include login";
  };

  services.xserver.displayManager = {
    gdm.enable = true;
  };

  programs.sway.enable = true;

  home-manager.users.aqrln = {
    home.packages = with pkgs; [
      alacritty
      bemenu
      mako
      swayidle
      swaylock
      waybar
      wl-clipboard
    ];

    home.sessionVariables.WLR_RENDERER = "pixman";
    systemd.user.sessionVariables.WLR_RENDERER = "pixman";

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "bemenu-run";

        # bars = [{
        #   command = "waybar";
        #   position = "bottom";
        #   fonts.size = 8.0;
        # }];

        input = {
          "1575:1:QEMU_QEMU_USB_Mouse" = {
            natural_scroll = "enabled";
          };
          "1575:1:QEMU_QEMU_USB_Tablet" = {
            natural_scroll = "enabled";
          };
        };

        output = {
          Virtual-1 = {
            # resolution = "3024x1964";
          };
        };
      };
    };
  };
}
