{ config, lib, ... }:
let cfg = config.custom.software.kitty;
in {
  options.custom.software.kitty = {
    enable = lib.mkEnableOption "kitty";

    # ...
  };

  config = lib.mkIf cfg.enable {
    # ...
  };
}
