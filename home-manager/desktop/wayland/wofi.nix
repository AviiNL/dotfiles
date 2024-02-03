{ config, lib, pkgs, ... }: {
  programs.wofi = {
    enable = true;
    package = pkgs.wofi.overrideAttrs (oa: {
      patches = (oa.patches or [ ]) ++ [
        ./wofi-run-shell.patch # Fix for https://todo.sr.ht/~scoopta/wofi/174
      ];
    });
    settings = {
      image_size = 48;
      columns = 3;
      allow_images = true;
      insensitive = true;
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
    };

    # TODO: Convert to using nix-colors
    style = ''
      * {
        font-family: "FiraCode Nerd Font";
        border: none;
        outline: none;
      }

      #window {
        background-color: transparent;
      }

      #entry {
        border: none;
        color: #AAA;
      }

      #input {
        margin: 5px 250px 0px 250px;
        border-radius: 25px;
        padding: 5px 25px;
        border: 1px solid gray;
      }

      #scroll {
        margin: 0px 350px;
        background-color: rgba(10, 10, 10, 0.80);
        border-radius: 0px 0px 25px 25px;
        font-size: 1em;
        padding: 10px;
        # padding-right: 100px;
      }

      #outer-box {
        margin: 5px;
        border: none;
        /*border: 3px solid green;*/
      }

      #inner-box {
        padding: 5px;
        border: none;
        /*border: 6px dotted purple;*/
      }

      #text {
        /*margin: 5px;*/
        padding: 5px;
        /*color: #1a1a1a; */
        border: none;
        /*border: 3px solid white;*/
      }

      /*entry:unselected {*/
      /*color: rgba(217, 216, 216, 1);*/
      /*}*/

      #entry:selected {
        background-color: rgba(76, 76, 76, 0.60);
        color: #FFF;
        font-weight: 600;
        /*border: 3px solid red;*/
        /*word-wrap: break-word;*/
      }
    '';
  };

  home.packages = let inherit (config.programs.password-store) package enable;
  in lib.optional enable (pkgs.pass-wofi.override { pass = package; });
}
