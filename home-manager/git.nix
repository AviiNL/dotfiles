{ config, lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    extraConfig = {
      user.email = "git@avii.nl";
      user.name = "AviiNL";
    };
  };
}
