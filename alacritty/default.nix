{ pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  lib = pkgs.lib;

in {
  home-manager.users.aqrln = {
    programs.alacritty = {
      enable = true;
      settings = {
        "import" = [
          # ./kanagawa.yml
          ./solarized_light.yaml
        ] ++ lib.optionals isDarwin [ ./mac_meta_keys.yml ];

        font = {
          size = if isDarwin then 14 else 12;

          normal = {
            family = "IosevkaTerm Nerd Font";
            style = if isDarwin then "Regular" else "Medium";
          };

          italic = {
            style = if isDarwin then "Italic" else "Medium Italic";
          };

          bold = {
            style = if isDarwin then "Bold" else "Heavy";
          };

          bold_italic = {
            style = if isDarwin then "Bold Italic" else "HeavyItalic";
          };
        };
      };
    };
  };
}
