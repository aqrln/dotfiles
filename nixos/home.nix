{ pkgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users.aqrln = {
    home.stateVersion = "22.11";
    programs.bash.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman batdiff batgrep ];
      config.theme = "ansi";
    };

    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
