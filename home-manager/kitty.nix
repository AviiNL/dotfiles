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
      # extraConfig = ''
      #   # Base16 Windows NT - kitty color config
      #   # Scheme by Fergus Collins (https://github.com/C-Fergus)
      #   background #000000
      #   foreground #c0c0c0
      #   selection_background #c0c0c0
      #   selection_foreground #000000
      #   url_color #a1a1a1
      #   cursor #c0c0c0
      #   active_border_color #808080
      #   inactive_border_color #2a2a2a
      #   active_tab_background #000000
      #   active_tab_foreground #c0c0c0
      #   inactive_tab_background #2a2a2a
      #   inactive_tab_foreground #a1a1a1
      #   tab_bar_background #2a2a2a

      #   # normal
      #   color0 #000000
      #   color1 #ff0000
      #   color2 #00ff00
      #   color3 #ffff00
      #   color4 #0000ff
      #   color5 #ff00ff
      #   color6 #00ffff
      #   color7 #c0c0c0

      #   # bright
      #   color8 #808080
      #   color9 #808000
      #   color10 #2a2a2a
      #   color11 #555555
      #   color12 #a1a1a1
      #   color13 #e0e0e0
      #   color14 #008000
      #   color15 #ffffff
      # '';
      theme = "Gruvbox Dark Hard";
    };

    vscode.userSettings = {
      "terminal.external.linuxExec" =
        "${config.programs.kitty.package}/bin/kitty";
      "terminal.external.osxExec" =
        "${config.programs.kitty.package}/Applications/kitty.app";
    };
  };
}
