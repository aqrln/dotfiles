{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "aqrln";
  home.homeDirectory = "/home/aqrln";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    fd
    fzf
    gitu
    lua-language-server
    nil
    nixd
    nixfmt-rfc-style
    nodejs_latest
    nodejs_latest.pkgs."@prisma/language-server"
    nodejs_latest.pkgs.dockerfile-language-server-nodejs
    nodejs_latest.pkgs.pnpm
    nodejs_latest.pkgs.prettier
    nodejs_latest.pkgs.vscode-langservers-extracted
    nodejs_latest.pkgs.yarn
    tailwindcss-language-server
    tmux
    tree-sitter
    vtsls
    vscode-extensions.vadimcn.vscode-lldb.adapter
    yaml-language-server

    cargo-espflash
    probe-rs

    nerd-fonts.fira-mono
    nerd-fonts.inconsolata
    nerd-fonts.iosevka

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/nixpkgs/overlays/asahi-mesa.nix".text =
      let
        flakeLock = builtins.fromJSON (builtins.readFile ./flake.lock);
        inherit (flakeLock.nodes.nixos-apple-silicon.locked) rev narHash;
      in
      ''
        final: prev:
        let
          nixos-apple-silicon = fetchTarball {
            url = "https://github.com/tpwrules/nixos-apple-silicon/archive/${rev}.tar.gz";
            sha256 = "${narHash}";
          };
          nas = import nixos-apple-silicon { };
          inherit (nas.packages.aarch64-linux) mesa-asahi-edge;
        in
        {
          mesa-asahi-edge = mesa-asahi-edge;
          mesa = mesa-asahi-edge;
        }
      '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/aqrln/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    DBX_CONTAINER_MANAGER = "podman";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.shellAliases = {
    ls = "ls --color=auto";
  };

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;

    bashrcExtra = ''
      if [ -f /etc/bashrc ]; then
          . /etc/bashrc
      fi

      . $HOME/.profile

      # uncomment this if there are any issues with rootless docker socket not being found
      # export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

      if [[ -z "$SSH_AUTH_SOCK" ]]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
      fi

      osc7_cwd() {
        local strlen=''${#PWD}
        local encoded=""
        local pos c o
        for (( pos=0; pos<strlen; pos++ )); do
            c=''${PWD:$pos:1}
            case "$c" in
                [-/:_.!\'\(\)~[:alnum:]] ) o="''${c}" ;;
                * ) printf -v o '%%%02X' "'$c" ;;
            esac
            encoded+="''${o}"
        done
        printf '\e]7;file://%s%s\e\\' "''${HOSTNAME}" "''${encoded}"
      }
      PROMPT_COMMAND=''${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd

      prompt_marker() {
          printf '\e]133;A\e\\'
      }
      PROMPT_COMMAND=''${PROMPT_COMMAND:+$PROMPT_COMMAND; }prompt_marker

      source <(CARGO_COMPLETE=bash cargo +nightly)
    '';

    profileExtra = ''
      [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.ripgrep.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
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
    settings =  {
      character.success_symbol = "[\\$](bold green)";
      character.error_symbol = "[\\$](bold red)";
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        "import" = [ ./gruvbox_light.toml ];
      };

      font = {
        size = 9;
        normal = {
          family = "Fira Mono Nerd Font";
          style = "Regular";
        };
      };
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Inconsolata Nerd Font:size=10";
        # dpi-aware = "yes";
        include = "${pkgs.foot.themes}/share/foot/themes/gruvbox-light";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };


  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
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
}
