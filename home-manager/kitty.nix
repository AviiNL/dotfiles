# https://github.com/jupblb/nix-config/blob/main/home-manager/kitty.nix

{ config, pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home = {
    packages = with pkgs; [
      vistafonts
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    shellAliases = {
      icat = "kitty +kitten icat";
      ssh = "kitty +kitten ssh";
    };
  };

  # TODO: use nix-colors

  programs = {
    kitty = {
      enable = true;
      font = {
        name = "Consolas";
        size = 10;
      };
      keybindings = {
        "ctrl+shift+'" = "launch --location=hsplit";
        "ctrl+shift+;" = "launch --location=vsplit";
        "ctrl+shift+`" = "show_scrollback";
        "ctrl+shift+0" = "change_font_size all 0";
        "ctrl+shift+h" = "move_window left";
        "ctrl+shift+j" = "move_window bottom";
        "ctrl+shift+k" = "move_window top";
        "ctrl+shift+l" = "move_window right";
        "ctrl+h" = "neighboring_window left";
        "ctrl+j" = "neighboring_window bottom";
        "ctrl+k" = "neighboring_window top";
        "ctrl+l" = "neighboring_window right";
      };
      settings = {
        clipboard_control = "write-clipboard write-primary no-append";
        confirm_os_window_close = 0;
        cursor_blink_interval = 0;
        enabled_layouts = "splits";
        enable_audio_bell = "no";
        hide_window_decorations = "no";
        scrollback_pager_history_size = 4096;
        # https://sw.kovidgoyal.net/kitty/faq/#kitty-is-not-able-to-use-my-favorite-font
        symbol_map = let
          mappings = [
            "U+23FB-U+23FE"
            "U+2B58"
            "U+E200-U+E2A9"
            "U+E0A0-U+E0A3"
            "U+E0B0-U+E0BF"
            "U+E0C0-U+E0C8"
            "U+E0CC-U+E0CF"
            "U+E0D0-U+E0D2"
            "U+E0D4"
            "U+E700-U+E7C5"
            "U+F000-U+F2E0"
            "U+2665"
            "U+26A1"
            "U+F400-U+F4A8"
            "U+F67C"
            "U+E000-U+E00A"
            "U+F300-U+F313"
            "U+E5FA-U+E62B"
          ];
        in (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
        tab_bar_min_tabs = 5;
      };
      extraConfig = let inherit (config.colorscheme) palette;
      in ''
        background_opacity 0.8
        background #${palette.base00}
        foreground #${palette.base05}
        selection_background #${palette.base05}
        selection_foreground #${palette.base00}
        url_color #${palette.base04}
        cursor #${palette.base05}
        active_border_color #${palette.base03}
        inactive_border_color #${palette.base01}
        active_tab_background #${palette.base00}
        active_tab_foreground #${palette.base05}
        inactive_tab_background #${palette.base01}
        inactive_tab_foreground #${palette.base04}
        tab_bar_background #${palette.base01}

        # normal
        color0 #${palette.base00}
        color1 #${palette.base08}
        color2 #${palette.base0B}
        color3 #${palette.base0A}
        color4 #${palette.base0D}
        color5 #${palette.base0E}
        color6 #${palette.base0C}
        color7 #${palette.base05}

        # bright
        color8 #${palette.base03}
        color9 #${palette.base09}
        color10 #${palette.base01}
        color11 #${palette.base02}
        color12 #${palette.base04}
        color13 #${palette.base06}
        color14 #${palette.base0F}
        color15 #${palette.base07}
      '';
      #theme = "Gruvbox Dark Hard";
    };

    vscode.userSettings = {
      "terminal.external.linuxExec" =
        "${config.programs.kitty.package}/bin/kitty";
      "terminal.external.osxExec" =
        "${config.programs.kitty.package}/Applications/kitty.app";
    };
  };
}
