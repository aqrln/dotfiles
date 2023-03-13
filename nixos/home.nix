{ pkgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users.aqrln = {
    home.stateVersion = "22.11";
    programs.bash.enable = true;
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
  };
}
