{ pkgs, ... }:

{
  services.nixseparatedebuginfod.enable = true;

  environment.systemPackages = with pkgs; [ gdb ];
}
