{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ./home.nix
    ./emacs.nix
    ../alacritty
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    direnv
    htop

    alacritty
    tmux
    fd
    fzf
    zoxide

    nixpkgs-fmt
    nixfmt
    nil

    rust-analyzer-unwrapped

    tailscale
  ];

  users.users.aqrln = {
    name = "aqrln";
    home = "/Users/aqrln";
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # nix.settings.sandbox = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 10d";
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.bash.enable = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
