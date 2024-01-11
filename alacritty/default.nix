{ pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;

in {
  home-manager.users.aqrln = {
    programs.alacritty = {
      enable = true;

      settings = {
        "import" = [
          # ./catppuccin_mocha.toml
          # ./kanagawa.toml
          # ./solarized_light.toml
          ./gruvbox_dark.toml
        ];

        font = {
          size = if isDarwin then 14 else 10;

          normal = {
            family = if isDarwin then "IosevkaTerm NF" else "IosevkaTerm Nerd Font";
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

          offset = {
            x = 0;
            y = -2;
          };
        };

        window = {
          decorations = if isDarwin then "Buttonless" else "None";
          option_as_alt = if isDarwin then "Both" else "None";
        };
      };
    };
  };
}
