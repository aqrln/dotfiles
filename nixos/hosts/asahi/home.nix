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
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    fd
    fzf
    nil
    nodejs_latest
    nodejs_latest.pkgs."@prisma/language-server"
    nodejs_latest.pkgs.dockerfile-language-server-nodejs
    nodejs_latest.pkgs.pnpm
    nodejs_latest.pkgs.prettier
    nodejs_latest.pkgs.typescript-language-server
    nodejs_latest.pkgs.vscode-langservers-extracted
    nodejs_latest.pkgs.yarn
    rustup
    tmux
    vscode-extensions.vadimcn.vscode-lldb.adapter
    yaml-language-server

    cargo-espflash
    probe-rs

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    (pkgs.nerdfonts.override { fonts = [ "Iosevka" "FiraMono" "Inconsolata" ]; })

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
  };

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

      # uncomment this if there are any issues with rootless docker socket not being found
      # export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
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

  programs.alacritty = {
    enable = true;
    settings = {
      "import" = [ ./gruvbox_dark.toml ];

      # # preset 1:
      # font = {
      #   size = 10;
      #   normal = {
      #     family = "Iosevka Nerd Font";
      #     style = "Medium";
      #   };
      # };

      font = {
        size = 12;
        normal = {
          family = "Inconsolata Nerd Font";
          style = "Medium";
        };
      };
    };
  };
}
