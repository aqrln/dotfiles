# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      <home-manager/nixos>
      <nixos-hardware/common/gpu/intel>
      <nixos-hardware/common/pc>
      <nixos-hardware/common/pc/ssd>
      ./hardware-configuration.nix
      ../../cachix.nix
      ../../home.nix
      # ../../sway.nix
      # ../../emacs.nix
      ../../../alacritty
      ../../debug.nix
      ../../fonts.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  powerManagement.cpuFreqGovernor = "ondemand";

  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  hardware.graphics.enable = true;

  networking.hostName = "minibloom"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.libinput.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Temporarily disable wayland since it somehow broke.
  # services.xserver.displayManager.gdm.wayland = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aqrln = {
    isNormalUser = true;
    description = "Alexey Orlenko";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      firefox
      ghostty
      rustup
      nodejs_latest
      nodejs_latest.pkgs.dockerfile-language-server-nodejs
      nodejs_latest.pkgs.pnpm
      nodejs_latest.pkgs.prettier
      nodejs_latest.pkgs."@prisma/language-server"
      nodejs_latest.pkgs.typescript-language-server
      nodejs_latest.pkgs.vscode-langservers-extracted
      zed-editor
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    buildah
    cachix
    docker-compose
    fd
    file
    fzf
    gcc
    git
    gnumake
    gnupg
    htop
    man-pages
    neovim
    nil
    nixfmt-rfc-style
    nixpkgs-fmt
    pinentry
    python3
    ripgrep
    rr
    rust-analyzer
    tailscale
    tmux
    virt-manager
    wget
    wl-clipboard
    zed-editor
    zsh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.dconf.enable = true;

  programs.mosh.enable = true;

  programs.nix-ld.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.tailscale.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [ 22 ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.libvirtd.enable = true;

  virtualisation.podman = {
    enable = true;
    # dockerCompat = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  documentation = {
    man.man-db.enable = true;
    man.generateCaches = true;
    dev.enable = true;
  };
}
