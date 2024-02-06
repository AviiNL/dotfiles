{ config, pkgs, ... }: {
  home.packages = with pkgs.cinnamon; [ nemo-with-extensions ];

  xdg.dataFile."nemo/actions/vscode.nemo_action".text = ''
    [Nemo Action]

    Active=true
    Name=Open in VS Code
    Comment=Opens current folder in VS Code
    Exec=code %P
    Selection=none
    Extensions=any;
    Quote=double
    Dependencies=code;
  '';

  xdg.dataFile."nemo/actions/kitty.nemo_action".text = ''
    [Nemo Action]

    Active=true
    Name=Open in Kitty
    Comment=Opens current folder in Kitty
    Exec=kitty %P
    Selection=none
    Extensions=any;
    Quote=double
    Dependencies=kitty;
  '';

}
