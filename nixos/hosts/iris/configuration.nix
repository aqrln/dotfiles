# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ modulesPath, config, pkgs, lib, ... }:

let
  x-www-browser = pkgs.writeShellApplication {
    name = "x-www-browser";
    text = ''
      exec mac open "$@"
    '';
  };

in

with lib;

{
  imports =
    [ # Include the default lxd configuration.
      "${modulesPath}/virtualisation/lxc-container.nix"
      # Include the container-specific autogenerated configuration.
      /etc/nixos/lxd.nix
      /etc/nixos/orbstack.nix

      <home-manager/nixos>
      ../../cachix.nix
      ../../debug.nix
      ../../home.nix
    ];

  # Select internationalisation properties.
  # i18n.supportedLocales = [ "all" ];
  i18n.defaultLocale = "en_US.UTF-8";

  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "de_DE.UTF-8";
  #   LC_IDENTIFICATION = "de_DE.UTF-8";
  #   LC_MEASUREMENT = "de_DE.UTF-8";
  #   LC_MONETARY = "de_DE.UTF-8";
  #   LC_NAME = "en_GB.UTF-8";
  #   LC_NUMERIC = "de_DE.UTF-8";
  #   LC_PAPER = "de_DE.UTF-8";
  #   LC_TELEPHONE = "de_DE.UTF-8";
  #   LC_TIME = "de_DE.UTF-8";
  # };

  users.users.aqrln = {
    description = "Alexey Orlenko";
    extraGroups = [ "wheel" "docker" ];

    # simulate isNormalUser, but with an arbitrary UID
    uid = 501;
    isSystemUser = true;
    group = "users";
    createHome = true;
    home = "/home/aqrln";
    homeMode = "700";
    useDefaultShell = true;

    packages = with pkgs; [
      deno
      flyctl
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
      tailwindcss-language-server
      turso-cli
      vscode-extensions.vadimcn.vscode-lldb.adapter
      xdg-utils
      yaml-language-server

      x-www-browser
    ];
  };

  # Users created by OrbStack don't have a password.
  security.sudo.wheelNeedsPassword = false;

  # This being `true` leads to a few nasty bugs, change at your own risk!
  users.mutableUsers = false;

  time.timeZone = "Europe/Berlin";

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  environment.systemPackages = with pkgs; [
    cachix
    fd
    file
    fzf
    gcc
    git
    gnumake
    gnupg
    graphviz
    htop
    jq
    lazydocker
    linuxKernel.packages.linux_6_11.perf
    man-pages
    man-pages-posix
    openssl
    perl
    pkg-config
    pinentry
    python3
    ripgrep
    tailscale
    tmux
    wget
    zsh
    xorg.xauth
    xpra
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
    # pinentryFlavor = "curses";
  };

  programs.nix-ld.enable = true;
  programs.nix-index.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  documentation = {
    enable = true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;
    man.enable = true;
    man.man-db.enable = true;
    man.generateCaches = true;
    nixos.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Make the starship prompt normal and remove things that are only printed because of LXC and SSH.
  home-manager.users.aqrln.programs.starship.settings = {
    container.disabled = true;
    username.disabled = true;
    # hostname.disabled = true;
  };

  virtualisation.docker.enable = true;
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };

  services.tailscale.enable = true;

  # networking.firewall = {
  #   enable = true;
  #   trustedInterfaces = [ config.services.tailscale.interfaceName ];
  #   allowedUDPPorts = [ config.services.tailscale.port ];
  #   allowedTCPPorts = [ 22 ];
  # };

  services.openssh = {
    enable = lib.mkForce true;
    ports = [ 2222 ];
    settings = {
      X11Forwarding = true;
    };
  };

  programs.ssh.setXAuthLocation = lib.mkForce true;

  services.xserver.desktopManager.xfce.enable = true;

  home-manager.users.aqrln.home.file.".gnupg/gpg-agent.conf".text =
    let
      pinentry-mac = pkgs.writeShellApplication {
        name = "pinentry-mac";
        text = ''
          /opt/orbstack-guest/bin/mac "/Volumes/Macintosh HD/opt/homebrew/bin/pinentry-mac" "$@"
        '';
      };
    in
    ''
    pinentry-program ${pinentry-mac}/bin/pinentry-mac
    '';
}
