{ config, pkgs, ... }: {
  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = ../config/nushell.nu;
      # for editing directly to config.nu 
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
        }
        $env.config = {
            show_banner: false,
            completions: {
                case_sensitive: false # case-sensitive completions
                quick: true    # set to false to prevent auto-selecting completions
                partial: true    # set to false to prevent partial filling of the prompt
                algorithm: "fuzzy"    # prefix or fuzzy
                external: {
                # set to false to prevent nushell looking into $env.PATH to find more suggestions
                    enable: true 
                # set to lower can improve completion performance at the cost of omitting some options
                    max_results: 100 
                    completer: $carapace_completer # check 'carapace_completer' 
                }
            }
        } 
        $env.PATH = ($env.PATH | split row (char esep) | prepend /home/myuser/.apps | append /usr/bin/env)

        $env.DIRENV_LOG_FORMAT = ""

        # $env.config.hooks.env_change.PWD = { ||
        #   if (which direnv | is-empty) {
        #       return
        #   }

        #   # direnv export json | from json | default {} | load-env | ignore
        # }

        def rebuild [profile?: string] {
            let p = if ($profile == null) {
                (hostname)
            } else {
                $profile
            }
            let base = "sudo nixos-rebuild switch --option eval-cache false --cores 10 --max-jobs 2 --flake ~/dotfiles#"
            let cmd = $base + $p
            echo $cmd
            nu -c $cmd
        }

        def killall [name: string, signal?: int] {
          let s = if ($signal == null) {
            1
          } else {
            $signal
          }
          ps | find $name | each {|p| kill -s $signal $p.pid} | ignore
        }
      '';
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        nano = "nvim";
      };
    };

    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    atuin = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        sync_address = "https://atuin.avii.nl";
        filter_mode_shell_up_key_binding = "session";
        filter_mode = "session";
        enter_accept = true;
        # key_path = config.sops.secrets."atuin_key".path;
      };
    };
  };

  #    sops.secrets = {
  #        "atuin_key".sopsFile = ../secrets.yaml;
  #    };
}
