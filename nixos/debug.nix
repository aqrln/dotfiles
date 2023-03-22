{ config, pkgs, ... }:

{
  imports = [
    ((builtins.fetchTarball {
      url =
        "https://github.com/symphorien/nixseparatedebuginfod/archive/de56c0eb52c795daac52f67e80c90771d72f9dbc.tar.gz";
      sha256 = "sha256:13jqzdkbm8gya2lifmbkslkd89vnpdgf76amlym9fslm8im4p14k";
    }) + "/module.nix")
  ];

  services.nixseparatedebuginfod.enable = true;

  # environment.systemPackages = with pkgs;
  #   [ (gdb.override { enableDebuginfod = true; }) ];

  # home-manager.users.aqrln = {
  #   home.file.".gdbinit".text = ''
  #     set debuginfod enabled on
  #   '';
  # };
}
