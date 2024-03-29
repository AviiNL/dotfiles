{ pkgs, config, lib, ... }:
let cfg = config.custom.software.vscode;
in {

  options.custom.software.vscode = {
    enable = lib.mkEnableOption "vscode";
    nix-colors = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    # ...
  };

  imports = [ ./colors.nix ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      vistafonts
      nixfmt
    ];

    fonts.fontconfig.enable = true;

    programs = {
      git.ignores = [ ".vscode/" ];

      vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          rust-lang.rust-analyzer
          serayuzgur.crates
          brettm12345.nixfmt-vscode
        ];
        mutableExtensionsDir = true;
        package = pkgs.vscode;
        userSettings = {
          "window.titleBarStyle" = "custom";
          "breadcrumbs.enabled" = false;
          "diffEditor.codeLens" = true;
          "editor.fontFamily" = "Consolas, Symbols Nerd Font Mono, monospace";
          "editor.fontLigatures" = true;
          "editor.fontSize" = 14;
          "editor.formatOnSave" = true;
          "editor.minimap.enabled" = true;
          "editor.rulers" = [ 80 120 ];
          "terminal.integrated.fontFamily" =
            "Consolas, Symbols Nerd Font Mono, monospace";
          "workbench.statusBar.visible" = true;
          "git.confirmSync" = false;
          "git.autofetch" = true;
          "explorer.confirmDragAndDrop" = false;
          "workbench.tree.enableStickyScroll" = false;

          # Nix IDE
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.nixd}/bin/nixd";

          "terminal.external.linuxExec" =
            lib.mkIf config.custom.software.kitty.enable
            "${config.programs.kitty.package}/bin/kitty";

          "terminal.external.osxExec" =
            lib.mkIf config.custom.software.kitty.enable
            "${config.programs.kitty.package}/Applications/kitty.app";
        };
        keybindings = [
          {
            key = "ctrl+alt+l";
            command = "editor.action.formatDocument";
            when =
              "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
          }
          {
            key = "shift+alt+f";
            command = "-editor.action.formatDocument";
            when =
              "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
          }
          {
            key = "ctrl+enter";
            command = "-workbench.action.chat.insertCodeBlock";
            when = "hasChatProvider && inChat && !inChatInput";
          }
          {
            key = "ctrl+enter";
            command = "-interactive.acceptChanges";
            when =
              "inlineChatHasProvider && inlineChatVisible && !inlineChatDocumentChanged || inlineChatHasProvider && inlineChatVisible && config.inlineChat.mode != 'preview'";
          }
          {
            key = "ctrl+enter";
            command = "-gitlens.key.ctrl+enter";
            when = "gitlens:key:ctrl+enter";
          }
          {
            key = "ctrl+enter";
            command = "scm.acceptInput";
            when = "scmRepository";
          }
          {
            key = "ctrl+enter";
            command = "-scm.acceptInput";
            when = "scmRepository";
          }
          {
            key = "ctrl+enter";
            command = "-workbench.action.chat.submitSecondaryAgent";
            when = "inChatInput && textInputFocus";
          }
          {
            key = "alt+shift+down";
            command = "editor.action.copyLinesDownAction";
            when = "editorTextFocus && !editorReadOnly";
          }
          {
            key = "alt+shift+up";
            command = "editor.action.copyLinesUpAction";
            when = "editorTextFocus && !editorReadOnly";
          }
        ];
      };
    };
  };
}
