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

    home.packages = with pkgs; [
      lua-language-server
      # ncdu
      nixfmt-rfc-style
      tailwindcss-language-server
      tree-sitter
      yaml-language-server
    ];

    programs.bash = {
      enable = true;
      initExtra = ''
        if [ -f ~/dotfiles/bash/profile.local ]; then
          source ~/dotfiles/bash/profile.local
        fi
      '';
    };

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
        theme = "gruvbox_light";
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
