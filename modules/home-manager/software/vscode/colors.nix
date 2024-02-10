{ config, pkgs, lib, ... }:
let inherit (config.colorscheme) palette;
in {

  # look here for inspiration to fix: "ansi"
  # https://github.com/Misterio77/nix-config/blob/main/home/misterio/features/desktop/common/wayland-wm/wezterm.nix

  programs.vscode.userSettings =
    lib.mkIf config.custom.software.vscode.nix-colors {
      # Original colors are from gruvbox-dark-hard by jdinhify
      # https://github.com/jdinhify/vscode-theme-gruvbox/blob/main/themes/gruvbox-dark-hard.json
      # Need to find alternatives for the still hardcoded colors
      "workbench.colorCustomizations" = {
        # BASE COLORS
        "focusBorder" = "#${palette.base01}";
        "foreground" = "#${palette.base06}";
        "widget.shadow" = "#${palette.base00}30";
        "selection.background" = "#689d6a80"; # FIXME: UNKNOWN
        "errorForeground" = "#${palette.base08}";
        # BUTTON
        "button.background" = "#45858880"; # FIXME: UNKNOWN
        "button.foreground" = "#${palette.base06}";
        "button.hoverBackground" = "#45858860";
        # DROPDOWN
        "dropdown.background" = "#${palette.base00}";
        "dropdown.border" = "#${palette.base01}";
        "dropdown.foreground" = "#${palette.base06}";
        # INPUT
        "input.background" = "#${palette.base06}05";
        "input.border" = "#${palette.base01}";
        "input.foreground" = "#${palette.base06}";
        "input.placeholderForeground" = "#${palette.base06}60";
        "inputValidation.errorBorder" = "#${palette.base08}";
        "inputValidation.errorBackground" = "#cc241d80"; # FIXME: UNKNOWN
        "inputValidation.infoBorder" = "#${palette.base0D}";
        "inputValidation.infoBackground" = "#45858880";
        "inputValidation.warningBorder" = "#${palette.base0A}";
        "inputValidation.warningBackground" = "#d7992180";
        "inputOption.activeBorder" = "#${palette.base06}60";
        # SCROLL BAR
        "scrollbar.shadow" = "#${palette.base00}";
        "scrollbarSlider.activeBackground" = "#689d6a";
        "scrollbarSlider.hoverBackground" = "#${palette.base03}";
        "scrollbarSlider.background" = "#${palette.base02}99";
        # BADGE
        "badge.background" = "#${palette.base0E}";
        "badge.foreground" = "#${palette.base00}";
        # PROGRESS BAR
        "progressBar.background" = "#689d6a";
        # LISTS AND TREES
        "list.activeSelectionBackground" = "#${palette.base01}80";
        "list.activeSelectionForeground" = "#${palette.base0C}";
        "list.hoverBackground" = "#${palette.base01}80";
        "list.hoverForeground" = "#${palette.base05}";
        "list.focusBackground" = "#${palette.base01}";
        "list.focusForeground" = "#${palette.base06}";
        "list.inactiveSelectionForeground" = "#689d6a";
        "list.inactiveSelectionBackground" = "#${palette.base01}80";
        "list.dropBackground" = "#${palette.base01}";
        "list.highlightForeground" = "#689d6a";
        # SIDE BAR
        "sideBar.background" = "#${palette.base00}";
        "sideBar.foreground" = "#${palette.base05}";
        "sideBar.border" = "#${palette.base01}";
        "sideBarTitle.foreground" = "#${palette.base06}";
        "sideBarSectionHeader.background" = "#${palette.base00}00";
        "sideBarSectionHeader.foreground" = "#${palette.base06}";
        # ACTIVITY BAR
        "activityBar.background" = "#${palette.base00}";
        "activityBar.foreground" = "#${palette.base06}";
        "activityBar.border" = "#${palette.base01}";
        "activityBarBadge.background" = "#458588";
        "activityBarBadge.foreground" = "#${palette.base06}";
        # EDITOR GROUPS
        "editorGroup.border" = "#${palette.base01}";
        "editorGroup.dropBackground" = "#${palette.base01}60";
        "editorGroupHeader.noTabsBackground" = "#${palette.base01}";
        "editorGroupHeader.tabsBackground" = "#${palette.base00}";
        "editorGroupHeader.tabsBorder" = "#${palette.base01}";
        # TABS
        "tab.border" = "#${palette.base00}00";
        "tab.activeBorder" = "#689d6a";
        "tab.activeBackground" = "#32302f";
        "tab.activeForeground" = "#${palette.base06}";
        "tab.inactiveForeground" = "#a89984";
        "tab.inactiveBackground" = "#${palette.base00}";
        "tab.unfocusedActiveForeground" = "#a89984";
        "tab.unfocusedActiveBorder" = "#${palette.base00}00";
        "tab.unfocusedInactiveForeground" = "#928374";
        # EDITOR
        "editor.background" = "#${palette.base00}";
        "editor.foreground" = "#${palette.base06}";
        "editorLineNumber.foreground" = "#${palette.base03}";
        "editorCursor.foreground" = "#${palette.base06}";
        "editor.selectionBackground" = "#689d6a40";
        "editor.selectionHighlightBackground" = "#${palette.base0A}40";
        "editor.hoverHighlightBackground" = "#689d6a50";
        "editorLink.activeForeground" = "#${palette.base06}";
        "editor.findMatchBackground" = "#${palette.base0D}70";
        "editor.findMatchHighlightBackground" = "#${palette.base09}30";
        "editor.findRangeHighlightBackground" = "#${palette.base0D}70";
        "editor.lineHighlightBackground" = "#${palette.base01}60";
        "editor.lineHighlightBorder" = "#${palette.base01}00";
        "editorWhitespace.foreground" = "#a8998420";
        "editorRuler.foreground" = "#a8998440";
        "editorCodeLens.foreground" = "#a8998490";
        "editorBracketMatch.border" = "#${palette.base00}00";
        "editorBracketMatch.background" = "#92837480";
        "editorHoverWidget.background" = "#${palette.base00}";
        "editorHoverWidget.border" = "#${palette.base01}";
        "editorOverviewRuler.border" = "#${palette.base00}00";
        "editorOverviewRuler.findMatchForeground" = "#${palette.base04}";
        "editorOverviewRuler.rangeHighlightForeground" = "#${palette.base04}";
        "editorOverviewRuler.selectionHighlightForeground" =
          "#${palette.base03}";
        "editorOverviewRuler.wordHighlightForeground" = "#${palette.base03}";
        "editorOverviewRuler.wordHighlightStrongForeground" =
          "#${palette.base03}";
        "editorOverviewRuler.modifiedForeground" = "#${palette.base0D}";
        "editorOverviewRuler.addedForeground" = "#${palette.base0D}";
        "editorOverviewRuler.deletedForeground" = "#${palette.base0D}";
        "editorOverviewRuler.errorForeground" = "#${palette.base08}";
        "editorOverviewRuler.warningForeground" = "#d79921";
        "editorOverviewRuler.infoForeground" = "#${palette.base0E}";
        "editorGutter.background" = "#${palette.base00}00";
        "editorGutter.modifiedBackground" = "#${palette.base0D}";
        "editorGutter.addedBackground" = "#${palette.base0B}";
        "editorGutter.deletedBackground" = "#${palette.base08}";
        "editorError.foreground" = "#cc241d";
        "editorWarning.foreground" = "#d79921";
        "editorInfo.foreground" = "#458588";
        # EDITOR - BRACKET PAIR COLORIZATION
        "editorBracketHighlight.foreground1" = "#b16286";
        "editorBracketHighlight.foreground2" = "#458588";
        "editorBracketHighlight.foreground3" = "#689d6a";
        "editorBracketHighlight.foreground4" = "#98971a";
        "editorBracketHighlight.foreground5" = "#d79921";
        "editorBracketHighlight.foreground6" = "#${palette.base0F}";
        "editorBracketHighlight.unexpectedBracket.foreground" = "#cc241d";
        # DIFF EDITOR
        "diffEditor.insertedTextBackground" = "#${palette.base0B}30";
        "diffEditor.removedTextBackground" = "#${palette.base08}30";
        # WIDGET
        "editorWidget.background" = "#${palette.base00}";
        "editorWidget.border" = "#${palette.base01}";
        "editorSuggestWidget.background" = "#${palette.base00}";
        "editorSuggestWidget.foreground" = "#${palette.base06}";
        "editorSuggestWidget.highlightForeground" = "#689d6a";
        "editorSuggestWidget.selectedBackground" = "#${palette.base01}60";
        "editorSuggestWidget.border" = "#${palette.base01}";
        # PEEK VIEW
        "peekView.border" = "#${palette.base01}";
        "peekViewEditor.background" = "#${palette.base01}70";
        "peekViewEditor.matchHighlightBackground" = "#${palette.base02}";
        "peekViewEditorGutter.background" = "#${palette.base01}70";
        "peekViewResult.background" = "#${palette.base01}70";
        "peekViewResult.fileForeground" = "#${palette.base06}";
        "peekViewResult.selectionBackground" = "#45858820";
        "peekViewResult.selectionForeground" = "#${palette.base06}";
        "peekViewResult.lineForeground" = "#${palette.base06}";
        "peekViewResult.matchHighlightBackground" = "#${palette.base02}";
        "peekViewTitle.background" = "#${palette.base01}70";
        "peekViewTitleDescription.foreground" = "#${palette.base04}";
        "peekViewTitleLabel.foreground" = "#${palette.base06}";
        # MERGE CONFLICTS
        "merge.currentHeaderBackground" = "#45858840";
        "merge.currentContentBackground" = "#45858820";
        "merge.incomingHeaderBackground" = "#689d6a40";
        "merge.incomingContentBackground" = "#689d6a20";
        "merge.border" = "#${palette.base00}00";
        "editorOverviewRuler.currentContentForeground" = "#458588";
        "editorOverviewRuler.incomingContentForeground" = "#689d6a";
        "editorOverviewRuler.commonContentForeground" = "#928374";
        # PANELS
        "panel.background" = "#${palette.base01}";
        "panel.foreground" = "#${palette.base05}";
        "panel.border" = "#${palette.base01}";
        "panelTitle.activeForeground" = "#${palette.base06}";
        # STATUS BAR
        "statusBar.background" = "#${palette.base00}";
        "statusBar.border" = "#${palette.base01}";
        "statusBar.foreground" = "#${palette.base06}";
        "statusBar.debuggingBackground" = "#${palette.base09}";
        "statusBar.debuggingForeground" = "#${palette.base00}";
        "statusBar.debuggingBorder" = "#${palette.base00}00";
        "statusBar.noFolderBackground" = "#${palette.base00}";
        "statusBar.noFolderBorder" = "#${palette.base00}00";
        # INTEGRATED TERMINAL
        "terminal.ansiBlack" = "#${palette.base01}";
        "terminal.ansiBrightBlack" = "#928374";
        "terminal.ansiRed" = "#cc241d";
        "terminal.ansiBrightRed" = "#${palette.base08}";
        "terminal.ansiGreen" = "#98971a";
        "terminal.ansiBrightGreen" = "#${palette.base0B}";
        "terminal.ansiYellow" = "#d79921";
        "terminal.ansiBrightYellow" = "#${palette.base0A}";
        "terminal.ansiBlue" = "#458588";
        "terminal.ansiBrightBlue" = "#${palette.base0D}";
        "terminal.ansiMagenta" = "#b16286";
        "terminal.ansiBrightMagenta" = "#${palette.base0E}";
        "terminal.ansiCyan" = "#689d6a";
        "terminal.ansiBrightCyan" = "#${palette.base0C}";
        "terminal.ansiWhite" = "#a89984";
        "terminal.ansiBrightWhite" = "#${palette.base06}";
        "terminal.foreground" = "#${palette.base06}";
        "terminal.background" = "#${palette.base00}";
        # TITLE BAR macOS (not tested)
        "titleBar.activeBackground" = "#${palette.base00}";
        "titleBar.activeForeground" = "#${palette.base06}";
        "titleBar.inactiveBackground" = "#${palette.base00}";
        # GIT COLORS
        "gitDecoration.modifiedResourceForeground" = "#d79921";
        "gitDecoration.deletedResourceForeground" = "#cc241d";
        "gitDecoration.untrackedResourceForeground" = "#98971a";
        "gitDecoration.ignoredResourceForeground" = "#7c6f64";
        "gitDecoration.conflictingResourceForeground" = "#b16286";
        # MENU BAR
        "menu.border" = "#${palette.base01}";
        "menu.separatorBackground" = "#${palette.base01}";
        # JUPYTER NOTEBOOKS
        "notebook.cellEditorBackground" = "#282828";
        "notebook.focusedCellBorder" = "#a89984";
        "notebook.cellBorderColor" = "#${palette.base01}";
        "notebook.focusedEditorBorder" = "#${palette.base01}";
        # EXTENSIONS
        "extensionButton.prominentBackground" = "#${palette.base0B}80";
        "extensionButton.prominentHoverBackground" = "#${palette.base0B}30";
        # OTHERS
        "textLink.foreground" = "#${palette.base0D}";
        "textLink.activeForeground" = "#458588";
        "debugToolBar.background" = "#${palette.base00}";
      };
      "editor.tokenColorCustomizations" = {
        "nix-colors" = [

          { "settings" = { "foreground" = "#${palette.base06}"; }; }
          {
            "scope" = "emphasis";
            "settings" = { "fontStyle" = "italic"; };
          }
          {
            "scope" = "strong";
            "settings" = { "fontStyle" = "bold"; };
          }
          {
            "scope" = "header";
            "settings" = { "foreground" = "#458588"; };
          }
          {
            "scope" = [ "comment" "punctuation.definition.comment" ];
            "settings" = {
              "foreground" = "#928374";
              "fontStyle" = "italic";
            };
          }
          {
            "scope" = [ "constant" "support.constant" "variable.arguments" ];
            "settings" = { "foreground" = "#${palette.base0E}"; };
          }
          {
            "scope" = "constant.rgb-value";
            "settings" = { "foreground" = "#${palette.base06}"; };
          }
          {
            "scope" = "entity.name.selector";
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "entity.other.attribute-name";
            "settings" = { "foreground" = "#${palette.base0A}"; };
          }
          {
            "scope" = [ "entity.name.tag" "punctuation.tag" ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = [ "invalid" "invalid.illegal" ];
            "settings" = { "foreground" = "#cc241d"; };
          }
          {
            "scope" = "invalid.deprecated";
            "settings" = { "foreground" = "#b16286"; };
          }
          {
            "scope" = "meta.selector";
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "meta.preprocessor";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = "meta.preprocessor.string";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" = "meta.preprocessor.numeric";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" = "meta.header.diff";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = "storage";
            "settings" = { "foreground" = "#${palette.base08}"; };
          }
          {
            "scope" = [ "storage.type" "storage.modifier" ];
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = "string";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" = "string.tag";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" = "string.value";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" = "string.regexp";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = "string.escape";
            "settings" = { "foreground" = "#${palette.base08}"; };
          }
          {
            "scope" = "string.quasi";
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "string.entity";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" = "object";
            "settings" = { "foreground" = "#${palette.base06}"; };
          }
          {
            "scope" = "module.node";
            "settings" = { "foreground" = "#${palette.base0D}"; };
          }
          {
            "scope" = "support.type.property-name";
            "settings" = { "foreground" = "#689d6a"; };
          }
          {
            "scope" = "keyword";
            "settings" = { "foreground" = "#${palette.base08}"; };
          }
          {
            "scope" = "keyword.control";
            "settings" = { "foreground" = "#${palette.base08}"; };
          }
          {
            "scope" = "keyword.control.module";
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "keyword.control.less";
            "settings" = { "foreground" = "#d79921"; };
          }
          {
            "scope" = "keyword.operator";
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "keyword.operator.new";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = "keyword.other.unit";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" = "metatag.php";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = "support.function.git-rebase";
            "settings" = { "foreground" = "#689d6a"; };
          }
          {
            "scope" = "constant.sha.git-rebase";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "name" = "Types declaration and references";
            "scope" = [
              "meta.type.name"
              "meta.return.type"
              "meta.return-type"
              "meta.cast"
              "meta.type.annotation"
              "support.type"
              "storage.type.cs"
              "variable.class"
            ];
            "settings" = { "foreground" = "#${palette.base0A}"; };
          }
          {
            "scope" = [ "variable.this" "support.variable" ];
            "settings" = { "foreground" = "#${palette.base0E}"; };
          }
          {
            "scope" = [
              "entity.name"
              "entity.static"
              "entity.name.class.static.function"
              "entity.name.function"
              "entity.name.class"
              "entity.name.type"
            ];
            "settings" = { "foreground" = "#${palette.base0A}"; };
          }
          {
            "name" = "Function declarations";
            "scope" = [ "entity.function" "entity.name.function.static" ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "entity.name.function.function-call";
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "support.function.builtin";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = [
              "entity.name.method"
              "entity.name.method.function-call"
              "entity.name.static.function-call"
            ];
            "settings" = { "foreground" = "#689d6a"; };
          }
          {
            "scope" = "brace";
            "settings" = { "foreground" = "#${palette.base05}"; };
          }
          {
            "name" = "variables";
            "scope" = [
              "meta.parameter.type.variable"
              "variable.parameter"
              "variable.name"
              "variable.other"
              "variable"
              "string.constant.other.placeholder"
            ];
            "settings" = { "foreground" = "#${palette.base0D}"; };
          }
          {
            "scope" = "prototype";
            "settings" = { "foreground" = "#${palette.base0E}"; };
          }
          {
            "scope" = [ "punctuation" ];
            "settings" = { "foreground" = "#a89984"; };
          }
          {
            "scope" = "punctuation.quoted";
            "settings" = { "foreground" = "#${palette.base06}"; };
          }
          {
            "scope" = "punctuation.quasi";
            "settings" = { "foreground" = "#${palette.base08}"; };
          }
          {
            "name" = "URL";
            "scope" = [ "*url*" "*link*" "*uri*" ];
            "settings" = { "fontStyle" = "underline"; };
          }
          # ----------------------------------------
          #            LANGUAGE SPECIFIC
          # ----------------------------------------
          # PYTHON ----------------------------------------
          {
            "name" = "Python function";
            "scope" = [ "meta.function.python" "entity.name.function.python" ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "name" = "Python Function and Class definition keywords";
            "scope" = [
              "storage.type.function.python"
              "storage.modifier.declaration"
              "storage.type.class.python"
              "storage.type.string.python"
            ];
            "settings" = { "foreground" = "#${palette.base08}"; };
          }
          {
            "name" = "Async keyword";
            "scope" = [ "storage.type.function.async.python" ];
            "settings" = { "foreground" = "#${palette.base08}"; };
          }
          {
            "name" = "Python Function Call";
            "scope" = "meta.function-call.generic";
            "settings" = { "foreground" = "#${palette.base0D}"; };
          }
          {
            "name" = "Python Function Arguments";
            "scope" = "meta.function-call.arguments";
            "settings" = { "foreground" = "#${palette.base05}"; };
          }
          {
            "name" = "Python Function decorator";
            "scope" = "entity.name.function.decorator";
            "settings" = {
              "foreground" = "#${palette.base0A}";
              "fontStyle" = "bold";
            };
          }
          {
            "name" = "Python ALL CAPS";
            "scope" = "constant.other.caps";
            "settings" = { "fontStyle" = "bold"; };
          }
          # SHELL ----------------------------------------
          {
            "scope" = "keyword.operator.logical";
            "settings" = { "foreground" = "#${palette.base08}"; };
          }
          {
            "scope" = "punctuation.definition.logical-expression";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = [
              "string.interpolated.dollar.shell"
              "string.interpolated.backtick.shell"
            ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          # C C++ ----------------------------------------
          {
            "scope" = "keyword.control.directive";
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "support.function.C99";
            "settings" = { "foreground" = "#${palette.base0A}"; };
          }
          # C# ----------------------------------------
          {
            "name" = "C# functions & namespace";
            "scope" = [
              "meta.function.cs"
              "entity.name.function.cs"
              "entity.name.type.namespace.cs"
            ];
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "name" = "C# Variables";
            "scope" = [
              "keyword.other.using.cs"
              "entity.name.variable.field.cs"
              "entity.name.variable.local.cs"
              "variable.other.readwrite.cs"
            ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "name" = "C# This";
            "scope" = [ "keyword.other.this.cs" "keyword.other.base.cs" ];
            "settings" = { "foreground" = "#${palette.base0E}"; };
          }
          # MAKEFILE ----------------------------------------
          {
            "scope" = "meta.scope.prerequisites";
            "settings" = { "foreground" = "#${palette.base0A}"; };
          }
          {
            "scope" = "entity.name.function.target";
            "settings" = {
              "foreground" = "#${palette.base0B}";
              "fontStyle" = "bold";
            };
          }
          # JAVA ----------------------------------------
          {
            "name" = "coloring of the Java import and package identifiers";
            "scope" = [
              "storage.modifier.import.java"
              "storage.modifier.package.java"
            ];
            "settings" = { "foreground" = "#${palette.base04}"; };
          }
          {
            "scope" =
              [ "keyword.other.import.java" "keyword.other.package.java" ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "storage.type.java";
            "settings" = { "foreground" = "#${palette.base0A}"; };
          }
          {
            "scope" = "storage.type.annotation";
            "settings" = {
              "foreground" = "#${palette.base0D}";
              "fontStyle" = "bold";
            };
          }
          {
            "scope" = "keyword.other.documentation.javadoc";
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" = "comment.block.javadoc variable.parameter.java";
            "settings" = {
              "foreground" = "#${palette.base0B}";
              "fontStyle" = "bold";
            };
          }
          {
            "scope" = [
              "source.java variable.other.object"
              "source.java variable.other.definition.java"
            ];
            "settings" = { "foreground" = "#${palette.base06}"; };
          }
          # LISP ----------------------------------------
          {
            "name" = "Lisp optional function parameters";
            "scope" = "meta.function-parameters.lisp";
            "settings" = { "foreground" = "#${palette.base0A}"; };
          }
          # MARKUP ----------------------------------------
          {
            "scope" = "markup.underline";
            "settings" = { "fontStyle" = "underline"; };
          }
          {
            "scope" = "string.other.link.title.markdown";
            "settings" = {
              "foreground" = "#928374";
              "fontStyle" = "underline";
            };
          }
          {
            "scope" = "markup.underline.link";
            "settings" = { "foreground" = "#${palette.base0E}"; };
          }
          {
            "scope" = "markup.bold";
            "settings" = {
              "fontStyle" = "bold";
              "foreground" = "#${palette.base09}";
            };
          }
          {
            "scope" = "markup.heading";
            "settings" = {
              "fontStyle" = "bold";
              "foreground" = "#${palette.base09}";
            };
          }
          {
            "scope" = "markup.italic";
            "settings" = { "fontStyle" = "italic"; };
          }
          {
            "scope" = "markup.inserted";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" = "markup.deleted";
            "settings" = { "foreground" = "#${palette.base0F}"; };
          }
          {
            "scope" = "markup.changed";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = "markup.punctuation.quote.beginning";
            "settings" = { "foreground" = "#98971a"; };
          }
          {
            "scope" = "markup.punctuation.list.beginning";
            "settings" = { "foreground" = "#${palette.base0D}"; };
          }
          {
            "scope" = [ "markup.inline.raw" "markup.fenced_code.block" ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          # JSON ----------------------------------------
          {
            "scope" = "string.quoted.double.json";
            "settings" = { "foreground" = "#${palette.base0D}"; };
          }
          {
            "name" = "JSON Level 0";
            "scope" = [
              "source.json meta.structure.dictionary.json support.type.property-name.json"
            ];
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "name" = "JSON Level 1";
            "scope" = [
              "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
            ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "name" = "JSON Level 2";
            "scope" = [
              "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
            ];
            "settings" = { "foreground" = "#${palette.base0E}"; };
          }
          {
            "name" = "JSON Level 3";
            "scope" = [
              "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
            ];
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          # CSS ----------------------------------------
          {
            "scope" = "entity.other.attribute-name.css";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = "source.css meta.selector";
            "settings" = { "foreground" = "#${palette.base06}"; };
          }
          {
            "scope" = "support.type.property-name.css";
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "scope" = "entity.other.attribute-name.class";
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" = [
              "source.css support.function.transform"
              "source.css support.function.timing-function"
              "source.css support.function.misc"
            ];
            "settings" = { "foreground" = "#${palette.base08}"; };
          }
          {
            "name" = "CSS property value";
            "scope" = [
              "support.property-value"
              "constant.rgb-value"
              "support.property-value.scss"
              "constant.rgb-value.scss"
            ];
            "settings" = { "foreground" = "#${palette.base0F}"; };
          }
          {
            "scope" = [ "entity.name.tag.css" ];
            "settings" = { "fontStyle" = ""; };
          }
          # HTML / XML ----------------------------------------
          {
            "scope" = [ "punctuation.definition.tag" ];
            "settings" = { "foreground" = "#${palette.base0D}"; };
          }
          {
            "scope" =
              [ "text.html entity.name.tag" "text.html punctuation.tag" ];
            "settings" = {
              "foreground" = "#${palette.base0C}";
              "fontStyle" = "bold";
            };
          }
          # javascript ---------------------------------------
          {
            "scope" = [ "source.js variable.language" ];
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          # typescript ---------------------------------------
          {
            "scope" = [ "source.ts variable.language" ];
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          # golang --------------------------------------------
          {
            "scope" = [ "source.go storage.type" ];
            "settings" = { "foreground" = "#${palette.base0A}"; };
          }
          {
            "scope" = [ "source.go entity.name.import" ];
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "scope" =
              [ "source.go keyword.package" "source.go keyword.import" ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "scope" =
              [ "source.go keyword.interface" "source.go keyword.struct" ];
            "settings" = { "foreground" = "#${palette.base0D}"; };
          }
          {
            "scope" = [ "source.go entity.name.type" ];
            "settings" = { "foreground" = "#${palette.base06}"; };
          }
          {
            "scope" = [ "source.go entity.name.function" ];
            "settings" = { "foreground" = "#${palette.base0E}"; };
          }
          # cucumber
          {
            "scope" = [ "keyword.control.cucumber.table" ];
            "settings" = { "foreground" = "#${palette.base0D}"; };
          }
          # REASONML ------------------------------------
          {
            "name" = "ReasonML String";
            "scope" =
              [ "source.reason string.double" "source.reason string.regexp" ];
            "settings" = { "foreground" = "#${palette.base0B}"; };
          }
          {
            "name" = "ReasonML equals sign";
            "scope" = [ "source.reason keyword.control.less" ];
            "settings" = { "foreground" = "#${palette.base0C}"; };
          }
          {
            "name" = "ReasonML variable";
            "scope" = [ "source.reason entity.name.function" ];
            "settings" = { "foreground" = "#${palette.base0D}"; };
          }
          {
            "name" = "ReasonML property";
            "scope" = [
              "source.reason support.property-value"
              "source.reason entity.name.filename"
            ];
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          # POWERSHELL ------------------------------------
          {
            "name" = "Powershell member";
            "scope" = [ "source.powershell variable.other.member.powershell" ];
            "settings" = { "foreground" = "#${palette.base09}"; };
          }
          {
            "name" = "Powershell function";
            "scope" = [ "source.powershell support.function.powershell" ];
            "settings" = { "foreground" = "#${palette.base0A}"; };
          }
          {
            "name" = "Powershell function attribute";
            "scope" =
              [ "source.powershell support.function.attribute.powershell" ];
            "settings" = { "foreground" = "#${palette.base04}"; };
          }
          {
            "name" = "Powershell hashtable member";
            "scope" = [
              "source.powershell meta.hashtable.assignment.powershell variable.other.readwrite.powershell"
            ];
            "settings" = { "foreground" = "#${palette.base09}"; };
          }

        ];
      };
    };
}
