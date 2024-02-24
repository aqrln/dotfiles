{ pkgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users.aqrln = {
    home.stateVersion = "22.11";

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.bash.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman batdiff batgrep ];
      config.theme = "ansi";
    };

    programs.gh = {
      enable = true;
      settings = {
        version = "1";
        git_protocol = "ssh";
        editor = "nvim";
      };
    };

    programs.starship = {
      enable = true;
      settings = {
        character.success_symbol = "[\\$](bold green)";
        character.error_symbol = "[\\$](bold red)";
      };
    };

    programs.helix = {
      enable = true;
      settings = {
        theme = "gruvbox";
        keys.normal.space = {
          o = "file_picker_in_current_buffer_directory";
          w = ":w";
        };
      };
      languages = {
        language-server = {
          rust-analyzer.config = {
            check = {
              command = "clippy";
              features = "all";
            };
            cargo = {
              features = "all";
            };
          };
        };
      };
    };
  };
}
