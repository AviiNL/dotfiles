{ config, lib, ... }:
let cfg = config.custom.software.kitty;
in {
  options.software.kitty = {
    enable = lib.mkEnableOption "kitty";

    # ...
  };

  config = lib.mkIf cfg.enable {
    # ...
  };
}
